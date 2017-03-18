---
title: Interpretation Model
model: interpretation

---

Introduction
------------

ClinGen members are generating an incredible amount of richly curated interpretations of the clinical effect of genetic variants.   The ClinGen Interpretation Model provides a structure and format for exchanging this information, retaining the full ecosystem of contextual and supporting information.

Benefits of the ClinGen Interpretation Model
--------------------------------------------

* Enables captures a rich set of data around an interpretation:
    * What evidence was used in this interpretation
    * How the evidence supported or conflicted with the interpretation
    * Who performed each atomic act in the creation of an interpretation
    * The sources of the data used in the interpretation
    * How the explicitly defined criteria were applied to the evidence.
    * To what degree the interpretation builds upon previous interpretations
* Aligns with related community models including:
    * [Monarch SEPIO](https://github.com/monarch-initiative/SEPIO-ontology/wiki)
    * [ClinGen Allele Model](http://datamodel.clinicalgenome.org/allele/master/index.html)
* Other features:
    * Flexible: Naturally able to represent a range of interpretation depth, from unsupported assertions to fully evidence-based interpretations, using whatever level of data has been captured.
    * Contains an extensive set of data objects for representing frequently used information.
    * Defines a message structure using industry-standard JSON.
    * Extensible: Easily transferable to other types of interpretations other interpretation methods.
    * Well-documented, including many examples of using the model to encode variant interpretations using all of the ACMG guidelines.


Status
------

Version 1 of the interpretation model is planned for the first quarter of 2017, and will allow the description of variant pathogenicity interpretations based on the [ACMG guidelines](http://www.nature.com/gim/journal/v17/n5/full/gim201530a.html).   Version 2, incorporating interpretation across a broader set of entities and styles is currently in the scoping phase.

Documentation
-------------

The following documentation is divided into two sections.  The [User Guide](user/) is meant for those new to the model, or for those seeking a non-technical explanation describes the structure of the model and its relationships to Monarch SEPIO and W3C-Prov.  The [Technical Reference](tech/) is for technical users and implementers of the model.  This section includes detailed information about the types and attributes of the data model, as well as numerous examples that show how these types are expressed in a JSON format.
