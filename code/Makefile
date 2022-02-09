.SECONDARY:

SCRIPTS_DIR := scripts

.PHONY: all
all: 

.PHONY: gist-md-inputs
gist-md-inputs: biotin/gist/run-md.sh streptavidin/gist/run-md.sh complex/gist/run-md.sh

%/gist/run-md.sh %/gist/solvated.parm7 %/gist/EQUIL-DONE.rst: %/solvated.parm7 %/equil/EQUIL-DONE.rst scripts/run-md.sh
	$(eval directory=$(dir $@))
	mkdir -p $(directory)
	cp $(word 1,$^) $(directory)
	cp $(word 2,$^) $(directory)
	cp $(word 3,$^) $(directory)

.PHONY: equilibration-targets
equilibration-targets: biotin/equil/EQUIL-DONE.rst streptavidin/equil/EQUIL-DONE.rst complex/equil/EQUIL-DONE.rst

biotin/equil/EQUIL-DONE.rst: biotin/solvated.parm7 biotin/pre-equil.ncrst
	mkdir -p biotin/equil/
	cd biotin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/equil/EQUIL-DONE.rst: streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst
	mkdir -p streptavidin/equil/
	cd streptavidin/equil && ../../$(SCRIPTS_DIR)/equilibration.py -R ../solvated.parm7 ../pre-equil.ncrst

streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst: $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/solvated.parm7 complex/equil/EQUIL-DONE.rst
	mkdir -p streptavidin/
	$(word 1,$^) complex/solvated.parm7 complex/equil/EQUIL-DONE.rst 2 streptavidin/solvated.parm7 streptavidin/pre-equil.ncrst

biotin/solvated.parm7 biotin/pre-equil.ncrst: $(SCRIPTS_DIR)/cpptraj_remove_mol.sh complex/solvated.parm7 complex/equil/EQUIL-DONE.rst
	mkdir -p biotin/
	$(word 1,$^) complex/solvated.parm7 complex/equil/EQUIL-DONE.rst 1 biotin/solvated.parm7 biotin/pre-equil.ncrst

complex/equil/EQUIL-DONE.rst: complex/solvated.parm7 complex/equil/solvated.rst7
	cd complex/equil/ && ../../$(SCRIPTS_DIR)/equilibration.py ../solvated.parm7 solvated.rst7

complex/equil/solvated.%: complex/prep/solvated.%
	mkdir -p complex/equil && cp $^ $@

LEAP_DIR=complex/prep
complex/solvated.parm7 complex/prep/solvated.rst7: $(LEAP_DIR)/leap.in $(LEAP_DIR)/BTN.frcmod $(LEAP_DIR)/BTN.prep $(LEAP_DIR)/1stp-prepped.pdb
	cd $(LEAP_DIR) && tleap -f leap.in && cp solvated.parm7 ../

%/:
	mkdir -p $@
