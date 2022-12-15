#!/usr/bin/env python2
# import sys
from __future__ import print_function
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('topology', help='AMBER parm7 topology file')
parser.add_argument('coord', help='Coordinate file.')
parser.add_argument('-r', '--rest', help='Restraint mask.', default='!(:WAT,NA,CL)', required=False)
parser.add_argument('-R', '--restraint_equil', help='Restraint equilibration only.', action='store_true')
args = parser.parse_args()

if not os.path.isfile(args.topology):
    print("Topology {} not found.".format(args.topology))
    quit(1)

if not os.path.isfile(args.coord):
    print("Coordinates {} not found.".format(args.coord))
    quit(1)

minheader = ("minimization\n"
             "&cntrl\n"
             "    imin=1, ncyc=500, maxcyc=1000, ntr=1, cut=8.0,\n    ")

nvtheader = ("equilibration\n"
             "&cntrl\n"
             "    ntb=1, ntc=2, ntf=2, ntt=3, gamma_ln=2.0, cut=8.0,\n    ")

nptheader = ("pressure equilibration\n"
             "&cntrl\n"
             "    ntb=2, ntp=1, pres0=1.0, taup=2.0,\n"
             "    ntc=2, ntf=2, ntt=3,gamma_ln=2.0,\n"
             "    tempi=300.0, temp0=300.0,\n    ")

with open('01.in', 'w') as f:
    f.write(minheader)
    f.write('restraint_wt=100.0, restraintmask="!@H=&{}",\n/\n'.format(args.rest))

with open('02.in', 'w') as f:
    f.write(nvtheader)
    f.write(('ntr=1, restraint_wt=100.0, restraintmask="!@H=&{}", \n'
             '    nstlim=100000, dt=0.001, nmropt=1,\n/\n').format(args.rest))
    f.write(('&wt TYPE=\'TEMP0\', istep1=0, istep2=100000, value1=100.0, value2=300.0 /\n'
             '&wt TYPE=\'END\' /\n'))

with open('03.in', 'w') as f:
    f.write(nptheader)
    f.write(('ntr=1, restraint_wt=100.0,restraintmask="!@H=&{}",\n'
             '    nstlim=10000, dt=0.002,\n/\n').format(args.rest))

with open('04.in', 'w') as f:
    f.write(nptheader)
    f.write(('ntr=1, restraint_wt=100.0,restraintmask="!@H=&{}",\n'
             '    nstlim=100000, dt=0.002,\n/\n').format(args.rest))

if not args.restraint_equil:
    with open('05.in', 'w') as f:
        f.write(nptheader)
        f.write('nstlim=100000, dt=0.002,\n/\n')

eqmax = 4 if args.restraint_equil else 5

# write job scripts
with open('equilibration.sh', 'w') as f:
    f.write('#!/bin/bash\n\n')
    f.write('cp {} 00.rst\n'.format(args.coord))
    for i in range(1, eqmax + 1):
        inp = '{:02d}.in'.format(i)
        out = '{:02d}.out'.format(i)
        prev_rst = '{:02d}.rst'.format(i - 1)
        rst = '{:02d}.rst'.format(i)
        f.write('pmemd.cuda -O -i {} -o {} -p {} -c {} -r {} -ref {}\n'.format(
                inp, out, args.topology, prev_rst, rst, prev_rst))
    f.write('cp {:02d}.rst EQUIL-DONE.rst\n'.format(eqmax))

os.system('bash ./equilibration.sh')
