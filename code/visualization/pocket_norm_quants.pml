
### Imports and loading
import numpy as np

load ../../output/streptavidin/gist.pdb, apo
load ../../output/complex/gist.pdb, complex
load ../../output/streptavidin/gist-E-per-mol-norm.dx.gz, gist-E-norm
load ../../output/streptavidin/gist-dTSsix-norm.dx.gz, gist-S-norm

### Pymol settings
set ray_shadow, off
set specular, 0.2
set ray_trace_mode,1
set hash_max, 4000
set antialias, 3
bg white 

# use the following two settings for rendering with 'ray'
set transparency_mode, 1
set two_sided_lighting, 1

#... or use these ones for real time visualisations (comment them out to use the above settings)
# set transparency_mode, 3
# set two_sided_lighting, -1

### Resample maps for smother visualisations at double resolution
map_double gist-E-norm
map_double gist-S-norm

### Colors and representations

show surface, apo
set surface_color, gray90, apo
hide everything, complex
show lines, complex and resn BTN and not elem H

### GIST Volumes
#volume_ramp_new GIST, -3.5 white 0.0 -3 blue 0.5 -2.5 white 0.0 2.5 white 0.0 3 red 0.5 3.5 white 0.0
volume_ramp_new GIST, -3.5 white 0.0 -2 blue 0.3 0 white 0.0  2 red 0.3 3.5 white 0.0
volume E-norm-Vol, gist-E-norm, GIST, resn BTN and not elem H, carve=1.0

util.cba(104,"complex")

set volume_layers, 1024
set line_as_cylinders
### Finalize visualisations

set_view (\
     0.110471129,    0.853008330,   -0.510069072,\
     0.525590003,   -0.485716581,   -0.698449552,\
    -0.843533218,   -0.190929025,   -0.501991212,\
    -0.000002265,   -0.000000656,  -29.015132904,\
     3.242953300,    0.435233355,   -4.985782623,\
    -8.766820908,   66.797111511,  -20.000000000 )

