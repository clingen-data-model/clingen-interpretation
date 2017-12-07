---
layout: entity
model: interpretation
id: E52
---

Scope and Usage
----------------

Computational tools can make predictions about the effect of a sequence allele on the normal function and splicing of a gene product.  The InSilicoPrediction element represents these predictions.  ContextualAlleles are used because a ContextualAllele represents an allele within a given sequence, e.g. a particular transcript, since in order to make predictions, these tools require a specific transcript to be specified.

Most predictions create a quantitative score, to which some metric is applied to determine a qualitative result (such as "probably damaging").   The numerical score is encoded in an InSilicoPredictionScore, which may be attached to an InSilicoPrediction as supporting evidence via an EvidenceLine.  InSilicoPredictionScore may support a CriterionAssessment either directly, or via the InSilicoPrediction that represents the score's qualification.
