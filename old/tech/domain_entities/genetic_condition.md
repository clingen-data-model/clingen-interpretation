---
layout: entity
model: interpretation
id: E14
---

Scope and Usage
---------------

Numerous ontologies and vocabulary sets have been derived to describe diseases, conditions, and phenotypes.   This class provides a generic wrapper for these terms, as well as allowing a mechanism to define conditions that have not been identified in any existing vocabulary.

The GeneticCondition is most often used to describe monogenic conditions of the type described in OMIM, but it is not restricted to that.  For instance, many ontologies such as the Disease Ontology aggregate monogenic conditions into higher order terms that have similar clinical presentation.  These higher level terms are valid conditions about which to make interpretive statements, but are not strictly monogenic.

There is also widespread disagreement across vocabularies as to whether a mode of inheritance should be modeled as a property of a condition, or a statement about a condition.  We have chosen to add mode of inheritance as a property of the condition.  Because the condition also has a disease, which may be a reference to an external term such as a DOID, this construct allows the user to specify e.g. the dominant form of a DOID and make statements about it.

Mendelian Conditions are rare, and new conditions will be observed.  GeneticCondition allows the specification of a previously unnamed condition via an array of phenotype terms.
