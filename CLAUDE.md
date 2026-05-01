# CLAUDE.md

See [AGENTS.md](./AGENTS.md) for full project instructions.

## Available Skills

The following agent skills are available in `.claude/skills/`:

| Skill | Invoke | Description |
|-------|--------|-------------|
| `emasser-setup` | `/emasser-setup` | Install, configure, and troubleshoot the eMASSer CLI |
| `emasser-get` | `/emasser-get` | Retrieve data via GET endpoints (systems, controls, POA&Ms, artifacts, etc.) |
| `emasser-post` | `/emasser-post` | Add data via POST endpoints (test results, POA&Ms, artifacts, scan results) |
| `emasser-artifacts` | `/emasser-artifacts` | Read local evidence, upload artifacts, export existing artifacts, and verify uploads |
| `emasser-put` | `/emasser-put` | Update data via PUT endpoints (controls, POA&Ms, milestones, artifacts) |
| `emasser-delete` | `/emasser-delete` | Remove data via DELETE endpoints (POA&Ms, milestones, artifacts, assets) |

## Quick Reference

```bash
# Test connection
emasser get test connection

# Get systems
emasser get systems all
emasser get system id --system_name "My System"

# Common workflow: find system → get controls → update test results
emasser get system id --system_name "My System"
emasser get controls forSystem -s <systemId>
emasser post test_results add -s <systemId> --assessmentProcedure "AC-1.1" ...
```

## Notes
- eMASSer requires Ruby 3.2+ and valid eMASS API credentials
- Create a `.env` file in the working directory with required environment variables
- All dates use Unix timestamp format
- Use `--flagName` for boolean TRUE and `--no-flagName` for boolean FALSE
- Use the eMASSer CLI first for eMASS operations; raw API calls are fallback only
- Before uploading artifacts, inspect local files, then verify with `emasser get artifacts forSystem`
