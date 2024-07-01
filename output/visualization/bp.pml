
### Imports and loading
import numpy as np

load ../complex/gist.pdb, complex
load ../complex/binding_pocket.dx.gz, BP

### Pymol settings
set ray_shadow, off
set specular, 0.2
set ray_trace_mode,3
set hash_max, 4000
set antialias, 3
bg white 

### Build isomesh, use a lvl lower than 1 since we set the voxels around the ligand to exactly 1
isomesh 3.5A, BP, 0.5

### Colors and views
hide sticks, (complex and not resn BTN) or elem H
color tv_orange, 3.5A
set transparency, 0.2, 3.5A, 

set_view (\
    -0.082966685,    0.996423185,   -0.015731294,\
     0.449292004,    0.023312312,   -0.893078744,\
    -0.889523625,   -0.081165932,   -0.449621499,\
    -0.000008025,    0.000024762,  -88.720932007,\
    -2.324048281,    0.439616710,   -0.875306845,\
  -315.442993164,  492.884674072,  -20.000000000 )
  
ray 2000, 1200
