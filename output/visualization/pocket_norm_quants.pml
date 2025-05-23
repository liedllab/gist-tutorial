
### Imports and loading
import numpy as np

load ../streptavidin/gist.pdb, apo
load ../complex/gist.pdb, complex
load ../streptavidin/gist-E-per-mol-norm.dx.gz, gist-E-norm
load ../streptavidin/gist-dTSsix-norm.dx.gz, gist-S-norm

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


### Colors and representations

show surface, apo
set surface_color, gray90, apo
hide everything, complex
show lines, complex and resn BTN and not elem H
### GIST Isosurfaces
isosurface TdS, gist-S-norm, -3, resn BTN, carve=1.5
isosurface E_neg, gist-E-norm, -3, resn BTN, carve=1.5
isosurface E_pos, gist-E-norm, 3, resn BTN, carve=1.5

color tv_blue, TdS
color tv_green, E_neg
color tv_red, E_pos
util.cba(104,"complex")

set transparency, 0.5, TdS
set transparency, 0.5, E_neg
set transparency, 0.5, E_pos
### Finalize visualisations

set_view (\
     0.140216514,    0.832905710,   -0.535343587,\
     0.577019334,   -0.508109510,   -0.639421225,\
    -0.804602742,   -0.219248921,   -0.551851571,\
     0.000021984,   -0.000045859,  -40.345500946,\
     4.724672794,    1.572793007,   -4.651573181,\
    17.642587662,   63.044929504,  -20.000000000 )

