This directory contains the output files from the GIST calculations performed on the different systems as described in the tutorial. Note that redoing the calculations might result in slightly different results due to the inherent stochastic nature of molecular dynamics simulations.

### Directory Structure
The results are organized into subdirectories corresponding to each system:

-   **`biotin/`**: Contains GIST results for the solvated biotin system.
-   **`complex/`**: Contains GIST results for the solvated biotin-streptavidin complex.
-   **`streptavidin/`**: Contains GIST results for the solvated apo streptavidin system.

### File Descriptions

Within each subdirectory, you will find the following types of files:

-   **`gist.pdb`**: A PDB file of the solute without solvent that was used for the GIST calculation. 
-   **`*.dx.gz`**: These are gzipped grid files in the OpenDX format. They represent various thermodynamic and structural properties calculated by GIST. These files can be loaded into molecular visualization software like [PyMOL](https://pymol.org/), [VMD](https://www.ks.uiuc.edu/Research/vmd/), or [UCSF Chimera(X)](https://www.cgl.ucsf.edu/chimera/) to be displayed as isosurfaces or volumes.
For an overview of the different thermodynamic properties and the difference between the _dens and _norm quantities, check the manuscript.
-   **`gist.dat`**: The main GIST output file containing the calculated thermodynamic properties, such as energy and entropy densities.
