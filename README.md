# emass-skills

Agent skills for the [eMASSer CLI](https://github.com/mitre/emasser) — compatible with Claude, GitHub Copilot, OpenAI Codex, OpenCode, and every major AI coding agent.

## What is eMASSer?

[eMASSer](https://github.com/mitre/emasser) is a Ruby CLI that automates eMASS (Enterprise Mission Assurance Support Service) cybersecurity management tasks by leveraging the eMASS REST API. It supports GET, POST, PUT, and DELETE operations for systems, controls, POA&Ms, artifacts, scan results, and more.

## Agent Compatibility

| File/Directory | Agent |
|----------------|-------|
| `AGENTS.md` | OpenAI Codex, OpenCode, and all agents supporting the open standard |
| `CLAUDE.md` | Anthropic Claude (Claude Code) |
| `.github/copilot-instructions.md` | GitHub Copilot |
| `.claude/skills/` | Claude Code **and** GitHub Copilot (shared skill format) |

## Available Skills

| Skill | Location | Description |
|-------|----------|-------------|
| `emasser-setup` | `.claude/skills/emasser-setup/SKILL.md` | Install, configure, and troubleshoot eMASSer |
| `emasser-get` | `.claude/skills/emasser-get/SKILL.md` | All GET endpoint commands |
| `emasser-post` | `.claude/skills/emasser-post/SKILL.md` | All POST endpoint commands |
| `emasser-put` | `.claude/skills/emasser-put/SKILL.md` | All PUT endpoint commands |
| `emasser-delete` | `.claude/skills/emasser-delete/SKILL.md` | All DELETE endpoint commands |

## Quick Start

### Install Skills for Your Project

**Claude Code:**
```bash
cp -r .claude/skills/ /path/to/your/project/.claude/skills/
cp CLAUDE.md /path/to/your/project/CLAUDE.md
```

**GitHub Copilot:**
```bash
cp -r .claude/skills/ /path/to/your/project/.claude/skills/
cp .github/copilot-instructions.md /path/to/your/project/.github/copilot-instructions.md
```

**All agents (universal):**
```bash
cp AGENTS.md /path/to/your/project/AGENTS.md
cp -r .claude/skills/ /path/to/your/project/.claude/skills/
```

### eMASSer Setup

1. Install: `gem install emasser`
2. Create `.env` with your credentials:
   ```bash
   export EMASSER_API_KEY='<api-key>'
   export EMASSER_HOST_URL='<eMASS FQDN>'
   export EMASSER_KEY_FILE_PATH='<path/to/key.pem>'
   export EMASSER_CERT_FILE_PATH='<path/to/client.pem>'
   export EMASSER_KEY_FILE_PASSWORD='<key-password>'
   ```
3. Test: `emasser get test connection`

## Resources

- [eMASSer GitHub](https://github.com/mitre/emasser)
- [eMASS API Documentation](https://mitre.github.io/emass_client/docs/redoc/)
- [eMASSer Features Guide](https://github.com/mitre/emasser/blob/main/docs/features.md)
- [Agent Skills Standard](https://agentskills.io/)