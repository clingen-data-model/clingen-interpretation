---
title: Interpretation Model
model: interpretation

---

Introduction
------------

ClinGen members are generating an incredible amount of richly curated interpretations of the clinical effect of genetic variants.   The ClinGen Interpretation Model provides a structure and format for exchanging this information, which retains the contextual and supporting information related to the interpretation of the variant.

Benefits of the ClinGen Interpretation Model
--------------------------------------------

* Captures a rich set of data around an interpretation:
    * What evidence was used in this interpretation
    * How the evidence supported or conflicted with the interpretation
    * Who performed each individual act in the creation of an interpretation
    * The sources of the data used in the interpretation
    * How the explicitly defined criteria were applied to the evidence
    * To what degree the interpretation builds upon previous interpretations
* Aligns with related community models including:
    * [Monarch SEPIO](https://github.com/monarch-initiative/SEPIO-ontology/wiki){:target="_blank"}
    * [ClinGen Allele Model](http://datamodel.clinicalgenome.org/allele/master/index.html)
* Other features:
    * Flexibility: This model is naturally able to represent a range of interpretation depth, from unsupported assertions to fully evidence-based interpretations, using whatever level of data has been captured.
    * Contains an extensive set of data objects for representing frequently used information
    * Defines a message structure using industry-standard JSON
    * Extensible: Easily transferable to other types of interpretations other interpretation methods
    * Well-documented, including many examples of using the model to encode variant interpretations using all of the ACMG guidelines

Development by Example
----------------------

To ensure that the model supports its intended use case to represent clinical interpretation of
variants, development has been guided by real-world examples based on the application of the [ACMG guidelines](http://www.nature.com/gim/journal/v17/n5/full/gim201530a.html){:target="_blank"}. These examples are available in hierarchical form through the individual pages of the [Technical Reference](tech/), or in a "flattened" form in the [data/flattened](https://github.com/clingen-data-model/clingen-interpretation/tree/master/data/flattened) directory of our source code repository.

Status
------

Version 1 of the interpretation model was [released](user/release_notes.html) October 13, 2017, and allows the description of variant pathogenicity interpretations based on the [ACMG guidelines](http://www.nature.com/gim/journal/v17/n5/full/gim201530a.html){:target="_blank"}.   Version 2 will incorporate variant interpretations across a broader set of entities and styles, and is currently in the scoping phase.

Documentation
-------------

The documentation for the Interpretation Model is divided into two sections.  The [User Guide](user/) is meant for those new to the model, and for those seeking a non-technical explanation describes the structure of the model and its relationships to Monarch SEPIO and W3C-Prov.  The [Technical Reference](tech/) is for technical users and implementers of the model who are already familiar with the overall structure of the model.  The [Technical Reference](tech/) includes detailed information about the data types and attributes used in the data model, as well as numerous examples that show how these types are expressed in a JSON format.
