---
title: DomainEntities and ValueSets
model: interpretation
summary: The use of controlled vocabularies

---

Introduction
------------

Many values in the Interpretation Model should be chosen from a controlled vocabulary.   Documentation about ValueSet and DomainEntity, along with many examples can be found in the technical section of the documentation.  Here, we describe the reasoning and requirements that led to our method of handling terms.

Vocabulary Requirements
-----------------------

Our implementation of these vocabularies has been created to fulfill the following requirements.

1. Individual terms must be defined by an IRI.
2. Where possible, individual terms should be chosen from an externally managed set of terms, such as [Sequence Ontology](http://www.sequenceontology.org/).
3. In some cases, we want the list of terms to be fixed, so that users can only choose one of the prescribed options, but in other cases, we want the list to be expandable, so that users can use or create other relevant terms.
4. For entities such as Gene or Disease, we want to use fully external vocabularies such as HGNC or MONDO without explicitly re-creating term lists in our model.
5. When elements from any of these vocabularies are used in an interpretation message, we want to allow users to attach their own labels to the terms.  Because the terms are defined via their IRI, this does not change the identity of the value, but it allows users to apply locally relevant names to entities such as diseases.


DomainEntity
------------

Individual terms in our controlled vocabularies are defined by IRIs.  To add functionality, we wrap IRIs in objects called DomainEntities.   The DomainEntity serves two purposes.  First, it provides an object to which we can attach user-defined labels for the IRI.  Second, by subclassing DomainEntity we can provide type information for the values in interpretation messages.  This type information can then be used, for instance by JSON schema, to validate messages and ensure that a term used for a particular property is in fact from the correct vocabulary.

ValueSet
--------

Given DomainEntities wrapping terms, we can create ValueSets.   A ValueSet is an entity describing the DomainEntities that are the allowed values for a property. This includes a wide variety of properties such as the molecular effect of a variant, or genes, or types of functional assay, or a discrete set of penetrance values.

The simplest way to construct a ValueSet is to simply create a list of the terms.   Many of the ValueSets used in the interpretation model are created this way.  These ValueSets can be extensible or not. In cases such as a value set describing types of functional assays, we recognize that our listing is incomplete and will require further updates, so the set is extensible; users can use terms not explicitly listed in the value set.  If the value set is not extensible, then only the list of values in the set can be used.

In some cases, the concepts described by a ValueSet are managed by external groups.  For instance, HGNC manages gene entities.  Multiple groups actively manage vocabularies of disease or phenotypes.  In such cases, we do not want to tie our value sets to particular versions of these vocabularies, nor do we want to reproduce the lists.  Rather, we define our ValueSet by simply pointing to these information sources.  This implies that any value found in those vocabularies is also a valid term in our ValueSet.

