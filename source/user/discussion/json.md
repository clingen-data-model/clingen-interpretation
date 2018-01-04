---
title: JSON-LD
model: interpretation
summary: Finer points of JSON-LD

---

Introduction
------------

Interpretations are expressed as JSON documents using the types and attributes defined in this documentation.  Furthermore, these JSON documents are actually JSON-LD, where the LD stands for Linked Data.  A full discussion of these formats is beyond the scope of this documentation, but many are easily found online.  Here, we will focus on how our structure takes advantage of JSON-LD.

JSON-LD
-------

JSON is a popular format for messaging due to its flexibility, simplicity, and expressivity.  The composition of maps, lists, and primitives allows for well-structured documents that are readable by both humans and machines.  JSON-LD is an extension of JSON that adds very little obvious complexity, but provides several benefits.

JSON-LD is JSON with several additional keywords, each starting with the @ sign.  In our VariantInterpretations we make use of three of these keywords: @id, @type, and @context.  The @type attribute defines the type of a node, and is one of the types described in this documentation.   Inclusion of this attribute aids in both correct interpretation of a message, and in validation.  The @id and @context attributes are described further below.

@id
---

Each object or node in a JSON-LD document can have an @id property.  The value of this property is an IRI that unambiguously defines the object.   Although it is not required, it is often the case that dereferencing the IRI will return a full description of the object represented by the node.  This allows a great deal of flexibility in the construction of messages, and puts the Linked Data in JSON-LD.  If an IRI can be turned into a representation of an object through dereferencing, then a full representation is not required in the document.  In other words, the following are both valid representations of an allele:

```
"variant": {
    "id": "CAR:CA090919",
    "type": "CanonicalAllele",
    "preferredCtxAllele": {
      "id": "CG-EX:CtxAll039",
      "type": "ContextualAllele",
      "relatedCanonicalAllele": "CanAll035",
      "alleleName": "NM_001369.2(DNAH5):c.7468_7488del",
      "produces": [
        {
          "id": "CG-EX:CtxAll044",
          "type": "ContextualAllele",
          "relatedCanonicalAllele": "CanAll040",
          "alleleName": "NP_001360.1:p.Trp2490_Leu2496del",
          "producedBy": "CtxAll039"
        }
      ]
    }
  }
```

```
"variant": "CAR:CA090919"
```

In the first example, the sender has chosen a representation for the object to pass to the receiver.  It may or may not be a full representation; the sender may have chosen a representation of the object that includes only the information that it thinks the receiver requires.  In the second case, only the IRI identifier for the object is sent.  In either case, the receiver must choose how to process the data it receives, which may include requesting information about the entity from other sources, usually by dereferencing the IRI.

The interpretation model does not require particular choices for senders.  However, in our use of the model we usually include one fully specified version of an entity, and if there are subsequent references to the same object, they are given simply by the IRI.

@context
--------

Our messages might contain an attribute called "Gene".  Is it possible to know whether the property has the same meaning as a "Gene" property in a different document?  Maybe that document is (for unknown reasons) using first names as properties. JSON-LD expands on JSON by allowing JSON properties to be mapped to IRIs, thereby disambiguating property names.  All of the properties in a JSON-LD document can be mapped to an IRI, and this set of mappings is contained in a context file.  The @context property points to the location of this context file, which must be used to interpret the message.

For instance, in the ClinGen Interpretation context file, located [here](http://datamodel.clinicalgenome.org/interpretation/json/context), we find the following mapping:

```
"Gene": {
  "@id": "SO:0000704"
},
```

In our JSON-LD message, we will have this:
```
{
  "id": "CG-EX:CondMech002",
  "type": "ConditionMechanism",
  "mechanism": {
    "id": "SO:0002054",
    "type": "Mechanism",
    "label": "loss of function variant"
  },
  "mechanismConfidence": {
    "id": "SEPIO:0000269",
    "type": "ConditionMechanismStrength",
    "label": "established"
  },
  "gene": {
    "id": "HGNC:5048",
    "type": "Gene",
    "geneSymbol": "HNRNPU"
  },
  "description": "HNRNPU is not associated with any conditions, and therefore LOF is not an established mechanism of any condition for this gene.",
  "@context": "http://datamodel.clinicalgenome.org/interpretation/json/context"
}
```

The context file is defined by the @context tag, and it maps the "gene" property to the IRI "SO:0000704".  Furthermore, an IRI can be found in the context for each property above including "mechanism", "label", "mechanismConfidence", "geneSymbol", and "description".  Finally, note that both "id" and "type" also have mappings in the context.  These entities map to the "@id" and "@type" attributes described above.   This is standard practice in JSON-LD so that if message receivers are JSON aware but not fully JSON-LD compliant, the message can still be undersood.  The same trick cannot be played with @context however.

Besides disambiguation of properties, and the consequent enhancement of data integration, mapping properties to IRIs creates an implicit relationship between JSON-LD and RDF.  In fact, JSON-LD is a particular serialization of RDF, and can be transformed into other formats such as RDF-XML as needed.  It is at this level that the ClinGen interpretation model can be most cleanly seen as an extension to the SEPIO model, which is natively described in RDF.

