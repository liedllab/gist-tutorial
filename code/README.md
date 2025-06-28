This folder contains scripts to replicate the results presented in the GIST tutorial.   
- [tutorial-gist.ipynb](https://github.com/liedllab/gist-tutorial/blob/main/code/tutorial-gist.ipynb): A [Jupyter Notebook](https://jupyter.org/) containing the analysis code presented in the manuscript.   
- [Makefile](https://github.com/liedllab/gist-tutorial/blob/main/code/Makefile):   
A `make` workflow to create the inputs necessary to run the GIST calculation.  
A working installation of the [AMBER Molecular Dynamics Package](https://ambermd.org/) as well as [AmberTools](https://ambermd.org/AmberTools.php) is required.   
The following commands are available:
              
        make equilibration-targets   
        make gist-md-inputs   
        make gist-inputs
  
  These create the equilibrated structural files, run the restrained MD simulation and run the GIST calculation, respectively.   

- [complex/prep](https://github.com/liedllab/gist-tutorial/tree/main/code/complex/prep): Contains the prepared structures of the biotin-streptavidin complex to run the example presented in the manuscript.
- [scripts](https://github.com/liedllab/gist-tutorial/tree/repo-updates/code/scripts): Contains various bash and python scripts helpful for running GIST calculations or used in the `make` workflows.
- [visualization](https://github.com/liedllab/gist-tutorial/tree/repo-updates/code/visualization): Contains PyMOL scripts to create some of the figures shown in the manuscript.   
