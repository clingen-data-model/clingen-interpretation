---
title: CriterionAssessment
layout: entity
model: interpretation
id: E09
---

Scope and Usage
---------------

A CriterionAssessment represents the result of applying a named Criterion to a set of Data.   

A VariantInterpretation is based on assessing different lines of evidence, such as population frequency data, or case-control studies.  A CriterionAssessment is the result of gathering together the data necessary to understand a single line of evidence, and deciding how that set of evidence hangs together to create a single unit of understanding. One or more CriterionAssessments, each of which describes a judgement about a particular line of evidence, are then subsequently combined to produce the final interpretation.

In addition to the Data, the CriterionAssessment references a particular Criterion.  The Criterion is a pre-defined rule that describes how to use a particular type of data to reach a conclusion. 

In the context of ACMG Variant Pathogenicity interpretations, a Criterion is a particular rule, such as PM1, and the CriterionAssessment is the statement, for example, that this set of evidence provides moderate support that the variant is pathogenic, or that the evidence is insufficient to apply the Criterion.

A CriterionAssessment that lacks the Criterion attribute represents a conclusion based on a set of evidence, but which is evaluated in a way outside of a pre-defined set of criteria.  While a Criterion is preferable, and will be expressly required in certain cases, making this attribute optional allows the model to express interpretation structures that are constructed outside of the ACMG Guideline framework.

Given the Criterion and the Data, the logic of a particular CriterionAssessment is meant to be transparent.  However, to be complete, a human-readable description of the reasoning behind a CriterionAssessment may be included in the explanation attribute (inherited from Entity).
