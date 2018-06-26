---
title: SEPIO
model: interpretation
summary: The relationship between ClinGen interpretation and SEPIO

---

Introduction
------------

The Monarch Initiative's [Scientific Evidence and provenance Information Ontology](https://github.com/monarch-initiative/SEPIO-ontology/wiki){:target="sepio"} (SEPIO) is an OWL ontology for the description of evidence and provenance that support scientific claims.  This ontology supports a number of use cases, but is mainly driven by the need to integrate evidence, and computationally assess the level of evidence for a scientific claim.


ClinGen Interpretations are Modeled with SEPIO
----------------------------------------------

An interpretation is a statement about the pathogenicity of a variant, supported by a structured reasoning process applied to evidence; SEPIO's purpose is to capture exactly such structured data.   A ClinGen interpretation is equivalent to an assertion in SEPIO.  Furthermore, the ACMG Clinical Pathogenicty Guideline process, with evidence combined into conclusions at multiple reasoning levels can be naturally modeled using SEPIO's nested structure and Evidence Lines.

In order to combine the expertise of Monarch Initiative in creating ontologies describing scientific information and the expertise of ClinGen in variant interpretation and modelling, the ClinGen interpretation model has been implemented in terms of the SEPIO ontology.  Version 1.0 of the ClinGen interpretation model is built using terms from the XX release of the SEPIO ontology.

Technical Implementation
------------------------

SEPIO is an OWL ontology.  The ClinGen interpretation model is expressed as [JSON-LD](https://json-ld.org){:target="jsonld"} documents, developed in the class-based approach documented at this site.  RDF and class hierarchies are in no way incompatible -- [JSON-LD](https://json-ld.org){:target="jsonld"} is a serialization of RDF -- but care must be taken to allow complete interchangeability. In [JSON-LD](https://json-ld.org){:target="jsonld"}, classes and properties are mapped to IRIs in SEPIO and related ontologies via the use of a [context file](http://datamodel.clinicalgenome.org/interpretation/json/context). 

Many terms needed for variant pathogenicity interpretations were previously defined SEPIO. Variant pathogenicity interpretations also require specialized data elements related to specific types of entities (Alleles, Genes) or evidence (Segregation, Allele Frequencies).  In addition, ClinGen interpretations define new subclasses on SEPIO classes, such as distinguishing VariantInterpretations from CriteriaAssessments.  Each is a SEPIO interpretation, but with different properties. These terms do not make sense to add to the core SEPIO product, but have been added to ClinGen-specific extensions within the SEPIO project which are jointly maintained by the Monarch and ClinGen projects.

For instance, the lines in the [ClinGen interpretation context](http://datamodel.clinicalgenome.org/interpretation/json/context) 

``` "VariantInterpretation": {
   "@id": "SEPIO:0000190"
},
```
indicate that a VariantInterpretation in a ClinGen JSON-LD document is the same entity as the type defined by the id SEPIO:0000190. That SEPIO id is defined in the [ClinGen-specific SEPIO extension here](https://github.com/monarch-initiative/SEPIO-ontology/blob/master/src/ontology/extensions/sepio-clingen.owl){:target="sepio"} as a variant pathogenicity interpretation, which is a subclass of SEPIO:0000001.  SEPIO:0000001 can be found in the [main SEPIO OWL file](https://raw.githubusercontent.com/monarch-initiative/SEPIO-ontology/master/src/ontology/sepio.owl){:target="sepio"}, where it is defined as an [Assertion](http://github.com/monarch-initiative/SEPIO-ontology/wiki/Assertion){:target="sepio"} in SEPIO.

