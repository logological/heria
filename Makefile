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
INSTRUCTIONS_BASENAMES=annexes capacity criticalrisks deliverables-key deliverables excellence impact inkind measures methodology milestones objectives othercosts participant-numbering participants pathways purchasecosts quality staffeffort subcontractingcosts summary-decmeasures summary-expectedresults summary-impacts summary-outcomes summary-specificneeds summary-targetgroups summary tables workplan wp-description wp-objectives
INSTRUCTIONS=$(foreach basename,$(INSTRUCTIONS_BASENAMES),hi-$(basename).tex)
SKELETONS_TEX=$(foreach version,$(TEMPLATE_VERSIONS),heria-proposal-$(version).tex)
SKELETONS_PDF=$(foreach version,$(TEMPLATE_VERSIONS),heria-proposal-$(version).pdf)
CLASS_FILES=heria.cls
INS_FILES=$(CLASS_FILES) $(SKELETONS_TEX) $(INSTRUCTIONS)

# Build the class, skeleton proposals, and documentation
all: $(SKELETONS_PDF) heria.pdf

# Extract the source files from heria.dtx
$(INS_FILES) &: heria.ins heria.dtx
	$(PDFLATEX) heria.ins

# Build the skeleton proposal
heria-proposal-%.pdf: heria-proposal-%.tex $(CLASS_FILES) $(INSTRUCTIONS)
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	$(PDFLATEX) $<

# Build the documentation
heria.pdf: heria.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<
	$(PDFLATEX) $<

# Package heria for distribution on CTAN
heria.tar.gz dist ctanify: heria.pdf $(SKELETONS_PDF) README.md
	$(CTANIFY) heria.ins $^ $(foreach file,$(SKELETONS_TEX),$(file)=$(DOCDIR)) $(foreach file,$(INSTRUCTIONS),$(file)=$(TEXDIR))

# Remove all generated files
clean:
	$(RM) heria.cls heria.glo heria.hd heria.tar.gz $(INSTRUCTIONS) $(foreach ext,$(GENERATED_EXTENSIONS),heria.$(ext)) $(foreach version,$(TEMPLATE_VERSIONS),$(foreach ext,$(GENERATED_EXTENSIONS),heria-proposal-$(version).$(ext)))

.PHONY: clean dist ctanify
