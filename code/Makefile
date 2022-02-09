SCRIPTS_DIR := scripts

.PHONY: all
all: 

.PHONY: gist-md-inputs
gist-md-inputs: biotin/gist/run-md.sh streptavidin/gist/run-md.sh complex/gist/run-md.sh

%/gist/run-md.sh %/gist/solvated.parm7 %/gist/EQUIL-DONE.rst: %/gist/ %/solvated.parm7 %/equil/EQUIL-DONE.rst scripts/run-md.sh
	cp $(word 2,$^) $(word 1,$^)
	cp $(word 3,$^) $(word 1,$^)
	cp $(word 4,$^) $(word 1,$^)

.PHONY: equilibration-targets
equilibration-targets: biotin/equil/EQUIL-DONE.rst streptavidin/equil/EQUIL-DONE.rst complex/equil/EQUIL-DONE.rst

biotin/equil/EQUIL-DONE.rst: biotin/equil/ biotin/solvated.parm7 biotin/pre-equil.ncrst
	cd biotin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/equil/EQUIL-DONE.rst: streptavidin/equil/ streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst
	cd streptavidin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst: streptavidin/ $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst
	$(word 2,$^) complex/solvated.parm7 complex/equil/EQUIL-DONE.rst 2 streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst

biotin/solvated.parm7 biotin/pre-equil.ncrst: biotin/ $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/equil/solvated.parm7 complex/equil/EQUIL-DONE.rst
	$(word 2,$^) complex/solvated.parm7 complex/equil/EQUIL-DONE.rst 1 biotin/solvated.parm7 biotin/pre-equil.ncrst

complex/equil/EQUIL-DONE.rst: complex/solvated.parm7 complex/equil/solvated.rst7
	cd complex/equil/ && ../../$(SCRIPTS_DIR)/equilibration.py ../solvated.parm7 solvated.rst7

complex/equil/solvated.%: complex/prep/solvated.%
	mkdir -p complex/equil && cp $^ $@

LEAP_DIR=complex/prep
complex/solvated.parm7 complex/prep/solvated.rst7: $(LEAP_DIR)/leap.in $(LEAP_DIR)/BTN.frcmod $(LEAP_DIR)/BTN.prep $(LEAP_DIR)/1stp-prepped.pdb
	cd $(LEAP_DIR) && tleap -f leap.in

%/:
	mkdir -p $@
