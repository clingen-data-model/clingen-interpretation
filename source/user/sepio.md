---
title: SEPIO
model: interpretation
summary: The relationship between ClinGen interpretation and SEPIO

---

Introduction
------------

The Monarch Initiative's [Scientific Evidence and provenance Information Ontology](https://github.com/monarch-initiative/SEPIO-ontology) (SEPIO) is an RDF ontology for the description of evidence and provenance that support scientific claims.  This ontology supports a number of use cases, but is mainly driven by the need to integrate evidence, and computationally assess the level of evidence for a scientific claim.


ClinGen Interpretations are Modeled with SEPIO
----------------------------------------------

An interpretation is a statement about the pathogenicity of a variant, supported by a structured reasoning process applied to evidence; SEPIO's purpose is to capture exactly such structured data.   A ClinGen interpretation is equivalent to an assertion in SEPIO.  Furthermore, the ACMG Clinical Pathogenicty Guideline process, with evidence combined into conclusions at multiple reasoning levels can be naturally modeled using SEPIO's nested structure and Evidence Lines.

Because of this natural alignment, the ClinGen interpretation model has been implemented in terms of the SEPIO ontology.  Version 1.0 of the ClinGen interpretation model is built using terms from the XX release of the SEPIO ontology.

Technical Implementation
------------------------

SEPIO is an RDF ontology defined via OWL files.   The ClinGen interpretation model is expressed as JSON-LD documents, developed in the class-based approach documented at this site.  RDF and class hierarchies are in no way incompatible -- JSON-LD is a serialization of RDF -- but care must be taken to allow complete interchangeability.

In JSON-LD, classes and properties are mapped to IRIs via the use of a context file.  The ClinGen interpretation [context file](http://datamodel.clinicalgenome.org/interpretation/json/context) maps classes and properties to SEPIO terms where available.  

The structure of interpretations maps onto SEPIO such that many terms needed for interpretations were previously defined.  However, variant pathogenicity interpretations also require specialized data elements related to specific types of entities (Alleles, Genes) or evidence (Segregation, Allele Frequencies).   In addition, ClinGen interpretations define new subclasses on SEPIO classes, such as distinguishing VariantInterpretations from CriteriaAssessments.  Each is a SEPIO interpretation, but with different properties.

These terms do not make sense to add to the core SEPIO product, but have been added to ClinGen-specific extensions within the SEPIO project.  In particular, these extensions are found in, which are jointly maintained by the Monarch and ClinGen projects.

For instance, the lines in the [ClinGen interpretation context](http://datamodel.clinicalgenome.org/interpretation/json/context) 

``` "VariantInterpretation": {
   "@id": "SEPIO:0000190"
},
```
indicate that a VariantInterpretation in a ClinGen JSON-LD document is the same entity as the type defined by the id SEPIO:0000190. That SEPIO id is defined in the ClinGen-specific SEPIO extension [here]() as a variant pathogenicity interpretation, which is a subclass of SEPIO:0000001.  SEPIO:0000001 can be found in the [main SEPIO OWL file](), where it is defined as an [Assertion](http://github.com/monarch-initiative/SEPIO-ontology/wiki/Assertion) in SEPIO.

