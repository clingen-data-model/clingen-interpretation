---
layout: entity
model: interpretation
id: E33
---

Scope and Usage
---------------

An AssertionMethod is composed of multiple Criteria. Each Criteria is assessed against a set of evidence Statements; the assessment lends support for or against an interpretation.   From this set of multiple assessments, a final interpretation is created.  A ScoringAlgorithm describes the how a set of assessments is combined or reconciled to produce an overall interpretation.  

ScoringAlgorithms are properties of AssertionMethods.  A ScoringAlgorithm describes the algorithm, rather than an implementation of that algorithm.  In other words, the ScoringAlgorithm for the ACMG Variant Pathogenicity Guidelines is the algorithm described in text and figures in the guideline paper, rather than e.g. the Baylor Pathogenicity Calculator.  The use of a particular implementation can be denoted using a Contribution on the interpretation.  
