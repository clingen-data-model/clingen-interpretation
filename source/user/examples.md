---
title: Examples
model: interpretation
summary: How to use the JSON model

---

The interpretation model is a series of types and values that is serialized in JSON-LD.  Examples of how objects are constructed, and work together to create meaningful interpretations are provided in the Technical Reference section of the documentation on the pages for individual classes.

In particular, two pages are the most helpful for the overall use of the model.

1. [VariantInterpretation](../tech/variant_interpretation.html) lists several valid encodings of a variant interpretation.  Two of these, [VarInterp274](../tech/details/details.html#VarInterp274) and [VarInterp063](../tech/details/details.html#VarInterp063) are fully-realized examples and may serve as a starting point for exploring the model.

2. [CriterionAssessments](../tech/core/criterion_assessment.html) gives examples of encoding each ACMG Guideline criteria.   These criteria are the heart of the ACMG Variant Pathogenicity process.  Each represents a logical argument made about particular kinds of data, and as such encoding any particular assessment may be challenging.   To overcome this, we have shown examples of how every criteria may be encoded using the present model and data types.

Each example is displayed in multiple formats: 
1. A tabular format highlights the structure and data of the example.
2. A JSON format shows the exact encoding in JSON.
3. A graphical format shows the structure of the document.
