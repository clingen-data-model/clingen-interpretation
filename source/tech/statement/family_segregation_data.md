---
layout: entity
model: interpretation
id: E45
---

Scope and Usage
---------------

The FamilySegregationData element represents co-segregation of an allele and a condition within a particular family.   The segregation can be characterized using a series of aggregate counts, such as the number of individuals that have both the allele and the condition, or those with the allele but not the condition.

In addition, or instead, the specific family details can be provided in pedigree file format.  The contents of a pedigree file are stored as a string in the pedigree attribute, and the columns, genotypeValues, and affectedValues provide the metadata required to fully interpret the coding of the pedigree file, for instance, mapping 0/1 genotype codes in the pedigree file to named alleles.
