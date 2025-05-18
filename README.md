# GIST-Tutorial
A tutorial for Grid Inhomogenous Solvation Theory (GIST) as implemented in AmberTool's cpptraj.
The tutorial aims to teach how to apply GIST for small molecules and proteins, with biotin-streptavidin as a showcase example.

The current version of the manuscript is found in `manuscript/manuscript.pdf`. 
The manuscript is not currently published, but is aimed at the Living Journal of Computational Molecular Science. 

As such, the tutorial is developed in line with LiveCoMS guidelines on [Paper Writing as Code Development ](https://livecomsjournal.github.io/about/paper_code/) and will be further updated in correspondence with the community. 
If you notice any issues or have suggestions, please raise them as an [Issue](https://github.com/liedllab/gist-tutorial/issues) or write up a [Pull Request](https://github.com/liedllab/gist-tutorial/pulls).

# Dependencies and Installation
* [cpptraj](https://github.com/Amber-MD/cpptraj) (Version 6.24 or higher)
* [gisttools](https://github.com/liedllab/gisttools) (Version 0.2 or higher)
* [mdtraj](https://github.com/mdtraj/mdtraj) (Version 1.9.7 or higher)
* [numpy](https://numpy.org/) (Tested with version 1.23.5)
* [pandas](pandas.pydata.org) (Tested with version 1.5.3)

The molecular dynamics simulations used in the tutorial are hosted under the DOI [10.48323/4mbrd-67m83](https://doi.org/10.48323/4mbrd-67m83)

The tutorial code is provided as a Jupyter Notebook at `code/tutorial-gist.ipynb`.<br/> 
We recommend using [JupyterLab](https://jupyter.org/) or [VS Code](https://code.visualstudio.com/) (with the Jupyter extensions) for editing and working with the notebook.

Molecular visualisations are generated with [PyMol](https://pymol.org/) and input scripts are provided in the `output/visualization` folder.
# Authors
In the same order as in the manuscript:
* Valentin J Hoerschinger
* Franz Waibl
* Vjay Molino
* Helmut Carter
* Monica L Fernández-Quintero
* Steven Ramsey
* Daniel R Roe
* Klaus R Liedl
* Michael K Gilson
* Tom Kurtzman
  
The repository is currently managed by Valentin ([@vhoer](https://www.github.com/vhoer)).
