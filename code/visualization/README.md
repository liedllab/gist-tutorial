This folder contains [PyMOL](https://pymol.org/) scripts (`.pml`) used to generate figures for the manuscript. These scripts load the results of the GIST calculations and visualize them as isosurfaces.

- **[bp.pml](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/visualization/bp.pml)**: Visualizes the binding pocket definition. It loads the `binding_pocket.dx` grid as created with [tutorial-gist.ipynb](https://github.com/liedllab/gist-tutorial/blob/main/code/tutorial-gist.ipynb) and displays it as a mesh around the biotin ligand in the streptavidin-biotin complex.

- **[pocket.pml](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/visualization/pocket.pml)**: Creates a detailed visualization of the _dens GIST thermodynamic quantities (energy and entropy densities) in the binding pocket. It generates multiple colored isosurfaces to represent different value levels, showing both favorable and unfavorable regions.

- **[pocket_norm_quants.pml](https://github.com/liedllab/gist-tutorial/blob/repo-updates/code/visualization/pocket_norm_quants.pml)**: Visualizes the _norm GIST quantities (energy and entropy per water molecule).