---
layout: entity
model: interpretation
id: E14
---

Scope and Usage
---------------

Clinical geneticists use a variety of methods and systems to define the conditions for which a variant is being interpreted.  In some systems, such as OMIM, the gene is an integral part of the definition of the condition; if a different gene is involved, then the condition is considered to be different.   Other systems include higher-level descriptions where a disease is defined phenotypically, and may result from variants affecting many different genes.  Similar situations hold for mode of inheritance, which may be part of the disease definition in some systems, and not in others.  Furthermore, ontologies may contain terms in which all of these situations occur.  Finally, a condition may not have a previous entry in any nosology, and may only be defined by a given patient with a rare collection of phenotypes.

Rather than enforce one particular view of genetic disease, which would necessarily exclude many popular terminology sets, the ClinGen model treats GeneticCondition in a general way.   The GeneticCondition class, about which VariantInterpretations are written, include a large number of optional items that can be used to define conditions in a flexible way.  For instance, if a single disease from a terminology is used, the GeneticCondition may only have a single disease attribute set.  In the case of a non-predefined disease, a collection of phenotypes may be used.  The two may be combined to indicate a subset of a disease in which other phenotypes additionally occur.

Use of Gene or Mode of Inheritance implies that he used attribute is part of the definition of the condition, not merely an association.  That is, if a Gene is specified, then this GeneticCondition is only the form of a given disease that is caused by the dysfunction of that gene.
