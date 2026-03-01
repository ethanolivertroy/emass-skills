---
name: emasser-put
description: Execute eMASSer CLI PUT commands to update existing data in the eMASS API. Use when updating security controls, modifying POA&Ms, updating milestones, replacing artifacts, or updating hardware/software baseline assets.
user-invocable: true
argument-hint: "[controls|poams|milestones|artifacts|hardware|software]"
---

# eMASSer PUT Commands

You are an expert in using the eMASSer CLI PUT endpoints to update existing data in the eMASS API.

## Prerequisites
- eMASSer CLI installed and `.env` file configured (see emasser-setup skill)
- Valid eMASS API credentials and access
- Existing records to update (system ID, POA&M ID, etc.)

## Common Flags
- Boolean TRUE: `--flagName`
- Boolean FALSE: `--no-flagName`
- Dates: Unix time format (e.g., `1499990400`)

---

## Controls
Update a security control's implementation plan.

```bash
emasser put controls update \
  --systemId <systemId> \
  --acronym "<AC-1>" \
  --responsibleEntities "<description>" \
  --controlDesignation <Common|System-Specific|Hybrid> \
  --estimatedCompletionDate <unix-timestamp> \
  --comments "<comments>"
```

**Implementation Status → Required Fields:**
| implementationStatus | Additional Required Fields |
|----------------------|---------------------------|
| Planned or Implemented | `--controlDesignation`, `--estimatedCompletionDate`, `--responsibleEntities`, `--slcmCriticality`, `--slcmFrequency`, `--slcmMethod`, `--slcmTracking`, `--slcmComments` |
| Not Applicable | `--naJustification`, `--controlDesignation`, `--responsibleEntities` |
| Manually Inherited | `--controlDesignation`, `--estimatedCompletionDate`, `--responsibleEntities`, `--slcmCriticality`, `--slcmFrequency`, `--slcmMethod`, `--slcmTracking`, `--slcmComments` |

```bash
# Example: Mark a control as Implemented
emasser put controls update \
  --systemId 100 \
  --acronym "AC-1" \
  --responsibleEntities "IT Security Team" \
  --controlDesignation System-Specific \
  --estimatedCompletionDate 1735689600 \
  --comments "Access control policy reviewed and updated." \
  --implementationStatus Implemented \
  --slcmCriticality "High - critical system" \
  --slcmFrequency Quarterly \
  --slcmMethod Automated \
  --slcmTracking "Tracked via SIEM" \
  --slcmComments "Automated monitoring in place"
```

**Character Limits (2,000):** `naJustification`, `responsibleEntities`, `implementationNarrative`, `slcmCriticality`, `slcmReporting`, `slcmTracking`, `vulnerabilitySummary`, `recommendations`  
**Character Limits (4,000):** `slcmComments`

---

## POA&Ms
Update an existing POA&M item.

```bash
emasser put poams update \
  -s <systemId> \
  -p <poamId> \
  --status <Ongoing|Risk Accepted|Completed> \
  --vulnerabilityDescription "<description>" \
  --sourceIdentifyingVulnerability "<source>" \
  --pocOrganization "<org>" \
  --resources "<resources>"
```

**Status-Dependent Required Fields:**
| Status | Additional Required Fields |
|--------|---------------------------|
| Risk Accepted | `--comments`, `--resources` |
| Ongoing | `--scheduledCompletionDate`, `--resources`, `--milestones` (at least 1) |
| Completed | `--scheduledCompletionDate`, `--comments`, `--resources`, `--completionDate`, `--milestones` (at least 1) |

```bash
# Example: Update POA&M to Completed status
emasser put poams update \
  -s 100 \
  -p 45 \
  --status Completed \
  --vulnerabilityDescription "Missing patch for CVE-2024-1234" \
  --sourceIdentifyingVulnerability "ACAS scan" \
  --pocOrganization "IT Security" \
  --resources "Security team" \
  --scheduledCompletionDate 1735689600 \
  --completionDate 1735603200 \
  --comments "Patch successfully applied and verified." \
  --milestone description:"Patch applied" scheduledCompletionDate:1735603200
```

---

## Milestones
Update an existing milestone.

```bash
emasser put milestones update \
  -s <systemId> \
  -p <poamId> \
  -m <milestoneId> \
  -d "<new description>" \
  -c <new-scheduledCompletionDate-unix-timestamp>
```

```bash
# Example
emasser put milestones update \
  -s 100 \
  -p 45 \
  -m 10 \
  -d "Patch deployment completed ahead of schedule" \
  -c 1735603200
```

---

## Artifacts
Update (replace) an existing artifact.

```bash
emasser put artifacts update \
  -s <systemId> \
  --isTemplate or --no-isTemplate \
  -t <type> \
  -c <category> \
  -f <file>
```

**Type values:** `Procedure`, `Diagram`, `Policy`, `Labor`, `Document`, `Image`, `Other`, `Scan Result`, `Auditor Report`  
**Category values:** `Implementation Guidance`, `Evidence`

```bash
# Example: Replace an existing policy document
emasser put artifacts update -s 100 \
  --no-isTemplate \
  -t Policy \
  -c "Implementation Guidance" \
  -f /path/to/updated-access-control-policy.pdf
```

---

## Hardware Assets
Update an existing hardware asset.

```bash
emasser put hardware update -s <systemId> [options]
# Run for full options:
emasser put hardware help update
```

---

## Software Assets
Update an existing software asset.

```bash
emasser put software update -s <systemId> [options]
# Run for full options:
emasser put software help update
```

---

## Getting Help

```bash
emasser put help
emasser put controls help update
emasser put poams help update
emasser put milestones help update
emasser put artifacts help update
```
