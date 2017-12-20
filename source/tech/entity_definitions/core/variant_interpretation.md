---
layout: entity
model: interpretation
id: E35

---

Scope and Usage
---------------

A VariantInterpretation is a statement about the pathogenicity of a given CanonicalAllele, usually for a given MendelianCondition.  A VariantInterpretation does not explicitly contain the reasoning and evidence supporting the conclusion, but that information is referenced in the provenance of the VariantInterpretation entity.  That is, the VariantInterpretation is, for example, the statement that a variant is pathogenic, the reasoning for that conclusion is found by following the EvidenceLines of the VariantInterpretation.

VariantInterpretations for pathogenic variants will include a MendelianCondition for which the conclusion was reached.  However, if the variant is determined to be benign (such as in the case of a very common polymorphism), then the condition attribute may be unused indicating that the allele is benign for all conditions.  If a Condition is specified for a benign variant, then the conclusion that the allele is benign is limited to that specific condition.

While the EvidenceLines should be sufficient to understand the reasoning behind a given VariantInterpretation, a human-readable statement of this reasoning may be included in the explanation attribute (inherited from Entity).

VariantInterpretations are frequently updated when new information becomes available, or during periodic review.  In such a case, a new VariantInterpretation is created.  A tie to the original VariantInterpretation can be maintained using the wasDerivedFrom attribute, which indicates the previous version of the current VariantInterpretation.

Primary Examples
----------------

[VarInterp274](../details/details.html#CG-EX:VarInterp274) and
[VarInterp063](../details/details.html#CG-EX:VarInterp063) are fully-realized examples
and may serve as a starting point for exploring the model.
