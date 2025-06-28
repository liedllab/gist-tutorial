This directory contains the LaTeX source code and assets for the GIST tutorial manuscript.

### Key Files:

- **`manuscript.tex`**: The main LaTeX source file for the article. This file brings together the content, figures, and bibliography to be compiled into the final PDF document.

- **`livecoms.cls`**: A custom LaTeX class file that defines the overall structure, layout, and style of the manuscript, ensuring it conforms to the formatting requirements of the *Living Journal of Computational Molecular Science* (LiveCoMS). It handles everything from page margins and fonts to the appearance of titles and sections.

- **`bibliography.bib`**: The BibTeX database file containing all the bibliographic entries cited in the manuscript. Each entry is formatted in BibTeX syntax, allowing for automatic citation management.

- **`vancouver-livecoms.bst`**: A BibTeX style file that controls the formatting of the citations and the bibliography list. It is a customized version of the Vancouver citation style, adapted specifically for LiveCoMS publications.

The other files in this directory (e.g., `.aux`, `.bbl`, `.log`, `.pdf`) are auxiliary files generated during the LaTeX compilation process or are part of the final output. The `figures` subdirectory contains all the image files included in the