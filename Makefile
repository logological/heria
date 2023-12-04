#
# This Makefile can be used to build the heria class and package it
# for distribution on CTAN.
#
# Copyright 2023 Tristan Miller
#
# This work may be distributed and/or modified under the
# conditions of the LaTeX Project Public License, either version 1.3c
# of this license or (at your option) any later version.
# The latest version of this license is in
#   https://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX
# version 2008 or later.
#

PDFLATEX=pdflatex
CTANIFY=ctanify
TEXDIR=tex/latex/heria
DOCDIR=doc/latex/heria

GENERATED_EXTENSIONS=aux idx log out pdf synctex.gz gls ilg toc

HERIA_INSTRUCTIONS=hi-annexes.tex hi-capacity.tex hi-criticalrisks.tex hi-deliverables-key.tex hi-deliverables.tex hi-excellence.tex hi-impact.tex hi-inkind.tex hi-measures.tex hi-methodology.tex hi-milestones.tex hi-objectives.tex hi-othercosts.tex hi-participant-numbering.tex hi-participants.tex hi-pathways.tex hi-purchasecosts.tex hi-quality.tex hi-staffeffort.tex hi-subcontractingcosts.tex hi-summary.tex hi-tables.tex hi-workplan.tex hi-wp-description.tex hi-wp-objectives.tex
HERIA_INS_FILES=heria.cls heria-proposal.tex $(HERIA_INSTRUCTIONS)

# Build the class, skeleton proposal, and documentation
all: heria-proposal.pdf heria.pdf

# Extract the source files from heria.dtx
$(HERIA_INS_FILES): heria.ins heria.dtx
	$(PDFLATEX) heria.ins

# Build the skeleton proposal
heria-proposal.pdf: $(HERIA_INS_FILES)
	$(PDFLATEX) heria-proposal.tex
	$(PDFLATEX) heria-proposal.tex
	$(PDFLATEX) heria-proposal.tex

# Build the documentation
heria.pdf: heria.dtx
	$(PDFLATEX) heria.dtx
	$(PDFLATEX) heria.dtx
	$(PDFLATEX) heria.dtx

# Package heria for distribution on CTAN
heria.tar.gz dist ctanify: heria-proposal.pdf heria.pdf README.md
	$(CTANIFY) heria.ins heria.pdf heria-proposal.pdf README.md heria-proposal.tex=$(DOCDIR) $(foreach file,$(HERIA_INSTRUCTIONS),$(file)=$(TEXDIR))

# Remove all generated files
clean:

	$(RM) heria.cls heria.glo heria.hd heria.tar.gz $(HERIA_INS_FILES) $(foreach ext,$(GENERATED_EXTENSIONS),heria.$(ext)) $(foreach ext,$(GENERATED_EXTENSIONS),heria-proposal.$(ext))

.PHONY: clean dist ctanify
