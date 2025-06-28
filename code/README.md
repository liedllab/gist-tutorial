This folder contains scripts to replicate the results presented in the GIST tutorial.   
- tutorial-gist.ipynb: A [Jupyter Notebook](https://jupyter.org/) containing the analysis code presented in the manuscript.   
- Makefile:   
A `make` workflow to create the inputs necessary to run the GIST calculation.  
A working installation of the [AMBER Molecular Dynamics Package](https://ambermd.org/) as well as [AmberTools](https://ambermd.org/AmberTools.php) is required.   
The following commands are available:
 ```
  make equilibration-targets   
  make gist-md-inputs   
  make gist-inputs
 ```   
These create the equilibrated structural files, run the restrained MD simulation and run the GIST calculation, respectively.   

- complex/prep: contains the prepared structures of the biotin-streptavidin complex to run the example presented in the manuscript.   
- visualization: contains PyMOL scripts to create some of the figures shown in the manuscript.   
