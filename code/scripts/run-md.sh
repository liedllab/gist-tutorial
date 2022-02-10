#!/bin/bash

HELPMESSAGE="Usage:
$0 [-h|--help] PARMFILE CRDFILE"

# ----------------
# Argument parsing
# ----------------

if [ -z "$2" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]
then
    echo "$HELPMESSAGE"
    exit
fi

PARMFILE="$1"
CRDFILE="$2"

# ------------
# Job settings
# ------------

BASE="md"

INFILE="100ns-npt-restraint.in"

echo "
production 100 ns npt run - Berendsen barostat
&cntrl
	ntx=5, irest=1,
	ioutfm=1,
	ntb=2, iwrap=1,
	ntr=1, restraint_wt=100.0, restraintmask=\"!@H=&!:WAT\",
	ntp=1, pres0=1.0, taup=1.0,
	ntc=2, ntf=2,
	ntt=3, tempi=300.0, temp0=300.0, gamma_ln=2,
	nstlim=50000000, dt=0.002,
	ntwr=50000, ntwx=5000,
	ntpr=5000,
/
" > $INFILE

# we call the output files ...-01, just in case we want to prolong some
# simulations later on.
pmemd.cuda -O -i $INFILE -o $BASE-01.out -p $PARMFILE -c $CRDFILE -x $BASE-01.nc -r $BASE-01.ncrst -ref $CRDFILE
