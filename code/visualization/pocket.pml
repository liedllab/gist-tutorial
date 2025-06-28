
### Imports and loading
import numpy as np

load ../complex/gist.pdb, complex
load ../streptavidin/gist.pdb, apo
load ../streptavidin/gist-Eall-dens.dx.gz, gist-E
load ../streptavidin/gist-Eall2-dens.dx.gz, gist-E2
load ../streptavidin/gist-dTSsix-dens.dx.gz, gist-S
load ../streptavidin/gist-gO.dx.gz, gist-gO

### Pymol settings
set ray_shadow, off
set specular, 0.2
set valence, off
set ray_trace_mode,1
set hash_max, 4000
set antialias, 3
set cartoon_side_chain_helper, 1
set cartoon_transparency, 0.2
bg white 

# use the following two settings for rendering with 'ray'
set transparency_mode, 1
set two_sided_lighting, 1

#... or use these ones for real time visualisations (comment them out to use the above settings)
# set transparency_mode, 3
# set two_sided_lighting, -1

### Resample maps for smother visualisations at double resolution
map_double gist-E2
map_double gist-S

### Alignment, colors and representations
align complex, apo

as sticks, apo
hide sticks, apo and elem H
hide everything, complex
show sticks, complex and resn BTN and not elem H
hide everything, apo and not (sidechain or name CA and byres resn BTN around 3)
show cartoon, apo

util.cbaw("apo")
color forest, complex and resn BTN
util.cba(104,"complex")

### GIST Isosurfaces
levels = np.array([0.25, 0.5, 1., 1.5, 2., 2.5, 3.])

reds = ['0xffe6e6', '0xffb3b3', '0xff8080', '0xff4d4d', '0xff1a1a', '0xff0000', '0xb30000']
blues = ['0xe6e6ff', '0xb3b3ff', '0x8080ff', '0x4d4dff', '0x1919ff', '0x0000cc', '0x000080']
greens = ['0xe6ffe6', '0xb3ffb3', '0x80ff80', '0x19ff19', '0x00b300', '0x009900', '0x008000']

transparencies = [0.80, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2]
carve = 4
CARVE_SELECTION = 'complex and resn BTN'

python
def show_surfaces(map, levels, colors, transparencies, group_name=None):
    group_name = group_name or map + "-surfaces"
    new_maps = []
    for lvl, color, trans in zip(levels, colors, transparencies):
        name = "{}_{}".format(map, lvl)
        cmd.isosurface(name, map, lvl, CARVE_SELECTION, carve=carve)
        cmd.set("transparency", trans, name)
        cmd.color(color, name)
        new_maps.append(name)
    cmd.group(group_name, " ".join(new_maps))

show_surfaces("gist-E2", -levels, greens, transparencies, "gist-E2-negative")
show_surfaces("gist-E2", levels/2, reds, transparencies, "gist-E2-positive")
show_surfaces("gist-S", -levels, blues, transparencies)
python end

### Finalize visualisations

cmd.disable('gist-S-surfaces')
set_view (\
    -0.238722816,    0.874910355,   -0.421346307,\
     0.191408783,   -0.382982284,   -0.903706551,\
    -0.952035904,   -0.296387613,   -0.076038770,\
     0.000001546,    0.000001638,  -44.246318817,\
    -0.766282558,   -4.661285400,   -8.666867256,\
    21.544094086,   66.946403503,  -20.000000000 )

