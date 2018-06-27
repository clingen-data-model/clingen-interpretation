---
title: Frequently Asked Questions
description: Questions and answers, common topics of discussion and finer points on the use of the variant pathogenicity interpretation model.
model: variant pathogenicity interpretation

---
### Topics
- [Are variants represented with the ClinGen Allele Model, the GA4GH VMC Model, HGVS or something else?](#are-variants-represented-with-the-clingen-allele-model-the-ga4gh-vmc-model-hgvs-or-something-else)
- [What's the difference between a Canonical Allele and a Contextual Allele?](#whats-the-difference-between-a-canonical-allele-and-a-contextual-allele)
- [Why do some places in the model use Canonical Alleles and others use Contextual Alleles?](#why-do-some-places-in-the-model-use-canonical-alleles-and-others-use-contextual-alleles)
- [Is the representation of alleles from the Allele Registry the same as the representation in the Interpretation Model?](#is-the-representation-of-alleles-from-the-allele-registry-the-same-as-the-representation-in-the-interpretation-model)
- [What if I don't want to use Canonical Alleles?](#what-if-i-dont-want-to-use-canonical-alleles)
- [What's a Genetic Condition?](#whats-a-genetic-condition)
- [What is the condition for a benign allele?](#what-is-the-condition-for-a-benign-allele)
- [Can I use the interpretation model for non-ACMG/AMP pathogenicity interpretation?](#can-i-use-the-interpretation-model-for-non-acmgamp-pathogenicity-interpretation)
- [Can I use the interpretation model for non-pathogenicity interpretations?](#can-i-use-the-interpretation-model-for-non-pathogenicity-interpretations)
- [Why isn't there a Gene (or other) data element?](#why-isnt-there-a-gene-or-other-data-element)
- [How are Values constrained?](#how-are-values-constrained)
- [How can I relabel an entity?](#how-can-i-relabel-an-entity)
- [Can I add extra attributes to an object?](#can-i-add-extra-attributes-to-an-object)
- [How are messages validated?](#how-are-messages-validated)
- [What kinds of things can go into value sets?](#what-kinds-of-things-can-go-into-value-sets)
- [Do elements have to be represented inline?](#do-elements-have-to-be-represented-inline)
- [Does ClinVar accept messages in this format?](#does-clinvar-accept-messages-in-this-format)
- [What do I do if I find a problem with the ClinGen Pathogenicity Interpretation Model?](#what-do-i-do-if-i-find-a-problem-with-the-clingen-pathogenicity-interpretation-model)

    <hr class="col-sm-12" />

### Are variants represented with the [ClinGen Allele Model](http://dataexchange.clinicalgenome.org/allele/master/index.html), the [GA4GH VMC Model](https://github.com/ga4gh/vmc), [HGVS](http://varnomen.hgvs.org/) or something else?

Prior to the creation of the Pathogenicity Interpretation Model, The ClinGen Data Model Working Group created an Allele Model that specified a representation of alleles. Subsequently, GA4GH proposed the VMC model.  In later versions, we will bring these two models into alignment, but currently, alleles in interpretations are represented using a slightly modified version of the ClinGen Allele Model.  To show these differences, [ContextualAllele](http://dataexchange.clinicalgenome.org/allele/resource/contextual_allele/) and  [CanonicalAllele](http://dataexchange.clinicalgenome.org/allele/resource/canonical_allele/) have pages in the Interpretation Model documentation.  The changes are very minor - several attribute names have been slightly changed.  

Genotypes and Haplotypes are not elements of the ClinGen Allele Model.  Here they are represented using a simple format inspired by the VMC model.  In later versions, these variant representations will all converge.

<div class="text-right"><a href="#topics">[Top]</a></div>

### What's the difference between a Canonical Allele and a Contextual Allele?

A Contextual Allele is an allele that occurs on a specific sequence.  That sequence may be a chromosome, a transcript, or a protein, and a specific version of that sequence is chosen.   But many Contextual Alleles can be considered equivalent: annotation applied to an allele on one version of a chromosome should also be applicable to the equivalent allele on another version of that chromosome. 

A Canonical Allele is a collection of Contextual Alleles that are considered to be equivalent.  It provides an entity that can have a stable identifier applied to it, so that as new Contextual Alleles are discovered, they can be added to existing Canonical Alleles.

See [this discussion](http://dataexchange.clinicalgenome.org/allele/discussion/canonicalization.html) for more information.
<div class="text-right"><a href="#topics">[Top]</a></div>

### Why do some places in the model use Canonical Alleles and others use Contextual Alleles?

If an allele annotation depends on the sequence on which the allele occurs, then the annotation is made on a Contextual Allele.  As an example, consider molecular consequence.  The consequence of an allele often depends on the exact transcript that is being modified, and the same genomic allele might map to multiple transcript (contextual) alleles, each of which may have its own molecular consequence.

On the other hand, if the annotation is independent of the specific sequence, or if the annotation would be the same no matter which contextual allele was chosen, then the annotation is represented using a Canonical Allele.  This allows the annotation to be uniformly applied to all of the contextual alleles that make up the canonical allele, including those that have not yet been associated with the canonical allele.
<div class="text-right"><a href="#topics">[Top]</a></div>

### Is the representation of alleles from the [Allele Registry](https://reg.clinicalgenome.org/redmine/projects/registry/genboree_registry/landing) the same as the representation in the Interpretation Model?

The Allele Registry is a tool that takes Contextual Alleles as HGVS strings, and returns stable Canonical Allele identifiers, as well as the other Contextual Alleles that comprise the Canonical Allele.  The exact representation of the Canonical Alleles is slightly different from that specified in the Interpretation or Allele models, though it is conceptually similar.  If you are using the Allele Registry to canonicalize your alleles, which is a great idea, you can either simply include the Canonical Allele identifier in the message, or transform the message format into the interpretation model.  There is an Allele class in the [interpretation_json](https://github.com/clingen-data-model/interpretation_json) software package that can perform this translation for you.
<div class="text-right"><a href="#topics">[Top]</a></div>

### What if I don't want to use Canonical Alleles?

While the Allele Model describes the idea and structure of Canonical Alleles,  it does not define a specific algorithm for defining the canonicalization process.  This means that users are free to canonicalize variants in any way that they feel is appropriate for their use case.  Users that don't wish to use Canonical Alleles are effectively stating that there are no equivalencies between any alleles.  To make this statement, each Contextual allele can be wrapped in a trivial Canonical Allele composed of a that single Contextual Allele, and with an identifier that is easily derivable from the Contextual Allele identifier.

<div class="text-right"><a href="#topics">[Top]</a></div>

### What's a Genetic Condition?

The world of bio-ontologies contains numerous ways to describe abnormal states, including various taxonomies of diseases (such as MONDO or  Disease Ontology) and phenotypes (such as the Human Phenotype Ontology).  In this context, the term phenotype describes a granular component of a disease or diseases, such as high-blood pressure.   When clinical geneticists make an interpretation, for instance declaring that a particular allele is pathogenic, they will sometimes want to say that the allele is pathogenic for a given disease. At other times, especially in the case of rare disease, it is possible that the disease has yet to be described or incorporated into a nosology.  In this case, the interpreter will only be able to describe the condition as a set of co-occurring phenotypes.  To cover these use cases in a single data type, we have created Genetic Condition as a collection of diseases and phenotypes, so that interpreters have great freedom in defining the condition while still being able to take advantage of controlled vocabularies.
<div class="text-right"><a href="#topics">[Top]</a></div>

### What is the condition for a benign allele?

The Genetic Condition is an optional entity in a Pathogenicity Interpretation, but the meaning of a benign interpretation is dependent on whether a Genetic Condition is included.   If the interpretation is that the allele is completely benign, for instance if it is a high-frequency variant, then no Genetic Condition needs to be included.  If, on the other hand, the evidence that the allele is benign depends upon information about a particular condition (for instance, that the allele and the disease do not co-segregate), then the evidence supports only the statement that the allele is benign for that specific condition and it should be included as a component of the interpretation.

<div class="text-right"><a href="#topics">[Top]</a></div>

### Can I use the interpretation model for non-ACMG/AMP pathogenicity interpretation? 

Yes.   The model is designed to incorporate different interpretation frameworks, as long as those frameworks fit the same basic structure. That is, there are a set of criteria that are examined based on evidence, and then based on that collection of criteria, an final decision is made.
We provide particular values representing the ACMG/AMP criteria, but users may also define their own criteria.

<div class="text-right"><a href="#topics">[Top]</a></div>

### Can I use the interpretation model for non-pathogenicity interpretations?

The basic structure of non-pathogenicity interpretations, such as somatic interpretations or the interpretation of gene-disease associations is expected to be very similar to pathogenicity interpretations, and we anticipate being able to use the same basic model based on SEPIO.  However, the particular data elements and value sets that we have produced were specifically geared towards pathogenicity interpretations, and are unlikely to contain all of the components necessary for these other interpretation types.    In the coming months, our expectation is that we will create other interpretation profiles to explicitly cover these cases.

<div class="text-right"><a href="#topics">[Top]</a></div>

### Why isn't there a Gene (or other) data element?

Users will notice that there is no class in the data model for Gene. There is also no Disease or Phenotype.  These are not oversights, but intentional decisions based on the following principle: If a data element consists solely of an identifier and a label, then we do not define a class for it.  In these cases, the identifiers will frequently be managed by outside resources such as HGNC, and those resources should be the source of non-identity information about the entity.   Instead of classes, these items are represented simply as identifiers.  Note that in JSON-LD, extra attributes such as "label" can be added to any entry and still validate, reflecting JSON-LD's open-world approach.  Users can therefore attach whatever extra information fits their use case, even to an entry that the model does not specifically create classes for.  In this case, the sender and receiver need to come to agreement on how these extra attributes are meant to be used.

<div class="text-right"><a href="#topics">[Top]</a></div>

### How are Values constrained?

We want to provide constraints on what values can or should be chosen for certain attributes.   Since many of our values are simply values without a type (see question #8), we cannot use type constraints.  Instead, for properties that use values from a value set, we associate the property with that value set in the documentation.  This indicates that only values from that value set can be attached to the given property.  Note, however,  that some value sets are extensible.  In this case, using a value that is not explicitly part of the value set as defined on the model may still be allowed.

<div class="text-right"><a href="#topics">[Top]</a></div>

### How can I relabel an entity?

Terms in ontologies, such as disease ontology, consist of both an identifier and a label.  The identifier is the specific stable string that allows users to understand that they are both talking about the same entity, even if they use different names for it.  However, particular users may have their own set of terms that they use locally for those entities, and which they would like to use in their interpretation messages. For this reason, we have provided the [User Label](/entities/UserLabel.html) object, which can be attached to any term.   Attaching a user label does not change the label of a term, which is provided by the source that creates the term, but it is an extra piece of information that says "User X calls this thing Y".

<div class="text-right"><a href="#topics">[Top]</a></div>

### Can I add extra attributes to an object?

Yes.  The interpretation model does not constrain users from adding extra attributes to an object or a term, as long as the attribute does not conflict with some other part of the model.  For instance, it would be illegal to add an attribute "region" unless it means the same thing as the "region" attribute that has already been defined.  Furthermore, for this to be useful, senders and receivers need to agree on both the meaning and use of these attributes.   In principle, the meaning of new attributes should be defined in an extra JSON-LD context element mapping the name of the attribute to an IRI.

<div class="text-right"><a href="#topics">[Top]</a></div>

### How are messages validated?

There are two kinds of validation that can be performed on JSON-LD pathogenicity interpretation messages.   First, the structure of the messages can be checked to be sure that it conforms to the model. This is accomplished using a JSON schema.  Validation by schema checks to see that elements have the correct type, and the properties of the elements have the correct cardinality.  However, validation by schema does not check values to ensure that they are correct.    Instead, the validator code checks the value set associated with the property to determine whether the value is a member of the value set.  If the value is not a member of the value set, then the validator will either produce a validation error (if the value set is not extensible) or a warning (if the value set is extensible).   The JSON schema and the validator are found in the [interpretation_json](https://github.com/clingen-data-model/interpretation_json) library.

<div class="text-right"><a href="#topics">[Top]</a></div>

### What kinds of things can go into value sets?

Most value sets simply contain IRIs with labels.  These IRIs are not represented by classes in our model (see question #8).  However, value sets are not limited to simple IRIs.   A value set can also contain instances of model classes. For instance, one value set contains [Criteria]() instances corresponding to the criteria in the ACMG/AMP guidelines.   Value sets can conceivably also be composed of heterogeneous types, though none of the stock value sets are so constructed.  Finally, some value sets are dynamically constructed meaning that they outsource the values contained to one or more external resources.  For instance, the gene value set points to HGNC, and declares that any gene defined by HGNC is a valid member of the value set.

<div class="text-right"><a href="#topics">[Top]</a></div>

### Do elements have to be represented inline?

No, the LD in JSON-LD stands for Linked Data.  One idea behind linked data is that an identifier (IRI) can stand in for an object, and that this IRI can be dereferenced to return details of the object if the receiver of the message wants them.   Note however, that the representation of the object may not conform to that specified in the interpretation model.  For instance, alleles in the interpretation model can be canonicalized and given an identifier by the ClinGen Allele Registry.   A sender of messages could either include a representation of the allele as defined in the model, or it could simply include the identifier that the ClinGen Allele Registry produces.  In this latter case, if the receiver uses the identifier to retrieve details from the Allele Registry, it will receive a representation that differs slightly from the representation used in the model.

The approach taken in the [interpretation_json](https://github.com/clingen-data-model/interpretation_json) library is to write an inline version of an entity the first time it is serialized, following the specification of the interpretation model, with subsequent references to that same object simply writing the IRI of the object.  This reduces the burden on the receiver, since they will have the details in a format that are consistent, and it keeps the message as simple as possible by not repeating large chunks of JSON-LD.

<div class="text-right"><a href="#topics">[Top]</a></div>

### Does ClinVar accept messages in this format?

At present, ClinVar only accepts submissions via their spreadsheet interface.  However, we have provided a method for creating a ClinVar submission spreadsheet from a ClinGen Pathogenicity Interpretation message.  The method can be accessed via the [ClinGen Data Exchange]().

<div class="text-right"><a href="#topics">[Top]</a></div>

### What do I do if I find a problem with the ClinGen Pathogenicity Interpretation Model?

Post an issue at our [github]().
