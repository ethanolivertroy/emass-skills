# eMASSer CLI Agent Skills

This repository provides agent skills for working with the **eMASSer CLI** — a Ruby-based command-line tool for automating the eMASS (Enterprise Mission Assurance Support Service) REST API.

> Reference: https://github.com/mitre/emasser

## About eMASSer

eMASSer automates eMASS cybersecurity management tasks via the eMASS REST API. It supports GET, POST, PUT, and DELETE operations for:
- Systems and system roles
- Security controls and test results
- POA&Ms (Plan of Action & Milestones) and milestones
- Artifacts (documents, policies, scan results)
- CAC/PAC workflows
- Hardware and software baseline assets
- Device scans, cloud resource results, container scans, static code scan findings
- CMMC assessments, workflow definitions, and dashboards

## Setup

### Installation
```bash
gem install emasser          # via RubyGems
# OR
docker pull mitre/emasser    # via Docker
```

### Configuration
Create a `.env` file in your working directory:
```bash
export EMASSER_API_KEY='<your-api-key>'
export EMASSER_HOST_URL='<eMASS-server-FQDN>'
export EMASSER_KEY_FILE_PATH='<path/to/key.pem>'
export EMASSER_CERT_FILE_PATH='<path/to/client.pem>'
export EMASSER_KEY_FILE_PASSWORD='<key-password>'
```

### Test Connection
```bash
emasser get test connection
```

## Key Commands

```bash
# Systems
emasser get systems all
emasser get system id --system_name "System Name"
emasser get system byId -s <systemId>

# Controls
emasser get controls forSystem -s <systemId>
emasser put controls update --systemId <id> --acronym "AC-1" ...

# POA&Ms
emasser get poams forSystem -s <systemId>
emasser post poams add -s <systemId> --status Ongoing ...
emasser put poams update -s <systemId> -p <poamId> ...
emasser delete poams remove -s <systemId> -p <poamId>

# Test Results
emasser post test_results add -s <systemId> --assessmentProcedure "AC-1.1" \
  --testedBy "LastName, FirstName" --testDate <unix-ts> \
  --description "..." --complianceStatus Compliant

# Artifacts
emasser get artifacts forSystem -s <systemId>
emasser post artifacts upload -s <systemId> --no-isTemplate -t Policy \
  -c "Implementation Guidance" -f /path/to/file.pdf

# Scan Results
emasser post device_scans add -s <systemId> -f scan.ckl -t disaStigViewerCklCklb
emasser post scan_findings add -s <systemId> --applicationName "App" ...
```

## CLI Help Pattern

```bash
emasser <get|post|put|delete> help
emasser get help systems
emasser post help poams
```

## Boolean Parameters
- TRUE: `--flagName` (e.g., `--includePackage`)
- FALSE: `--no-flagName` (e.g., `--no-includePackage`)

## Agent Skills

Detailed skill files are in `.claude/skills/` and work with Claude Code and GitHub Copilot:
- `emasser-setup` — installation and configuration
- `emasser-get` — all GET commands
- `emasser-post` — all POST commands
- `emasser-put` — all PUT commands
- `emasser-delete` — all DELETE commands
