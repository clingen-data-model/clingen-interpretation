---
layout: entity
model: interpretation
id: E36
---

Scope and Usage
---------------

All Data used in an interpretation came from a DataSource.  The DataSource is the citation for the Data, so that the consumer of an Interpretation can return to the DataSource and understand whether the Data has been correctly understood and represented.  A DataSource may represent a range of entities such as publications or public or private data repositories.

The attributes of the DataSource should be sufficient to allow a consumer to locate the Data in the DataSource.   If a DataSource is versioned, the version, as well as any identifiers used in the DataSource should be represented.   The externalIdentifier and linkedIRI attributes point not just to the data repository (such as ExAC) but to the individual data element being referenced.

Private databases, such as clinical repositories are a challenge to represent, as many will lack a publicly exposable identifier to individual elements of Data.   In this case, the externalIdentifier is meant to be a string sufficient to identify the Data, even if it is not the identifier that is actually used in the repository.

DataSource inherits from Entity and is referred to by the used attribute of the CaptureData Activity.   Because it is an Entity, its provenance may also be stored, indicating how the DataSource itself was generated.  However, this is outside the scope of the Interpretation model, and will be implementation specific.
