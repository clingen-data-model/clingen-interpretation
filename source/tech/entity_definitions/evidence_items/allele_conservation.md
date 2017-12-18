---
layout: entity
model: interpretation
id: E51
---

Scope and Usage
----------------

AlleleConservation represents the degree to which an allele is the same (conserved) across different species.   If an allele is the same in many species, it often represents an important functional portion of a gene; variations in the allele may therefore tend to be more pathogenic.

Most conservation calculations produce a computational score based on a set of multiple sequence alignments across species.  Typically, an algorithm produces a numerical score, to which some metric is applied to determine whether the allele is or is not conserved.   AlleleConservation contains only this final result.  The numerical score is encoded in an AlleleConservationScore, which may be attached to an AlleleConservation as supporting evidence via an EvidenceLine.
