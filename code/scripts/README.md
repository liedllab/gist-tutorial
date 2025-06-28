The following scripts are made available:
- [cpptraj_remove_mol.sh](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/cpptraj_remove_mol.sh):   
  Runs [cpptraj](https://github.com/Amber-MD/cpptraj) to remove a molecule given by their index from a MD trajectory (or other input file as accepted by cpptraj).   
  Usage:

        cpptraj_remove_mol.sh TOPOLOGY COORDINATES MOL_IX OUTTOPOLOGY OUTTRAJECTORY
  Example:

        cpptraj_remove_mol.sh complex.parm7 complex.rst 2 apo.parm7 apo.rst

- [equilibration.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/equilibration.py):   
  Runs a simple equilibration protocol using [AMBER's pmemd.cuda simulation engine](https://ambermd.org/).   
  The input is minimized, heated to 300K in the NVT ensemble and pressurized to 1 bar in NPT (first restrained, then unrestrained).   
  Usage \[with optional arguments in brackets\]:

        equilibration.py TOPOLOGY COORDINATES [-r RESTRAINT_MASK -R]
  Everything but the hydrogen atoms is restrained. -r defaults to '!(:WAT,NA,CL)', leaving the solvent unrestrained as well.
  The restraint mask is given in [AMBER syntax](https://amberhub.chpc.utah.edu/atom-mask-selection-syntax/)
  Optionally, the last, unrestrained NPT step can be skipped by setting the -R flag.   
  Example:

        equilibration.py complex.parm7 complex.rst -r !(:WAT) -R

- [findcentroid.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/findcentroid.py):   
  Suggests a grid dimension / number of voxels for a GIST calculation based on coordinates in a PDB file.   
  The dimension is adjusted such that the whole structure is enclosed, and a user-defined grid spacing is added in all directions.   
  Usage:
  
        findcentroid.py PDB [-d WALLDISTANCE -s GRIDSPACING -sel SELECTIONMASK]
  -d defaults to a walldisance of 10 angstrom in all directions, -s defaults to a grid spacing of 0.5 angstrom and the selection mask defaults to 'not resname NA CL MG CA WAT HOH', i.e. excludes the solvent.   
  The selection mask is given in [MDtraj syntax](https://mdtraj.org/1.9.4/atom_selection.html).
  Example:
  
        findcentroid.py complex.pdb -d 15 -s 0.5 -sel 'not water']

- [get-dx-files.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/get-dx-files.py):
  Outputs .dx files from a GIST output file. These contain the thermodynamic properties formatted in a grid file readable by most visualisation software (e.g. PyMOL).
  Usage:

      get-dx-files.py GISTOUTPUT PDB OUTBASENAME --ewwref EWWREF --columns COL_A COL_B COL_C ...
  The pdb file needs to contain the solute structure (without solvent) used in the GIST calculation.   
  OUTBASENAME is included in the dx file names as a prefix, e.g. OUTBASENAME-A_dens.dx.   
  If EWWREF is not set or set to 0 (default), the reference value for Eww will be automatically determined.   
  The output columns are per default: A_dens (the free energy), A2_dens, Eall_dens (the energy), Eall2_dens and dTSsix_dens (entropy).   
  Eall2 is simply Eall\*2 and A2_dens is then Eall\*2-dTSsix.
  Example:

      get-dx-files.py gist.dat gist_nowat.pdb gist --ewwref -9.5398 --columns A_dens Eall_dens Eww_dens
  
    
