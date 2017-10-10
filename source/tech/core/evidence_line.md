---
layout: entity
model: interpretation
id: E56
---

Scope and Usage
---------------

In SEPIO, assertions are not directly linked to the Statements that make up evidence for the assertion.  Instead, they are connected via an EvidenceLine.  EvidenceLine serves two functions.  

First, EvidenceLine can play a structural role.  Individual Statements are granular, so that several Statements will be required to express a coherent argument.  These Statements may all feed into the same EvidenceLine to indicate that they are used together in satisfying (or falsifying) the Criteria.

Second, EvidenceLine reifies the relationship between an Assertion and its Statements.  That is, it makes the property relationship between those entities into another entity, allowing extra information to be attached to the relationship.  In SQL, this would be equivalent to making a join table between entities so that extra columns can be added to attach extra information to the join.  In particular, the strength of an EvidenceLine is a property describing how much support some evidence provides for an Assertion.  This is not simply a property of the evidence; evidence that provides strong support for one assertion, may provide no support for another.
