The following scripts are made available:
- [cpptraj_remove_mol.sh](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/cpptraj_remove_mol.sh):   
  Removes a molecule from a topology and coordinate file using `[cpptraj](https://github.com/Amber-MD/cpptraj)`.
  
  **Usage:**
  ```bash
  cpptraj_remove_mol.sh TOPOLOGY COORDINATES MOL_IX OUT_TOPOLOGY OUT_COORDINATES
  ```
  - `TOPOLOGY`: Input topology file (e.g., AMBER .parm7).
  - `COORDINATES`: Input coordinate/trajectory file (e.g., .rst7, .nc).
  - `MOL_IX`: Topology index of the molecule to remove (starting from 1).
  - `OUT_TOPOLOGY`: Path for the output topology file.
  - `OUT_COORDINATES`: Path for the output coordinate file.

  **Example:**
  ```bash
  # Remove the second molecule (ligand) from complex files to create apo files
  cpptraj_remove_mol.sh complex.parm7 complex.rst7 2 apo.parm7 apo.rst7
  ```

- [equilibration.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/equilibration.py):   
  Runs a simple MD equilibration protocol (minimization, NVT heating to 300K, NPT equilibration to 1 bar) using [AMBER's `pmemd.cuda` simulation engine](https://ambermd.org/).
  
  **Usage:**
  ```bash
  equilibration.py TOPOLOGY COORDINATES [OPTIONS]
  ```
  - `TOPOLOGY`: AMBER .parm7 topology file.
  - `COORDINATES`: AMBER .rst7 coordinate file.
  
  **Options:**
  - `-r RESTRAINT_MASK`: [AMBER syntax atom mask](https://amberhub.chpc.utah.edu/atom-mask-selection-syntax/) for positional restraints. H atoms are generally left unrestrained. Defaults to `'!(:WAT,NA,CL)'`, restraining all non-solvent heavy atoms.
  - `-R`: If set, the script will only run the restrained portion of the equilibration and skip the final unrestrained NPT step.

  **Example:**
  ```bash
  # Run a full equilibration, restraining only non-water heavy atoms
  equilibration.py complex.parm7 complex.rst7 -r '!(:WAT)'
  ```

- [findcentroid.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/findcentroid.py):   
  Suggests grid parameters for a GIST calculation based on the dimensions of a atom selection from a PDB file.
  
  **Usage:**
  ```bash
  findcentroid.py PDB_FILE [OPTIONS]
  ```
  - `PDB_FILE`: Path to the PDB file.

  **Options:**
  - `-d WALL_DISTANCE`: Distance to add around the selection to define the grid boundary. Default: `10.0` Å.
  - `-s GRID_SPACING`: Grid voxel size. Default: `0.5` Å.
  - `-sel SELECTION_MASK`: [MDTraj selection string](https://mdtraj.org/1.9.4/atom_selection.html) to define the solute. Default: `'not resname NA CL MG CA WAT HOH'`.

  **Example:**
  ```bash
  # Suggest grid parameters for a PDB, with a 15 Å wall distance and selecting only the residue named BTN
  findcentroid.py complex.pdb -d 15 -sel 'resname BTN'
  ```

- [get-dx-files.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/get-dx-files.py):
  Generates `.dx` grid files for visualization from a GIST output file.
  
  **Usage:**
  ```bash
  get-dx-files.py GIST_OUTPUT PDB_FILE OUT_BASENAME [OPTIONS]
  ```
  - `GIST_OUTPUT`: GIST output data file (e.g., `gist.dat`).
  - `PDB_FILE`: PDB file of the solute used in the GIST calculation.
  - `OUT_BASENAME`: Prefix for the output `.dx` files.

  **Options:**
  - `--ewwref EWW_REF`: Reference water-water energy value. If not set, it will be auto-detected.
  - `--columns COLS`: A list of data columns from the GIST output to convert to `.dx` files. Default: `A_dens Eall_dens Eall2_dens A2_dens dTSsix_dens`.

  **Example:**
  ```bash
  # Generate dx files for energy and entropy, specifying a reference energy
  get-dx-files.py gist.dat gist_solute.pdb gist_results --ewwref -9.54 --columns Eall_dens dTSsix_dens
  ```

- [run-md.sh](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/run-md.sh):
  Runs a 100ns NPT production MD simulation with restraints using AMBER's `pmemd.cuda`.
  
  **Usage:**
  ```bash
  run-md.sh TOPOLOGY COORDINATES
  ```
  - `TOPOLOGY`: AMBER .parm7 topology file.
  - `COORDINATES`: AMBER .rst7 coordinate file.

  **Example:**
  ```bash
  # Run a production simulation
  run-md.sh solvated.parm7 equilibration.rst7
  ```


