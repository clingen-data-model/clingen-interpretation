---
layout: entity
model: interpretation
id: E01
---

Scope and Usage
---------------

Interpretations are created by reasoning over `Statement`s.  Individual atomic pieces of evidence are represented by `Statement` elements.   `Statement` has numerous subclasses, tailored to represent the types of evidence used in the evaluation of ACMG Variant Pathogenicity Guidelines; expansion of the interpretation model into other arenas will also expand the set of available `Statement` types.

The `Statement` entity itself provides no attributes besides those inherited from Entity.   Instances of `Statement` should be instances of a subclass providing data-specific attributes.

