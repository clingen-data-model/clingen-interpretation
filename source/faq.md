---
title: Discussion
description: Finer points on the use of the interpretation model
model: interpretation

---

1. Are variants represented with the [ClinGen Allele Model](), the [GA4GH VMC Model](), [HGVS]() or something else?

Prior to the creation of the Pathogenicity Interpretation Model, The ClinGen Data Model Working Group created an Allele Model that specified a representation of alleles. Subsequently, GA4GH proposed the VMC model.  In later versions, we will bring these two models into alignment, but currently, alleles in interpretations are represented using a slightly modified version of the ClinGen Allele Model.  To show these differences, [ContextualAllele]() and  [CanonicalAllele]() have pages in the Interpretation Model documentation.  The changes are very minor - several attribute names have been slightly changed.  

Genotypes and Haplotypes are not elements of the ClinGen Allele Model.  Here they are represented using a simple format inspired by the VMC model.  In later versions, these variant representations will all converge.

2. What's the difference between a Canonical Allele and a Contextual Allele?

A Contextual Allele is an allele that occurs on a specific sequence.  That sequence may be a chromosome, a transcript, or a protein, and a specific version of that sequence is chosen.   But many Contextual Alleles can be considered equivalent: annotation applied to an allele on one version of a chromosome should also be applicable to the equivalent allele on another version of that chromosome. 

A Canonical Allele is a collection of Contextual Alleles that are considered to be equivalent.  It provides an entity that can have a stable identifier applied to it, so that as new Contextual Alleles are discovered, they can be added to existing Canonical Alleles.

3. Why do some places in the model use Canonical Alleles and others use Contextual Alleles?

If an allele annotation depends on the sequence on which the allele occurs, then the annotation is made on a Contextual Allele.  As an example, consider molecular consequence.  The consequence of an allele often depends on the exact transcript that is being modified, and the same genomic allele might map to multiple transcript (contextual) alleles, each of which may have its own molecular consequence.

On the other hand, if the annotation is independent of the specific sequence, or if the annotation would be the same no matter which contextual allele was chosen, then the annotation is represented using a Canonical Allele.  This allows the annotation to be uniformly applied to all of the contextual alleles that make up the canonical allele, including those that have not yet been associated with the canonical allele.

4. Is the representation of alleles from the [Allele Registry]() the same as the representation in the Interpretation Model?

The Allele Registry is a tool that takes Contextual Alleles as HGVS strings, and returns stable Canonical Allele identifiers, as well as the other Contextual Alleles that comprise the Canonical Allele.  The exact representation of the Canonical Alleles is slightly different from that specified in the Interpretation or Allele models, though it is conceptually similar.  If you are using the Allele Registry to canonicalize your alleles, which is a great idea, you can either simply include the Canonical Allele identifier in the message, or transform the message format into the interpretation model.  There is an Allele class in the interpreation_json software package that can perform this translation for you.

5. What if I don't want to use Canonical Alleles?

While the Allele Model describes the idea and structure of Canonical Alleles,  it does not define a specific algorithm for defining the canonicalization process.  This means that users are free to canonicalize variants in any way that they feel is appropriate for their use case.  Users that don't wish to use Canonical Alleles are effectively stating that there are no equivalencies between any alleles.  To make this statement, each Contextual allele can be wrapped in a trivial Canonical Allele composed of a that single Contextual Allele, and with an identifier that is easily derivable from the Contextual Allele identifier.

4. What's a genetic condition?

5. What is the condition for a benign allele?

6. How can I relabel an entity?

7. Can I use the interpretation model for non-ACMG/AMP pathogenicity interpretation? 

8. Can I use the interpretation model for non-pathogenicity interpretations?

9. Why isn't there a Gene (or other) data element?

10. How are messages validated?

11. Do elements have to be represented inline?

12. Does ClinVar accept messages in this format?

