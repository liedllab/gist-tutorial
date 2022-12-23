"""
Suggests a grid dimension for a GIST calculation based on coordinates in a PDB
file.  The dimension is adjusted such that the whole structure is enclosed, and
a user-defined grid spacing is added in all directions.

By default, some ions and water molecules are removed from the PDB file. This
can be adjusted by supplying an MDTraj selection mask.  This can also be used
to select just one molecule (e.g., a ligand) from the PDB.
"""
import argparse

import mdtraj as md
import numpy as np

def main():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('pdb')
    parser.add_argument('-d', '--wall_distance', default=10., type=float)
    parser.add_argument('-s', '--grid_spacing', default=0.5, type=float)
    parser.add_argument('-sel', '--selection_mask', default='not resname NA CL MG CA WAT HOH')
    args = parser.parse_args()
    pdb = md.load_frame(args.pdb, 0)
    selected = pdb.top.select(args.selection_mask)
    print(f"{len(selected)} of {pdb.n_atoms} atoms selected.")
    # coordinates of selected atoms in Angstrom.
    crd = pdb.atom_slice(selected).xyz[0] * 10.
    crd_extent = crd.max(0) - crd.min(0)
    grid_extent = crd_extent + 2 * args.wall_distance
    center = (crd.max(0) + crd.min(0)) / 2
    dim = np.ceil(grid_extent / args.grid_spacing).astype(int)
    print("Coordinates center:", center)
    print("Coordinates extent:", crd_extent)
    print("Grid extent (coordinates + wall distance):", grid_extent)
    print("Recommended grid dimension", dim)

    print("Run GIST as follows:")
    print(
        "gist "
        + f"gridspacn {args.grid_spacing} "
        + "gridcntr {:.1f} {:.1f} {:.1f} ".format(*center)
        + "griddim {} {} {}".format(*dim)
    )

if __name__ == "__main__":
    main()
