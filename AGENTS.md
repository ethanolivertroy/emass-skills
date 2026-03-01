# AGENTS.md

This repository contains agent skills for the **eMASSer CLI** — a Ruby-based command-line interface for automating the eMASS (Enterprise Mission Assurance Support Service) REST API.

> Reference: https://github.com/mitre/emasser

## What is eMASSer?

eMASSer is a CLI that automates routine eMASS cybersecurity management tasks by leveraging the eMASS REST API. It supports:
- **GET** — retrieve systems, controls, POA&Ms, milestones, artifacts, test results, and more
- **POST** — add test results, create POA&Ms, upload artifacts and scan results
- **PUT** — update controls, POA&Ms, milestones, artifacts, and assets
- **DELETE** — remove POA&Ms, milestones, artifacts, and assets

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

# Upload an artifact
emasser post artifacts upload -s <systemId> \
  --no-isTemplate -t Policy -c "Implementation Guidance" \
  -f /path/to/file.pdf
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
| `emasser-put` | All PUT endpoint commands |
| `emasser-delete` | All DELETE endpoint commands |

Skills are located in `.claude/skills/` and work with both Claude Code and GitHub Copilot.
