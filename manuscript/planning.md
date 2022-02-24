# Order of the manuscript

* Abstract
* Introduction
* Prerequisites
* Theory
* Tutorial (streptavidin/biotin)
* Checklists

This list does not necessarily need to match the order that we put in the manuscript.

# Topics
* Prerequisites
* GIST convergence / simulation setup - Valentin
   * time
   * frames
   * restraints
      * strength
      * hydrogen?
   * clustering
   * Run MD of streptavidin + biotin + complex - best practices setup
* GIST implementations: CPU / PME / GPU / GIGIST
   * How to use them
   * what to use
   * Run GIST of streptavidin + biotin + complex
* GIST post-processing
   * computed quantities
   * double counting
   * dens/norm
   * software
      * gistpp
      * gisttools
   * dG of biotin
   * binding pocket analysis - VMD/Pymol grids, project to atoms
   * binding free energy - whole protein, or cut
* GIST extensions
   * multiple solvents
      * usage
      * convergence
      * show a quick example?
   * mixtures / salt
      * energy, MD with counter ions
      * entropy:
         * first order: GIST
         * second order: extensions, Python etc.
      * easiest example: counter ions!

