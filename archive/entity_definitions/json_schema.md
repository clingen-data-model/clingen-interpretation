---
title: JSON Schema
model: variant pathogenicity interpretation
description: JSON Schema to validate the variant pathogenicity interpretation model

---

## Introduction
The ClinGen interpretation model is realized in JSON-LD documents.   Given the flexibility in the model and the complexity of the domain, it can be difficult to determine whether a given interpretation follows the rules layed out by the model.  Our JSON Schema can be used to validate interpretation documents.

## JSON Schema
JSON documents can be validated using [JSON Schema](http://json-schema.org/).  A JSON Schema is itself a JSON document that defines correctly constructed JSON documents in a particular domain.   Within such a schema, a user will find explicit definitions of entities appearing in a JSON document, and the rules for how these entities are used together to create a message.  Because the JSON Schema is written in JSON it is both human and computer readable, and can be used to automatically validate documents.   A readable introduction to JSON Schema and their creation can be found [here](https://spacetelescope.github.io/understanding-json-schema/).

##ClinGen Interpretation JSON Schema
The JSON schema for ClinGen Variant Interpretations can be found in our [github repository](https://github.com/clingen-data-model/clingen-interpretation/blob/master/data/schema/variantInterpretation.json).  

The largest section of the schema, the entity definitions, lays out the JSON encoding of each entity described in this documentation, including the names and types of the properties that comprise an entity.

##JSON Validation
The purpose of JSON Schema is to enable validation of JSON documents.   Validation using this schema is currently performed on input to the [ClinVar Submitter](http://github.com/clingen-data-model/clinvar-submitter) and will be incorporated into the ClinGen Data Exchange.

Users wishing to incorporate this functionality into own code can use [libraries](http://json-schema.org/implementations.html) in nearly any language.

In addition, there exist numerous [online validators](https://www.jsonschemavalidator.net/) that can be used to explore interpretation document validation.
