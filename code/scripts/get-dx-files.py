#!/usr/bin/env python
# -*- coding: utf-8 -*-

import gisttools as gt


def main():
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("gistfile")
    parser.add_argument("pdb")
    parser.add_argument("out_base", help="Base name for output files, e.g. OUT_BASE-Eall_dens.dx")
    parser.add_argument("--columns", nargs="+", default=["A_dens", "Eall_dens", "Eall2_dens", "A2_dens"])
    args = parser.parse_args()
    gistfile = gt.gist.load_gist_file(args.gistfile, struct=args.pdb)
    gistfile.struct = remove_solvent(gistfile.struct)
    assert 0.03 < gistfile.rho0 < 0.04, "Unusual reference density!"
    gistfile.eww_ref = gistfile.detect_reference_value()
    gistfile["Eww2_dens"] = gistfile["Eww_dens"] * 2
    gistfile["Eall2_dens"] = gistfile["Eww2_dens"] + gistfile["Esw_dens"]
    gistfile["A2_dens"] = gistfile["Eall2_dens"] - gistfile["dTSsix_dens"]
    print("Settings")
    print(f"Input GIST file: {args.gistfile}")
    print(f"Input PDB file: {args.pdb}")
    print(f"Detected rho0: {gistfile.rho0}")
    print(f"Detected reference energy: {gistfile.eww_ref}")
    for col in args.columns:
        col_fname = col.replace("_", "-")
        fname = f"{args.out_base}-{col_fname}.dx"
        gistfile.save_dx(col, fname)


def remove_solvent(traj):
    not_water = traj.top.select("not resname WAT HOH NA CL")
    return traj.atom_slice(not_water)


if __name__ == "__main__":
    main()
