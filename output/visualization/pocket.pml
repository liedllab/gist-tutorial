import numpy as np

load ../complex/gist.pdb, complex
load ../streptavidin/gist.pdb, apo
load ../streptavidin/gist-Eall-dens.dx.gz, gist-E
load ../streptavidin/gist-Eall2-dens.dx.gz, gist-E2
load ../streptavidin/gist-dTSsix-dens.dx.gz, gist-S
load ../streptavidin/gist-gO.dx.gz, gist-gO

align complex, apo

as sticks, apo
hide sticks, apo and elem H
hide everything, complex
show sticks, complex and resn BTN
util.cbaw("apo")
util.cbag("complex and resn BTN")

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

levels = np.array([0.5, 1., 1.5, 2., 2.5, 3.])

reds = ['0xfee5d9','0xfcbba1','0xfc9272','0xfb6a4a','0xde2d26','0xa50f15']
blues = ['0xeff3ff','0xc6dbef','0x9ecae1','0x6baed6','0x3182bd','0x08519c']
greens = ['0xedf8e9','0xc7e9c0','0xa1d99b','0x74c476','0x31a354','0x006d2c']
purples = ['0xf2f0f7','0xdadaeb','0xbcbddc','0x9e9ac8','0x756bb1','0x54278f']
oranges = ['0xfeedde','0xfdd0a2','0xfdae6b','0xfd8d3c','0xe6550d','0xa63603']
grays = ['0xf7f7f7','0xd9d9d9','0xbdbdbd','0x969696','0x636363','0x252525']

reds = ['0xfff5f0','0xfee0d2','0xfcbba1','0xfc9272','0xfb6a4a','0xef3b2c','0xcb181d','0x99000d'][2:]
blues = ['0xf7fbff','0xdeebf7','0xc6dbef','0x9ecae1','0x6baed6','0x4292c6','0x2171b5','0x084594'][2:]
greens = ['0xf7fcf5','0xe5f5e0','0xc7e9c0','0xa1d99b','0x74c476','0x41ab5d','0x238b45','0x005a32'][2:]

python
def show_surfaces(map, levels, colors, group_name=None):
    group_name = group_name or map + "-surfaces"
    new_maps = []
    for lvl, color in zip(levels, colors):
        name = "{}_{}".format(map, lvl)
        cmd.isosurface(name, map, lvl)
        cmd.set("transparency", 0.5, name)
        cmd.color(color, name)
        new_maps.append(name)
    cmd.group(group_name, " ".join(new_maps))

show_surfaces("gist-E2", -levels, blues, "gist-E2-negative")
show_surfaces("gist-E2", levels, reds, "gist-E2-positive")
show_surfaces("gist-S", -levels, greens)
python end

set_view (\
    -0.094035044,    0.913713515,   -0.395317316,\
     0.406970084,   -0.327104568,   -0.852862179,\
    -0.908587813,   -0.241084054,   -0.341095716,\
     0.000001546,    0.000001638,  -44.246318817,\
    -0.766282558,   -4.661285400,   -8.666867256,\
    36.045085907,   52.445415497,  -20.000000000 )
