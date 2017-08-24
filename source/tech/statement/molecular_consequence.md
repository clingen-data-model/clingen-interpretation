---
layout: entity
model: interpretation
id: E02
---

Scope and Usage:
----------------

An allele can be classified by the effect that it has on the gene product.  For instance, an allele may create a stop codon or modify an amino acid.  These effects are considered as a consequence; terms for these consequences have been compiled in the Sequence Ontology.  In addition, some of these consequences can be grouped into whether or not they cause a loss of function.  That is, the consequence is so severe that the resulting gene product is non-functional.   The lof attribute captures information about whether the given ContextualAllele causes such a loss of function.  Note that the lof is highly correlated with consequence, some care must be taken in assigning lof status based on consequence.  For example, stop-gain mutations are generally considered LOF, but if the stop is created near the end of the transcript, a partially functional product may result.
