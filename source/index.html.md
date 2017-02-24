---
title: Interpretation Model
model: interpretation

---

Introduction
------------

The interpretation model provides a structure and format to exchange information about the interpretation of evidence within ClinGen.   It includes the overall interpretation, evidence for the interpretation, and information about where that evidence was obtained, and how it was combined to produce the overall interpretation.   The structure of the interpretation is captured using the [W3C Provenance model.](http://www.w3.org/TR/prov-dm).


Status
------

Version 1 of the interpretation model was released on October XX, 2016.   Version 2, incorporating interpretation across a broader set of entities and styles is currently in the scoping phase.

Scope and Usage
---------------

One of the main goals of the ClinGen project is for expert users to weigh disparate lines of evidence and make reasoned judgments about clinical genetics, which can then be shared with the clinical genetics community.  These interpretations can cover a wide variety of topics such as:

* The pathogenicity of sequence variants in causing Mendelian disease
* The role of structural variants in causing Mendelian disease
* Whether or not a particular gene is involved in causing a given disease
* Whether or not variants in a gene have clinical actionability

While dissemination of such interpretations alone can be useful, the inclusion of supporting evidence allows a richer and deeper use of the interpretation.  Rather than simply knowing that a person or group declared a sequence variant to be pathogenic, receivers of an interpretation will be able to determine

* What evidence was used in this interpretation
* How the evidence supported or conflicted with the interpretation
* Who performed each atomic act in the creation of an interpretation
* The sources of the data used in the interpretation
* How the explicitly defined criteria were applied to the evidence.
* To what degree the interpretation builds upon previous interpretations

The initial version is limited to the modeling of pathogenicity interpretations of sequence variants adjudicated under the ACMG criteria [ref], but later versions will expand upon this topic.


Conceptual Models and Implementation
------------------------------------

The interpretation model is defined as a series of UML classes, representing the conceptual entities in an interpretation.   From this conceptual model, multiple implementations may be created.  In the ClinGen allele model, a particular implementation called a Resource Model was created by grouping together multiple conceptual entities.  In the interpretation model, there is less benefit to doing so; most interpretations will want to keep individual data elements separate so that they may be reused.  For instance, individual pieces of evidence may be used in multiple different interpretations, and implementations will therefore want to keep the data from being agglomerated in a resource model.

In lieu of a resource model, we have created a JSON serialization of interpretations, which will be the format in which interpretations will be downloaded from the ClinGen variant interpretation application and transmitted in the ClinGen data exchange.  


Relationship to Other ClinGen Models
------------------------------------

The interpretation model is versioned separately from the ClinGen allele model, but depends on entities defined by that model, including Contextual and Canonical Allele, Gene, Reference Sequence, and others.

Roadmap
-------

TODO
