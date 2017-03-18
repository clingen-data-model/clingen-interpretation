---
title: User Guide
description: The overall structure of ClinGen interpretations, and the use of SEPIO.
model: interpretation
TODO: go through here and link to e.g. Entity, EvidenceSTatementSource, ...

---

This guide provides background, use cases, examples, future planning and
collaborations surrounding ClinGen's Variant Interpretation Model. This portion
of the documentation is targeted at the health care providers, scientists,
geneticists, counselors, and researchers that work in or are interested in
curating and interpreting variants.

Introduction
------------

An interpretation is the outcome of structured reasoning applied to evidence.   Interpretations may be made about many kinds of entities using many kinds of evidence, and different formalized reasoning strategies.  Although the overall structure of an interpretation is the same for many cases, the initial version of the interpretation model is limited to interpretations of the pathogenicity of sequence variants using the [ACMG Pathogenicity Guidelines]().   The discussion below will specifically use this context as an example, but the structure of the model is expected to remain largely unchanged as new interpretation contexts are added.

The process of generating this type of interpretation is composed of three kinds of activities:

1. Collecting various forms of **evidence** from potentially many sources such as literature or databases
2. Application of individual **ACMG Guideline Criteria**, in which subsets of this evidence are combined to produce **assessments** using lines of evidence
3. Combination of these assertions to create an overall **interpretation** of the evidence: a statement about the pathogenicity of a given allele.

The process is visualized as a tree.  The root of the tree is the interpretation, and it draws upon the conclusions/assessments of individual ACMG criteria, and those in turn depend on the evidence (the leaves of the tree).

[comment]: # (Probably should be some figure here)

An interpretation without the supporting evidence and reasoning is merely an assertion by somebody.  Inclusion of the evidence and reasoning allows the receiver to draw their own conclusions, and to reasonably build upon the work carried out by an interpretations original creators.

SEPIO
-----

The interpretation model, therefore must contain not only interpretations, but organized and structured information about the evidence and criteria used to create the interpretation, along with metadata about who performed atomic activities and when.  The Scientific Evidence and Provenance Information Ontology ([SEPIO](./sepio.html)) provides such a structure.


[comment]: # (Probably should be some figure here)

W3C-Prov
--------

The [PROV](https://www.w3.org/TR/prov-o/) ontology is another standard for structural
representation of data along with provenance which can provide a more direct record
of the process through which data entities (including assertions) were developed.
Much of our early work in this model was informed by the W3C-Prov working group
recommendations, including the delineation of *Entities* that are produced by *Agents*
in the context of *Activities*.

While we follow SEPIO more closely in terms of our current model, we intend to
maintain a defined mapping between our data representation and one that would
more directly follow PROV-O for the purposes of interoperability.

Discussion
----------

The model is loosely coupled; individual entities (assertions or primary data elements) have at least a conceptual existence outside a given interpretation, so that the same piece of evidence that is generated for one interpretation may be retained, along with its provenance, and used in later interpretations.  

The tree structure of the model is collapsible.  If a user is interested only in the final interpretation, they need to simply access the root node of the structure.  Suppose however, that a user has a discrepant interpretation.  The initial question in such a case would be "which ACMG criteria were used to generate the interpretation?"  The user can answer this question by moving one level in the graph to see which lines of evidence were used by the interpretation.  Suppose further that most of these assessments concur with the users' but that one is not.  Then the user may inspect the branch of the tree corresponding to that conflicting assessment, allowing inspection of the particular evidence and where that evidence came from.
