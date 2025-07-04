This folder contains scripts and resources to replicate the results presented in the GIST tutorial.

- **[tutorial-gist.ipynb](https://github.com/liedllab/gist-tutorial/blob/main/code/tutorial-gist.ipynb)**: A [Jupyter Notebook](https://jupyter.org/) containing the Python code for the analysis presented in the manuscript.

- **[Makefile](https://github.com/liedllab/gist-tutorial/blob/main/code/Makefile)**: A `make` workflow to automate the GIST calculation setup. A working installation of the [AMBER Molecular Dynamics Package](https://ambermd.org/) and [AmberTools](https://ambermd.org/AmberTools.php) is required.
  
  The following commands are available:
  ```bash
  # Create equilibrated structural files
  make equilibration-targets
  # Generate inputs for the restrained MD simulation
  make gist-md-inputs
  # Generate inputs for the GIST calculation
  make gist-inputs
  ```

- **[complex/prep](https://github.com/liedllab/gist-tutorial/tree/main/code/complex/prep)**: Contains the prepared PDB structures of the biotin-streptavidin complex used in the tutorial.

- **[scripts](https://github.com/liedllab/gist-tutorial/tree/repo-updates/code/scripts)**: A collection of Bash and Python helper scripts for running GIST calculations and performing intermediate steps.

- **[visualization](https://github.com/liedllab/gist-tutorial/tree/repo-updates/code/visualization)**: Contains PyMOL scripts to reproduce the figures shown in the manuscript.
