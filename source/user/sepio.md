---
title: SEPIO
model: interpretation
summary: The relationship between ClinGen interpretation and SEPIO

---

Introduction
------------

The Monarch Initiative's [Scientific Evidence and provenance Information Ontology](https://github.com/monarch-initiative/SEPIO-ontology) (SEPIO) is an RDF-style ontology for the description of evidence and provenance that support scientific claims.  This ontology supports a number of use cases, but is mainly driven by the need to integrate evidence, and computationally assess the level of evidence for a scientific claim.


Connections Between SEPIO and ClinGen Interpretations
-----------------------------------------------------

While the goals of ClinGen and SEPIO differ slightly, the models used to express a scientific claim and the evidence underlying that claim overlap to a large degree.  A ClinGen interpretation is equivalent to an assertion in SEPIO.  Furthermore, the structure of the models, with evidence combined into conclusions at multiple reasoning levels conveys a similar understanding of the domain.

At the moment, however, ClinGen and SEPIO models are not fully interchangeable.  As might be expected from its broader scope, SEPIO is considerably more flexible that the ClinGen model in terms of the types of assertions or data that may be represented.

The ClinGen interpretation model, on the other hand, trades flexibility for specificity, incorporating directly domain concepts such as ACMG pathogenicity guideline criteria, and specific evidence elements modeling the types of data that molecular analysts use.  Further, the ClinGen model is more heavily focused on specifying how provenance for individual steps should be tracked, including the collection of data from various sources.

Finally, the style of the two frameworks differs; SEPIO is an RDF-based ontology, while the initial ClinGen interpretation model has been developed as a group of UML classes.

Ongoing work with SEPIO
-----------------------

While there are differences between these two methods of tracking scientific claims, the underlying structures show a remarkable degree of similarity.   Given the finite lifetime of the ClinGen grant, it makes sense for the ClinGen interpretation model  to figure out the best way to align itself with the SEPIO ontology.  Whether this means moving fully to SEPIO while bringing in necessary ClinGen data elements or creating explicit translations remains to be seen; a decision on the methods here is slated for the second version of the ClinGen interpreation model.   The ClinGen Data Model Working group is conducting an ongoing series of meetings with members of the Monarch Initiative to help define a path forward.
