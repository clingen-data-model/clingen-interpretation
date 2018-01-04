---
title: Statement Qualifiers
model: interpretation
summary: How to negate statements

---

Statements and Negations
------------------------

Evidence for interpretations are typically positive assertions.  That is, a Statement is saying that something is true - an allele lies within a certain region, or an individual has a particular condition.  In some cases, it is useful to make assertions that something is false - the alleles does not overlap the region, or the individual does not have a condition.  

The particular implementation of negation is based on two principles.  First, we wanted a common method for negating any statement.  This is aided by the fact that all of our evidence statements derive from the common Statement class. Second, we wanted our method to produce good idiomatic RDF.  For these reasons, Statement has a qualifier property.  If a statement has this property and the value is the string "NOT", then the statement is negated.
