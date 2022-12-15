#!/bin/bash

if [ -z "$5" ]; then
	echo Usage: $0 IN_PARM IN_RST N_TO_REMOVE OUT_PARM OUT_RST
fi

IN_PARM=$1
IN_RST=$2
N_TO_REMOVE=$3
OUT_PARM=$4
OUT_RST=$5

cpptraj << EOF
parm $IN_PARM
trajin $IN_RST
strip ^$N_TO_REMOVE parmout $OUT_PARM
trajout $OUT_RST
go
EOF
