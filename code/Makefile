SCRIPTS_DIR := scripts

.PHONY: all
all: 

biotin/equil/EQUIL-DONE.rst: biotin/equil/ biotin/solvated.parm7 biotin/pre-equil.ncrst
	cd biotin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/equil/EQUIL-DONE.rst: streptavidin/equil/ streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst
	cd streptavidin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst: streptavidin/ $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst
	$(word 2,$^) complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst 2 streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst

biotin/solvated.parm7 biotin/pre-equil.ncrst: biotin/ $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst
	$(word 2,$^) complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst 1 biotin/solvated.parm7 biotin/pre-equil.ncrst

complex/equil/EQUIL-DONE.rst: complex/equil/solvated.parm7 complex/equil/solvated.rst7
	cd complex/equil/ && ../../$(SCRIPTS_DIR)/equilibration.py solvated.parm7 solvated.rst7

complex/equil/solvated.%: complex/prep/solvated.%
	mkdir -p complex/equil && cp $^ $@

LEAP_DIR=complex/prep
complex/prep/solvated.parm7 complex/prep/solvated.rst7: $(LEAP_DIR)/leap.in $(LEAP_DIR)/BTN.frcmod $(LEAP_DIR)/BTN.prep $(LEAP_DIR)/1stp-prepped.pdb
	cd $(LEAP_DIR) && tleap -f leap.in

%/:
	mkdir -p $@
