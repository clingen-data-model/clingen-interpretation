---
title: Projects
model: interpretation
summary: Projects using the interpretation model

---

Introduction
------------

The interpretation model is ClinGen's way to send and receive information about variant pathogenicity.  Here are some tools that can help those implementing the model, and some tools that consume the model.

interpretation_json
--------------------

[Github Repository](http://github.com/clingen-data-model/interpretation_json)

Interpretations in this model are encoded in JSON-LD.   This python package helps to correctly create such JSON-LD messages.  Users of the library can build interpretation objects in code, and then serialize correct JSON-LD.

VCI-transformation
------------------

[Github Repository](http://github.com/clingen-data-model/VCI-transformation)

The ClinGen Variant Curation Interface produces JSON-LD documents, but not in the ClinGen interpretation format.  This script, based on the interpretation_json library, converts interpretations from the native VCI format to the ClinGen format.

clinvar-submitter
-----------------

[Github Repository](http://github.com/clingen-data-model/clinvar-submitter)

ClinVar accepts interpretation submissions using its own spreadsheet-based format.  This tool consumes JSON-LD files in the ClinGen interpretation format, and converts them into valid ClinVar spreadsheets, which can then be manually submitted to ClinVar.

ClinGen Data Exchange
---------------------

The ClinGen Data Exchange is an in-development project that can be used to transmit data throughout the ClinGen ecosystem.   The ClinGen interpretation model will be the native format for transmitting interpretations in the Data Exchange.
