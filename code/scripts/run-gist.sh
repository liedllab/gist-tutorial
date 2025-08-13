#!/bin/bash

# This script prepares and runs a GIST calculation for a given system.
# It first determines the optimal grid size and then runs the GIST analysis
# using cpptraj.
#
# Usage: ./run-gist.sh <system_name> <topology> <trajectory> [options]
# Example: ./run-gist.sh biotin system.prmtop production.nc --grid-spacing 0.5 --offset 30

set -e

HELPMESSAGE="This script runs a GIST analysis for a specified system using cpptraj.
It requires a topology file and a trajectory file from a previous MD simulation.

Usage:
$0 <system_name> <topology> <trajectory> [options]

Required arguments:
  system_name     Name of the system (e.g., biotin, streptavidin, complex)
  topology        Path to topology file (.prmtop, .parm7, etc.)
  trajectory      Path to trajectory file (.nc, .mdcrd, etc.)

Optional arguments:
  --grid-spacing FLOAT    Grid spacing in Angstroms (default: 0.5)
  --offset FLOAT          Buffer around solute in voxels 
                          (default: 30, which corresponds to 15 Angstroms with a 0.5A grid spacing)
  --refdens FLOAT         Reference density for water (default: 0.03287)
  --solute-mask STRING    Solute mask for cpptraj (default: '!(:WAT)')
  --system-dir PATH       System directory path (default: ../<system_name>)
  --griddims "X Y Z"      Specify grid dimensions directly (skips bounds calculation)
  --pme                   Use PME for GIST calculation (default: no PME)
  --cpptraj-exec PATH     Name of cpptraj executable 
                          (default: cpptraj.cuda, for GPU support
                          To run GIST with MPI, set this to 'mpirun cpptraj.MPI' or similar)
  --help, -h              Show this help message

Examples:
  $0 biotin system.prmtop production.nc
  $0 complex complex.prmtop prod.nc --grid-spacing 0.5 --offset 40
  $0 biotin topology.parm7 trajectory.mdcrd --griddims "100 100 140" --pme
  $0 biotin topology.parm7 trajectory.mdcrd --refdens 0.03287 --solute-mask '!(:WAT,Cl-,Na+)'"

# Default values
GRID_SPACING="0.5" # Default grid spacing in Angstroms
OFFSET="30" # Buffer around solute in Voxels, e.g. 30 x 0.5A = 15A buffer
REFDENS="0.03287" # Default reference density for TIP3P water
SOLUTE_MASK="!(:WAT)"
PME='' # No PME per default, set to 'pme' if needed or via command line
CPPTRAJ_EXEC="cpptraj.cuda" # Default to cpptraj with CUDA support for GPU GIST
GRIDDIMS="" # User-specified grid dimensions (optional)

# Parse command line arguments
if [ "$#" -lt 2 ]; then
    echo "Error: Insufficient arguments."
    echo "$HELPMESSAGE"
    exit 1
fi
TOPOLOGY="$1" 
TRAJECTORY="$2"
shift 2

# Parse optional arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --grid-spacing)
            GRID_SPACING="$2"
            shift 2
            ;;
        --offset)
            OFFSET="$2"
            shift 2
            ;;
        --refdens)
            REFDENS="$2"
            shift 2
            ;;
        --solute-mask)
            SOLUTE_MASK="$2"
            shift 2
            ;;
        --system-dir)
            SYSTEM_DIR="$2"
            shift 2
            ;;
        --griddims)
            GRIDDIMS="$2"
            shift 2
            ;;
        --help|-h)
            echo "$HELPMESSAGE"
            exit 0
            ;;
        --pme)
            PME='pme'
            shift
            ;;
        --cpptraj-exec)
            CPPTRAJ_EXEC="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option $1"
            echo "$HELPMESSAGE"
            exit 1
            ;;
    esac
done

# Set system directory if not provided via --system-dir
if [ -z "${SYSTEM_DIR}" ]; then
    SYSTEM_DIR="../${SYSTEM}"
fi

GIST_DIR="${SYSTEM_DIR}/gist"

# Check for required files
if [ ! -f "$TOPOLOGY" ] || [ ! -f "$TRAJECTORY" ]; then
    echo "Error: Topology or trajectory file not found for system '${SYSTEM}'."
    echo "Looked for ${TOPOLOGY} and ${TRAJECTORY}"
    echo "Please run the MD simulation first (e.g., 'make gist-md-inputs')."
    exit 1
fi

# Create GIST directory
mkdir -p "${GIST_DIR}"
cd "${GIST_DIR}"

# Always create a stripped PDB for reference
echo "--- Creating centered solute PDB for reference ---"
CENTERED_PDB="${SYSTEM}-centered.pdb"
STRIP_IN="strip.in"

cat > "${STRIP_IN}" <<EOF
# Load topology and a single frame
parm ${TOPOLOGY}
trajin ${TRAJECTORY} 1 1 1

# Reimage and center the solute at the origin
autoimage${SOLUTE_MASK} origin

# Create a PDB of the centered solute for reference
strip :WAT
trajout ${CENTERED_PDB}
go
EOF

${CPPTRAJ_EXEC} -i "${STRIP_IN}" > strip.log

# Determine grid dimensions
if [ -n "${GRIDDIMS}" ]; then
    echo "--- Using user-specified grid dimensions: ${GRIDDIMS} ---"
    GRID_DIMS="${GRIDDIMS}"
else
    echo "--- Determining grid boundaries for ${SYSTEM} ---"

    # Create cpptraj input for calculating bounds only
    BOUNDS_IN="bounds.in"
    BOUNDS_DAT="bounds.dat"

    cat > "${BOUNDS_IN}" <<EOF
# Load topology and a single frame
parm ${TOPOLOGY}
trajin ${TRAJECTORY} 1 1 1

# Reimage and center the solute at the origin
autoimage ${SOLUTE_MASK} origin

# Calculate grid bounds
bounds ${SOLUTE_MASK} dx ${GRID_SPACING} offset ${OFFSET} name Grid out ${BOUNDS_DAT}
go
EOF

    ${CPPTRAJ_EXEC} -i "${BOUNDS_IN}" > bounds.log

    # Extract grid dimensions from bounds.dat
    GRID_DIMS=$(awk -F'Bins=' '{print $2}' ${BOUNDS_DAT} | tr '\n' ' ' | awk '{print $1, $2, $3}')
    if [ -z "${GRID_DIMS}" ]; then
        echo "Error: Could not determine grid dimensions from ${BOUNDS_DAT}."
        exit 1
    fi
    echo "Determined grid dimensions: ${GRID_DIMS}"
fi

echo "--- Running GIST analysis for ${SYSTEM} ---"

# Create cpptraj input for GIST calculation
GIST_IN="gist.in"

cat > "${GIST_IN}" <<EOF
# Load topology and full trajectory
parm ${TOPOLOGY}
trajin ${TRAJECTORY}

# Reimage and center the solute at the origin
autoimage
center ${SOLUTE_MASK} origin

# Run GIST analysis
gist griddim ${GRID_DIMS} gridspacn ${GRID_SPACING} out gist.dat refdens ${REFDENS} ${PME}
go
EOF

echo "Running GIST with cpptraj. This may take a while..."
${CPPTRAJ_EXEC} -i "${GIST_IN}" > gist.log

echo "--- GIST calculation for ${SYSTEM} complete ---"
echo "Output files are in ${GIST_DIR}"
echo "Log file: ${GIST_DIR}/gist.log"
echo "GIST data: ${GIST_DIR}/gist.dat and .dx files"
