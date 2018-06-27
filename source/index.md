---
title: Interpretation Model
descrption: Variant Pathogenicity Interpreation model background and benefits, as well as, some insights into the development approach.
model: variant pathogenicity interpretation

---



<div class="btn-group btn-group-justified" role="group" aria-label="...">
    <a href="/getting_started.html" class="btn btn-primary btn-block btn-lg">Getting Started</a>
    <a href="/deeper_dive.html" class="btn btn-primary btn-block btn-lg">A Deeper Dive</a>
    <a href="/faq.html" class="btn btn-primary btn-block btn-lg">FAQ</a>
    <a href="#" class="btn btn-primary btn-block btn-lg">SEPIO Information</a>
</div>

ClinGen members are generating an incredible amount of richly curated interpretations of the clinical effect of genetic variants. The ClinGen Interpretation Model provides a structure and format for exchanging this information, which retains the contextual and supporting information related to the interpretation of the variant.

ClinGen's interpretation model is a profiles of the Monarch Initiative's [Scientific Evidence and provenance Information Ontology](https://github.com/monarch-initiative/SEPIO-ontology/wiki){:target="sepio"} (SEPIO), an OWL ontology for the description of evidence and provenance that support scientific claims.  This ontology supports a number of use cases, but is mainly driven by the need to integrate evidence, and computationally assess the level of evidence for a scientific claim.  
An interpretation is a statement about the pathogenicity of a variant, supported by a structured reasoning process applied to evidence; SEPIO's purpose is to capture exactly such structured data.   



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
    * [Monarch SEPIO](https://github.com/monarch-initiative/SEPIO-ontology/wiki){:target="sepio"}
    * [ClinGen Allele Model](/allele/master/index.html)
* Other features:
    * Flexibility: This model is naturally able to represent a range of interpretation depth, from unsupported assertions to fully evidence-based interpretations, using whatever level of data has been captured.
    * Contains an extensive set of data objects for representing frequently used information
    * Defines a message structure using industry-standard JSON-LD
    * Extensible: Easily transferable to other types of interpretations other interpretation methods
    * Well-documented, including many examples of using the model to encode variant interpretations using all of the ACMG/AMP guidelines

Development by Example
----------------------

To ensure that the model supports its intended use case to represent clinical interpretation of
variants, development has been guided by real-world examples based on the application of the [ACMG guidelines](http://www.nature.com/gim/journal/v17/n5/full/gim201530a.html){:target="acmgguidelines"}. These examples are available in hierarchical form through the individual [Entities](entities/) pages, or in a "flattened" form in the [data/flattened](https://github.com/clingen-data-model/clingen-interpretation/tree/master/data/flattened){:target="githubinterpdata"} directory of our source code repository.

Status
------

Version 1 of the interpretation model was [released](user/release_notes.html) June 27, 2018, and allows the description of variant pathogenicity interpretations based on the [ACMG/AMP guidelines](http://www.nature.com/gim/journal/v17/n5/full/gim201530a.html){:target="acmgguidelines"}.   Version 2 will incorporate variant interpretations across a broader set of entities and styles, and is currently in the scoping phase.
