The following scripts are made available:
- [cpptraj_remove_mol.sh](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/cpptraj_remove_mol.sh):   
  Runs [cpptraj](https://github.com/Amber-MD/cpptraj) to remove a molecule given by their index from a MD trajectory (or other input file as accepted by cpptraj).   
  Usage:

        cpptraj_remove_mol.sh TOPOLOGY COORDINATES MOL_IX OUTTOPOLOGY OUTTRAJECTORY

- [equilibration.py](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/scripts/equilibration.py):   
  Runs a simple equilibration protocol using [AMBER's pmemd.cuda simulation engine](https://ambermd.org/).   
  The input is minimized, heated to 300K in the NVT ensemble and pressurized to 1 bar in NPT (first restrained, then unrestrained).   
  Usage \[with optional arguments in brackets\]:

        equilibration.py TOPOLOGY COORDINATES [-r RESTRAINT_MASK -R]
  
  Everything but the hydrogen atoms is restrained. -r defaults to '!(:WAT,NA,CL)', leaving the solvent unrestrained as well.   
  Optionally, the last, unrestrained NPT step can be skipped by setting the -R flag.   
  
