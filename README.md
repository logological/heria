# heria: A LaTeX class for Horizon Europe RIA and IA grant proposals

## Overview

The `heria` class facilitates the preparation of Research and
Innovation Action (RIA) and Innovation Action (IA) funding proposals
for the European Commission's Horizon Europe program.  The class is a
conversion of the official Part B template into LaTeX; it preserves
the formatting and most of the instructions of the original version,
and has the additional feature that tables (listing the participants,
work packages, deliverables, etc.) are programmatically generated
according to data supplied by the user.

## Building and installing

To build the class, run the file `heria.ins` through `latex` or
`pdflatex` and then copy the resulting `.cls` and `.tex` files into a
directory searched by LaTeX.

To generate the documentation, run the file `heria.dtx` through
`pdflatex`.

To generate the skeleton proposal, build the class and then run the
file `heria-proposal.tex` through `pdflatex`.

## Source repository and bug tracker

For now, the source code is hosted on GitHub at
[https://github.com/logological/heria](https://github.com/logological/heria).
There you will also find an issue tracker for reporting bugs and
feature requests.

## Licence

The `heria` class is distributed under the conditions of the [LaTeX
Project Public License](https://www.latex-project.org/lppl.txt),
either version 1.3 of this license or (at your option) any later
version.
