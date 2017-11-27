---
layout: entity
model: interpretation
id: E08
---

Scope and Usage:
----------------

An allele can be assigned a MolecularConsequence by the supposed effect that it has on the gene product.  These consequences can be further grouped into whether or not they are null alleles.  That is, the consequence is so severe that the resulting gene product is non-functional.   

The lof attribute captures information about whether the given ContextualAllele causes such a loss of function.  Note that the lof is highly correlated with consequence, some care must be taken in assigning lof status based on consequence.  For example, stop-gain mutations are generally considered LOF, but if the stop is created near the end of the transcript, a partially functional product may result.
