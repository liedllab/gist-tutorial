import numpy as np

load ../complex/gist.pdb, complex
load ../streptavidin/gist.pdb, apo
load ../streptavidin/gist-Eall-dens.dx.gz, gist-E
load ../streptavidin/gist-Eall2-dens.dx.gz, gist-E2
load ../streptavidin/gist-dTSsix-dens.dx.gz, gist-S
load ../streptavidin/gist-gO.dx.gz, gist-gO

#map_double gist-E2

align complex, apo

as sticks, apo
hide sticks, apo and elem H
hide everything, complex
show sticks, complex and resn BTN
util.cbaw("apo")
color forest, complex and resn BTN
util.cnc("complex and resn BTN")

set ray_shadow, off
set specular, 0.2
set valence, off
set transparency_mode, 1

# isosurface sasa, gist-gO, 0.1
# color sasa, gray90
# set transparency, 0.6, sasa
show surface, apo
set transparency, 0.6, apo
set surface_color, gray90, apo

levels = np.array([0.25, 0.5, 1., 1.5, 2., 2.5, 3.])

reds = ['0xffe6e6', '0xffb3b3', '0xff8080', '0xff4d4d', '0xff1a1a', '0xff0000', '0xb30000']
blues = ['0xe6e6ff', '0xb3b3ff', '0x8080ff', '0x4d4dff', '0x1919ff', '0x0000cc', '0x000080']
greens = ['0xe6ffe6', '0xb3ffb3', '0x80ff80', '0x19ff19', '0x00b300', '0x009900', '0x008000']
transparencies = [0.95, 0.9, 0.85, 0.8, 0.75, 0.7, 0.5]
transparencies = [0.90, 0.85, 0.8, 0.8, 0.8, 0.7, 0.5]
carve = 8
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

show_surfaces("gist-E2", -levels, blues, transparencies, "gist-E2-negative")
show_surfaces("gist-E2", levels/2, reds, transparencies, "gist-E2-positive")
show_surfaces("gist-S", -levels, greens, transparencies)
python end

set_view (\
    -0.094035044,    0.913713515,   -0.395317316,\
     0.406970084,   -0.327104568,   -0.852862179,\
    -0.908587813,   -0.241084054,   -0.341095716,\
     0.000001546,    0.000001638,  -44.246318817,\
    -0.766282558,   -4.661285400,   -8.666867256,\
    36.045085907,   52.445415497,  -20.000000000 )
