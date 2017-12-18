---
layout: entity
model: interpretation
id: E01
---

Scope and Usage
---------------

A Statement is the superclass for any declarative statement.  In particular, subclasses of Statment are either 

 1. Supported by evidence (such as VariantInterpretation),
 2. Evidence themselves (such as AlleleConservation), or
 3. Both supported by evidence, and providing support to other statements (such as a CriterionAssessment).

Statement is abstract, and is not ever instantiated directly.  The purpose of this class is to provide a home for attributes shared across all Statements.

Any statement may be negated using the qualifier attribute.  For example, to create a statement saying that a particular allele is not a loss of function allele, the qualifier "NOT" is added to a statement that the allele is a loss of function allele.
