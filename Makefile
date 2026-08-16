#
# This Makefile can be used to build the heria class and package it
# for distribution on CTAN.
#
# Copyright 2023, 2026 Tristan Miller
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

GENERATED_EXTENSIONS=aux idx log out pdf synctex.gz gls ilg toc tex

TEMPLATE_VERSIONS=3.2 3.3 3.4 4.0 5.1
HERIA_INSTRUCTIONS=hi-annexes.tex hi-capacity.tex hi-criticalrisks.tex hi-deliverables-key.tex hi-deliverables.tex hi-excellence.tex hi-impact.tex hi-inkind.tex hi-measures.tex hi-methodology.tex hi-milestones.tex hi-objectives.tex hi-othercosts.tex hi-participant-numbering.tex hi-participants.tex hi-pathways.tex hi-purchasecosts.tex hi-quality.tex hi-staffeffort.tex hi-subcontractingcosts.tex hi-summary.tex hi-tables.tex hi-workplan.tex hi-wp-description.tex hi-wp-objectives.tex
HERIA_SKELETON_PROPOSALS_TEX=$(foreach version,$(TEMPLATE_VERSIONS),heria-proposal-$(version).tex)
HERIA_SKELETON_PROPOSALS_PDF=$(foreach version,$(TEMPLATE_VERSIONS),heria-proposal-$(version).pdf)
HERIA_CLASS_FILES=heria.cls
HERIA_INS_FILES=$(HERIA_CLASS_FILES) $(HERIA_SKELETON_PROPOSALS_TEX) $(HERIA_INSTRUCTIONS)

# Build the class, skeleton proposals, and documentation
all: $(HERIA_SKELETON_PROPOSALS_PDF) heria.pdf

# Extract the source files from heria.dtx
$(HERIA_INS_FILES) &: heria.ins heria.dtx
	$(PDFLATEX) heria.ins

# Build the skeleton proposal
heria-proposal-%.pdf: heria-proposal-%.tex $(HERIA_CLASS_FILES) $(HERIA_INSTRUCTIONS)
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	$(PDFLATEX) $<

# Build the documentation
heria.pdf: heria.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	$(PDFLATEX) $<

# Package heria for distribution on CTAN
heria.tar.gz dist ctanify: heria.pdf $(HERIA_SKELETON_PROPOSALS_PDF) README.md
	$(CTANIFY) heria.ins $@ $(foreach file,$(HERIA_SKELETON_PROPOSALS_TEX),$(file)=$(DOCDIR)) $(foreach file,$(HERIA_INSTRUCTIONS),$(file)=$(TEXDIR))

# Remove all generated files
clean:
	$(RM) heria.cls heria.glo heria.hd heria.tar.gz $(HERIA_INSTRUCTIONS) $(foreach ext,$(GENERATED_EXTENSIONS),heria.$(ext)) $(foreach version,$(TEMPLATE_VERSIONS),$(foreach ext,$(GENERATED_EXTENSIONS),heria-proposal-$(version).$(ext)))

.PHONY: clean dist ctanify
