
### Imports and loading
import numpy as np

load ../streptavidin/gist.pdb, apo
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

### GIST Isosurfaces
isosurface dTS, gist-S-norm, -2.5
isosurface E_neg, gist-E-norm, -2.5
isosurface E_pos, gist-E-norm, 2.5

color tv_blue, dTS
color tv_green, E_neg
color tv_red, E_pos

### Finalize visualisations

set_view (\
     0.205722868,    0.776433945,   -0.595664322,\
     0.586023986,   -0.585219085,   -0.560436904,\
    -0.783742607,   -0.233781740,   -0.575405777,\
    -0.000007818,   -0.000018828,  -38.208305359,\
    -0.446677208,   -3.751610994,   -9.882472992,\
    15.505332947,   60.907680511,  -20.000000000 )

