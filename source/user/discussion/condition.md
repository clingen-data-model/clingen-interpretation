---
title: Genetic Condition
model: interpretation
summary: How to use disease, phenotype, and condition

---

Introduction
------------

Clinical geneticists use a variety of methods and systems to define the conditions for which a variant is being interpreted.  In some systems, such as OMIM, the gene is an integral part of the definition of the condition; if a different gene is involved, then the condition is considered to be different.   Other systems include higher-level descriptions where a disease is defined phenotypically, and may result from variants affecting many different genes.  Similar situations hold for mode of inheritance, which may be part of the disease definition in some systems, and not in others.  Furthermore, ontologies may contain terms in which all of these situations occur.  Finally, a condition may not have a previous entry in any nosology, and may only be defined by a given patient with a rare collection of phenotypes.

Disease, Phenotype, and GeneticCondition
----------------------------------------

Rather than enforce one particular view of genetic disease, which would necessarily exclude many popular terminology sets, the ClinGen model provides numerous options for describing conditions.  Specifically, the model includes classes for both Disease and Phenotype, which are DomainEntities corresponding to terms from externally managed vocabularies such as MONDO for diseases or HPO for phenotypes.

To allow for the wide variety of condition definitions described in the introduction, we introduce the GeneticCondition class as the structure used in VariantInterpretations.  That is, a GeneticCondition is the entity for which a variant can be described as being benign or pathogenic.  GeneticConditions include a large number of optional items that can be used to define conditions in a flexible way.  For instance, if a single disease from a terminology is used, the GeneticCondition may only have a single disease attribute set.  In the case of a non-predefined disease, a collection of phenotypes may be used.  The two may even be combined to indicate a subset of a disease in which other phenotypes additionally occur.

Conditions for Benign Variants
------------------------------

What should be used as the condition for benign variants?  Some users see benign variants as fully benign - a benign variant is one that does not cause any genetic condition.  However, this is not always the most descriptive interpretation.  We distinguish two cases:

1. The evidence examined indicates that the variant is benign for any sufficiently rare, penetrant condition.  This is often the case if the variant has a high population frequency.  In this case, the ACMG Guidelines would allow a stand-alone benign interpretation of the variant for any condition to which the guidelines are applicable, and a GeneticCondition does not need to be included on the VariantInterpretation.

2. The evidence examined is specific to a particular condition. For instance, if the frequency of the condition is much lower than the frequency of the allele, then there is strong reason to believe that the variant is benign, but only for the condition with that frequency.  In this case, the evidence only supports a benign call for a particular condition, and the condition must be included as an element in the VariantInterpretation.
