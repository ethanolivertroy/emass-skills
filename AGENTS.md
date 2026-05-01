# AGENTS.md

This repository contains agent skills for the **eMASSer CLI** — a Ruby-based command-line interface for automating the eMASS (Enterprise Mission Assurance Support Service) REST API.

> Reference: https://github.com/mitre/emasser

## What is eMASSer?

eMASSer is a CLI that automates routine eMASS cybersecurity management tasks by leveraging the eMASS REST API. It supports:
- **GET** — retrieve systems, controls, POA&Ms, milestones, artifacts, test results, and more
- **POST** — add test results, create POA&Ms, upload artifacts and scan results
- **PUT** — update controls, POA&Ms, milestones, artifacts, and assets
- **DELETE** — remove POA&Ms, milestones, artifacts, and assets

## Agent Operating Rule

All agents should use the `emasser` CLI as the primary interface for eMASS work. Do not invent direct REST calls or edit eMASS data by hand when a CLI command exists. Before any upload or mutation, inspect local files, validate the target system ID, run the command-specific `emasser ... help` when flags are uncertain, and verify the result with a follow-up GET command.

For artifact workflows, agents must be able to:

1. Read/inspect local evidence files safely.
2. Upload evidence with `emasser post artifacts upload` or scan results with the scan-specific POST commands.
3. Export/read existing artifacts with `emasser get artifacts export`.
4. Verify uploads by querying `emasser get artifacts forSystem`.

Use the official MITRE Swagger UI renderer to validate endpoint behavior when command details are uncertain: https://mitre.github.io/emass_client/docs/renderer/. The renderer is documentation/OpenAPI validation, not a substitute for testing against an authorized eMASS environment.

## Quick Setup

1. **Install:** `gem install emasser`
2. **Configure:** Create a `.env` file with your eMASS credentials (see [Environment Variables](#environment-variables))
3. **Test:** `emasser get test connection`

## Environment Variables

Required in `.env` file:
```bash
export EMASSER_API_KEY='<api-key>'
export EMASSER_HOST_URL='<eMASS FQDN>'
export EMASSER_KEY_FILE_PATH='<path/to/key.pem>'
export EMASSER_CERT_FILE_PATH='<path/to/client.pem>'
export EMASSER_KEY_FILE_PASSWORD='<key-password>'
```

Optional:
```bash
export EMASSER_USER_UID='<user-uid>'
export EMASSER_VERIFY_SSL='true'
export EMASSER_DEBUGGING='false'
export EMASSER_EPOCH_TO_DATETIME='false'
export EMASSER_DOWNLOAD_DIR='eMASSerDownloads'
```

## Common Commands

```bash
# Test connection
emasser get test connection

# Get all systems
emasser get systems all

# Get system by name
emasser get system id --system_name "My System"

# Get controls for a system
emasser get controls forSystem -s <systemId>

# Get POA&Ms for a system
emasser get poams forSystem -s <systemId>

# Get artifacts for a system
emasser get artifacts forSystem -s <systemId>

# Add a test result
emasser post test_results add -s <systemId> \
  --assessmentProcedure "AC-1.1" \
  --testedBy "LastName, FirstName" \
  --testDate <unix-timestamp> \
  --description "Test description" \
  --complianceStatus Compliant

# Create a POA&M
emasser post poams add -s <systemId> \
  --status Ongoing \
  --vulnerabilityDescription "Description" \
  --sourceIdentifyingVulnerability "Source" \
  --pocOrganization "Org" \
  --resources "Resources" \
  --scheduledCompletionDate <unix-timestamp> \
  --milestone description:"Milestone" scheduledCompletionDate:<unix-timestamp>

# Read/inspect a local artifact before upload
test -f /path/to/file.pdf && file /path/to/file.pdf && stat /path/to/file.pdf

# Upload an artifact
emasser post artifacts upload -s <systemId> \
  --no-isTemplate -t Policy -c "Implementation Guidance" \
  -f /path/to/file.pdf

# Verify the upload
emasser get artifacts forSystem -s <systemId> -f "file.pdf"

# Export/read an existing artifact from eMASS
export EMASSER_DOWNLOAD_DIR="$PWD/eMASSerDownloads"
emasser get artifacts export -s <systemId> -f "file.pdf"
```

## CLI Help Pattern

```bash
emasser <get|post|put|delete> help           # List all commands
emasser <verb> help <command>                # Help for a command
emasser <verb> <command> help <subcommand>   # Help for a subcommand
```

## Boolean Parameters

- Use `--parameterName` for TRUE
- Use `--no-parameterName` for FALSE

## Available Skills

This repository provides agent skills in `.claude/skills/` that are compatible with Claude Code, GitHub Copilot, and other agents supporting the Agent Skills open standard:

| Skill | Description |
|-------|-------------|
| `emasser-setup` | Install and configure eMASSer |
| `emasser-get` | All GET endpoint commands |
| `emasser-post` | All POST endpoint commands |
| `emasser-artifacts` | Read, inspect, upload, export, and verify eMASS artifacts |
| `emasser-put` | All PUT endpoint commands |
| `emasser-delete` | All DELETE endpoint commands |

Skills are located in `.claude/skills/` and work with both Claude Code and GitHub Copilot.
