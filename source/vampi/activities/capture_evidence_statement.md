---
title: CaptureEvidenceStatement
layout: activity
model: interpretation
description: 

---

Scope and Usage
---------------

All interpretations are based on evidence; carefully tracking the evidence is crucial to conveying the reasoning behind an assertion.  Knowing who collected evidence, when it was collected, and from where is especially important when dealing with versioned databases or non-public data sources.  This level of detail allows, for example, resolution of interpretation differences based on knowing which data interpreters had access to, including data that was subsequently revised.

The CaptureEvidenceStatement [activity]() represents the action of finding a piece of evidence in a data source and bringing it within the scope of the interpretation.   If an interpretation is being created in an application, this activity represents bringing the evidence into the application.   The CaptureEvidenceStatment activity uses an [EvidenceStatementSource]() entity, which represents the source of the evidence statement, and generates an [EvidenceStatement]().  It therefore provides the link from a piece of evidence to the source of that evidence.

*image*

