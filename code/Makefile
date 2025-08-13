.SECONDARY:

SCRIPTS_DIR := scripts

.PHONY: all
all: md-run gist-run 

.PHONY: gist-inputs
gist-inputs: biotin/gist/run-gist.sh streptavidin/gist/run-gist.sh complex/gist/run-gist.sh

%/gist/run-gist.sh: scripts/run-gist.sh
	cp $^ $@

.PHONY: gist-run
gist-run: biotin/gist/gist.dat streptavidin/gist/gist.dat complex/gist/gist.dat

# GIST calculation targets - run the actual GIST analysis
%/gist/gist.dat: %/gist/solvated.parm7 %/gist/md-01.nc scripts/run-gist.sh
	mkdir -p $(@D)
	cd $(@D) && ../../scripts/run-gist.sh ../solvated.parm7 md-01.nc

.PHONY: gist-md-inputs
gist-md-inputs: biotin/gist/run-md.sh streptavidin/gist/run-md.sh complex/gist/run-md.sh

%/gist/run-md.sh %/gist/solvated.parm7 %/gist/EQUIL-DONE.rst: %/solvated.parm7 %/equil/EQUIL-DONE.rst scripts/run-md.sh
	$(eval directory=$(dir $@))
	mkdir -p $(directory)
	cp $(word 1,$^) $(directory)
	cp $(word 2,$^) $(directory)
	cp $(word 3,$^) $(directory)


# Convenience targets for running GIST with custom parameters
.PHONY: gist-biotin gist-streptavidin gist-complex
gist-biotin: biotin/gist/gist.dat

gist-streptavidin: streptavidin/gist/gist.dat

gist-complex: complex/gist/gist.dat

# Target for running GIST with custom parameters (use GIST_OPTS variable)
# Example: make gist-custom SYSTEM=biotin TOPOLOGY=biotin/solvated.parm7 TRAJECTORY=biotin/md/md-01.nc GIST_OPTS="--grid-spacing 0.3 --offset 25"
.PHONY: gist-custom
gist-custom:
	@if [ -z "$(SYSTEM)" ] || [ -z "$(TOPOLOGY)" ] || [ -z "$(TRAJECTORY)" ]; then \
		echo "Error: Please specify SYSTEM, TOPOLOGY, and TRAJECTORY variables"; \
		echo "Example: make gist-custom SYSTEM=biotin TOPOLOGY=biotin/solvated.parm7 TRAJECTORY=biotin/md/md-01.nc GIST_OPTS=\"--grid-spacing 0.3\""; \
		exit 1; \
	fi
	mkdir -p $(SYSTEM)/gist/
	cd $(SYSTEM)/gist && ../../scripts/run-gist.sh $(SYSTEM) $(TOPOLOGY) $(TRAJECTORY) $(GIST_OPTS)

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

.PHONY: md-run
md-run: biotin/gist/md-01.nc streptavidin/gist/md-01.nc complex/gist/md-01.nc

# MD simulation targets - run the actual MD simulations
%/gist/md-01.nc: %/solvated.parm7 %/equil/EQUIL-DONE.rst %/gist/run-md.sh
	mkdir -p $(@D)
	cd $(@D) && run-md.sh ../solvated.parm7 ../equil/EQUIL-DONE.rst

# Convenience targets for running individual MD simulations
.PHONY: md-biotin md-streptavidin md-complex
md-biotin: biotin/gist/md-01.nc

md-streptavidin: streptavidin/gist/md-01.nc

md-complex: complex/gist/md-01.nc

# Target for running MD with custom parameters (use MD_OPTS variable)
# Example: make md-custom SYSTEM=biotin TOPOLOGY=biotin/solvated.parm7 RESTART=biotin/equil/EQUIL-DONE.rst
.PHONY: md-custom
md-custom:
	@if [ -z "$(SYSTEM)" ] || [ -z "$(TOPOLOGY)" ] || [ -z "$(RESTART)" ]; then \
		echo "Error: Please specify SYSTEM, TOPOLOGY, and RESTART variables"; \
		echo "Example: make md-custom SYSTEM=biotin TOPOLOGY=biotin/solvated.parm7 RESTART=biotin/equil/EQUIL-DONE.rst"; \
		exit 1; \
	fi
	mkdir -p $(SYSTEM)/gist/
	cd $(SYSTEM)/gist && ../../scripts/run-md.sh $(TOPOLOGY) $(RESTART)

%/:
	mkdir -p $@
