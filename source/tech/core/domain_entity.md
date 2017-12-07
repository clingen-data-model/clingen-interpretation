---
layout: entity
model: interpretation
id: E40
---

Scope and Usage
---------------

Interpretations require references to external objects such as genes or concepts such as missense variation.  Many external naming systems, such as HGNC or Sequence Ontology provide well-curated identifiers for such concepts.   In such cases, users may also wish to apply a label denoting the particular name by which they refer to the same concept.  

In other cases, a concept or entity may not be derived from a naming system. Examples include Individuals and Families.  These are entities that will have a user-given label, but often no externally referenceable identifier.

DomainEntity is a superclass for all such entities, which combines identifiers and labels from a naming system (where available) with a user-applied label (where desired).
