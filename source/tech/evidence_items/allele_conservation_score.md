---
layout: entity
model: interpretation
id: E53
---

Scope and Usage
----------------

AlleleConservation represents a quantitative score describing the degree to which an allele is conserved across different species.

Most conservation calculations produce a computational score based on a set of multiple sequence alignments across species.  Typically, an algorithm produces a numerical score, to which some metric is applied to determine whether the allele is or is not conserved.   AlleleConservationScore contains only the quantitative score, with an associated AlleleConservation entity containing the qualitative result that is derived from the quantitative result.  

AlleleConservationScore may itself be used to support a CriterionAssessment, or it may support an AlleleConservation that is used to support the CriterionAssessment.
