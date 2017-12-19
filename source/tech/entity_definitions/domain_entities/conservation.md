---
layout: entity
model: interpretation
id: E80
---

Scope and Usage
---------------

The Conservation DomainEntity contains only a single value, denoting that a sequence feature is conserved.   A statement that a sequence feature is not conserved is created by composing this DomainEntity with a qualifier at the Statement level.  In other words, an AlleleConservation Statement would contain both a Conservation DomainEntity, and a value "NOT" for its qualifier property.

This DomainEntity wraps values from a ValueSet, see the [discussion](../../../user/discussion/domain_entity.html) for more on this topic.

