---
title: Alleles, Haplotypes, and Genotypes
model: interpretation
summary: The ClinGen Allele Model and the GA4GH VMC model

---

Introduction
------------

Genetic variation is the fundamental concept of genetic medicine; pathogenicity interpretations are interpretations about the health effects of sequence variants.  Therefore, an interpretation format must be able to represent genetic variation.  This page discusses the kinds of genetic variation to be included, the difficulties in representation, different models for representing variation, and the suggested use of these models in the interpretation model, and plans for the future.


Types of Genetic Variation
--------------------------

The wide spectrum of human genetic variation is usually divided into large structural variants and smaller sequence variants.  In both cases, variation is described as differences from a particular reference sequence such as a chromosome or transcript sequence.  Sequence variants, such as SNPs or small indels, are the type of variation to which the AMCG Variant Pathogenicity guidelines can be applied.  A particular example of variation at a single location is also called an Allele.

Because humans are diploid, two alleles in an individual may appear on the same chromosome (in *cis*), or on different chromosomes (in *trans*).  Alleles that occur in *cis* form a Haplotype.  Alleles (or Haplotypes) in *trans* form Genotypes.

Normalization and Canonicalization
----------------------------------

One of the most insidious difficulties encountered in dealing with genomic variation is the fact that a single genomic variant can be described in multiple ways.  

As a simple illustration, suppose that in a reference sequence is a run of 3 A's.  In an individual, only 2 A's appear.  This could variously be described as:

1) A deletion of the first A
2) A deletion of the second A
3) A deletion of the third A
4) A substitution of AAA with AA

We define the process of choosing a single representation of variation against a single reference as normalization.

A related, and still more complicated problem is that a real physical variant can be described as a variation with respect to multiple reference sequences.  For instance, a genomic variant may be defined with respect to many different versions of the genome, or with respect to one of potentially many overlapping transcript, or by the effect that the change has on an amino acid sequence.

We define the process of recognizing the same entities in this myriad of representations as canonicalization.  Normalization, recognition of the same entity from different representations against a single reference sequence, is a subset of canonicalization, which recognizes the entity across one or more reference sequences.

Variation Models and their Use
------------------------------

The [ClinGen Allele Model](http://datamodel.clinicalgenome.org/allele/master/index.html) is the primary way to represent alleles in the ClinGen Interpretation Model.   Full explanation of this model is outside the scope of this documentation, but can be found at the link above.  Briefly, the AlleleModel differentiates between ContextualAlleles, which are defined with respect to a particular reference sequence, and CanonicalAlleles, which are a collection of ContextualAlleles that are different representations of the same physical variant across any reference sequences.  

The ClinGen Allele Model implements Haplotypes as another form of CanonicalAllele that is constructed from a set of CanonicalAlleles in *cis*.  However, the ClinGen Allele Model does not provide structures for handling Genotypes, or Alleles in *trans*.

After the completion of the ClinGen Allele Model, the Global Alliance for Genomic Health (GA4GH) [Variation Modeling Collaboration](https://github.com/ga4gh/vmc) (VMC) implemented and released a variant model, focused on the representation of a variants against a single reference sequence.  The VMC model includes structures for Alleles, Haplotypes, and Genotypes, as well as guidance on their use to enable normalized variants.  The VMC model at present does not consider the recognition of variants across different reference sequences (i.e. canonicalization).

Most alleles in the ClinGen Interpretation Model are represented as CanonicalAlleles.  The benefit of using CanonicalAlleles is that interpretations can be easily be compared across different reference sequences, for instance as new versions of the human genome are released.  This implies that users for the Interpretation Model will have a method to canonicalize their variants, i.e. to recognize the same variant across different reference sequences and give them the same identifier.  One implementation of such a canonicalizer, and the one used in the ClinGen project is the [Baylor Allele Registry](http://reg.clinicalgenome.org/redmine/projects/registry/genboree_registry/landing).  The Allele Registry can be queried with HGVS expressions, and returns CanonicalAlleles, as well as the corresponding ContextualAlleles.

For the application of certain ACMG Pathogenicity guidelines, it is important to describe alleles as occurring in *cis* or in *trans*.  Haplotypes (i.e. *cis* alleles) are represented as ClinGen Complex CanonicalAlleles.  Genotypes are represented using a VMC-inspired Genotype structure.

Plans for the Future
--------------------

The VMC model incorporates many of the insights derived from work on the ClinGen Allele Model.  As a model with obvious merits, and one endorsed by the GA4GH, we anticipate widespread adoption of the VMC model. Over the coming months, the VMC will be adding notions of equivalence, a more granular version of the ClinGen model's canonicalization.  As this work proceeds, we anticipate transitioning from the ClinGen Allele Model, to the similar but more widely supported VMC model.

