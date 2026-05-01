# emass-skills

Agent skills for the [eMASSer CLI](https://github.com/mitre/emasser) — compatible with Claude, OpenAI Codex, OpenCode, and agents supporting the Agent Skills open standard.

## What is eMASSer?

[eMASSer](https://github.com/mitre/emasser) is a Ruby CLI that automates eMASS (Enterprise Mission Assurance Support Service) cybersecurity management tasks by leveraging the eMASS REST API. It supports GET, POST, PUT, and DELETE operations for systems, controls, POA&Ms, artifacts, scan results, and more.

## Agent Compatibility

| File/Directory | Agent |
|----------------|-------|
| `AGENTS.md` | OpenAI Codex, OpenCode, and all agents supporting the open standard |
| `CLAUDE.md` | Anthropic Claude (Claude Code) |
| `.claude/skills/` | Claude Code and agents supporting the Agent Skills open standard |

## Agent Operating Rule

Agents should use the eMASSer CLI for eMASS work. The skills teach agents how to install/configure `emasser`, read/query eMASS data, inspect local files, upload artifacts and scan results, export existing artifacts, and verify changes with follow-up GET commands. Raw API calls are a fallback only when the CLI cannot do the task.

Use the official MITRE Swagger UI renderer to validate endpoint behavior and command mappings: https://mitre.github.io/emass_client/docs/renderer/. The renderer proves the OpenAPI shape; a real upload still requires authorized eMASS credentials and a target system.

## Available Skills

| Skill | Location | Description |
|-------|----------|-------------|
| `emasser-setup` | `.claude/skills/emasser-setup/SKILL.md` | Install, configure, and troubleshoot eMASSer |
| `emasser-get` | `.claude/skills/emasser-get/SKILL.md` | All GET endpoint commands |
| `emasser-post` | `.claude/skills/emasser-post/SKILL.md` | All POST endpoint commands |
| `emasser-artifacts` | `.claude/skills/emasser-artifacts/SKILL.md` | Read, inspect, upload, export, and verify eMASS artifacts |
| `emasser-put` | `.claude/skills/emasser-put/SKILL.md` | All PUT endpoint commands |
| `emasser-delete` | `.claude/skills/emasser-delete/SKILL.md` | All DELETE endpoint commands |

## Quick Start

### 1. Install Skills for Your Project

**Claude Code:**
```bash
cp -r .claude/skills/ /path/to/your/project/.claude/skills/
cp CLAUDE.md /path/to/your/project/CLAUDE.md
```

**All agents (universal):**
```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
cp -r .claude/skills/ /path/to/your/project/.claude/skills/
```

### 2. Install eMASSer

```bash
gem install emasser
```

eMASSer requires Ruby 3.2 or newer.

### 3. Configure eMASSer

Create a `.env` file in the directory where you run `emasser`:

```bash
export EMASSER_API_KEY='<api-key>'
export EMASSER_HOST_URL='<eMASS FQDN>'
export EMASSER_KEY_FILE_PATH='<path/to/key.pem>'
export EMASSER_CERT_FILE_PATH='<path/to/client.pem>'
export EMASSER_KEY_FILE_PASSWORD='<key-password>'
```

Then test the connection:

```bash
emasser get test connection
```

### 4. Use a Skill

Ask your agent to use the relevant skill for the workflow:

- `emasser-setup` for install, configuration, and connection troubleshooting
- `emasser-get` for querying systems, controls, POA&Ms, artifacts, and dashboards
- `emasser-post` for creating records and uploading scan results
- `emasser-artifacts` for inspecting, uploading, exporting, and verifying evidence
- `emasser-put` for updating records
- `emasser-delete` for removals that require explicit approval and follow-up verification

## Resources

- [eMASSer GitHub](https://github.com/mitre/emasser)
- [eMASS API Documentation](https://mitre.github.io/emass_client/docs/redoc/)
- [Interactive Swagger/Stoplight Mock](https://mitre.github.io/emass_client/docs/renderer/)
- [eMASSer Features Guide](https://github.com/mitre/emasser/blob/main/docs/features.md)
- [Agent Skills Standard](https://agentskills.io/)

## Mock API Validation

The OpenAPI spec exposes a hosted Prism mock server:

```bash
curl -H 'Prefer: code=200' \
  https://stoplight.io/mocks/mitre/emasser/32836028/api
```

Use it to validate API shapes and examples before trying an authorized eMASS environment. The stock `emasser` CLI cannot directly target the hosted mock URL because it strips path components from `EMASSER_HOST_URL`; direct `curl` calls are the practical mock-validation path.

## Repository Validation

Run the local validation script before pushing docs changes:

```bash
bash tests/validate-repo.sh
```
