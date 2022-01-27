.PHONY: all
all: 

LEAP_DIR=complex/prep
complex/prep/solvated.parm7: $(LEAP_DIR)/leap.in $(LEAP_DIR)/BTN.frcmod $(LEAP_DIR)/BTN.prep $(LEAP_DIR)/1stp-prepped.pdb
	cd $(LEAP_DIR) && tleap -f leap.in
	
complex/prep/solvated.rst7: $(LEAP_DIR)/leap.in $(LEAP_DIR)/BTN.frcmod $(LEAP_DIR)/BTN.prep $(LEAP_DIR)/1stp-prepped.pdb
	cd $(LEAP_DIR) && tleap -f leap.in
