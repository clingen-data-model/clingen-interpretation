---
layout: entity
model: interpretation
id: E46
---

Scope and Usage
---------------

Co-segregation of alleles and conditions is evaluated per-family, but may then be aggregated across families.  This Data type represents such an aggregation.  Instances may refer to FamilySegregationData that represent the per-family segregation results that are aggregated together, but this is not required.

AggregateSegregationData requires a particular CanonicalAllele and Condition, and it is the co-segregation of these entities that is described.   In addition, a modeOfInheritance may be given, indicating the inheritance pattern to be used for interpreting the segregations.

AggregateSegregationData also provides numerous attributes summarizing data across families, counting the numbers of segregations and sets of individuals in the families, based on their allele and condition status.

If LOD scores are used in the family segregations, these LODS may be combined to a total LOD score as well, though this is not required.
