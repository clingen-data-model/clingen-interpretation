---
title: Supported queries
description: Use cases for queries to be supported by the allele model.
model: interpretation

---

Overview
--------

Here are described a selection of queries that should be supported by the data model. As the model is developed, we will update this page with examples for how to perform these queries using the model.

Queries common to all assertions
--------------------------------

* Find all the evidence used to make an assertion
* Find the criteria used to make an assertion.
* List the assertions leading up to (and invalidated by) the most credible assertion.
* Rank assertions on a topic from most to least credible.


Variant-disease assertions
--------------------------

* Find all assertions that have been made about a variant
* Find the [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/) star level of the assertions made about a variant.
* Find the most credible (highest star level) assertion made about a variant and report the pathogenicity.


Gene-disease assertions
-----------------------

* Find all variant assertions involving a gene for any disease.
* Find all variants asserted as pathogenic for a gene-disease pair.
