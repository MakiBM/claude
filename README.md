## Repository Overview

This is a shared Claude Code configuration repo — contains CLAUDE.md instructions, development notes, and MCP server config. Notes here are referenced across projects.

## Commands

- `make claude` — Start Claude CLI (YOLO mode, MCP config, Opus model)
- `make key` — Generate random 32-byte hex key
- `make kill <port>` — Kill process on port (skips Docker)

## Structure

```
.claude/CLAUDE.md     — Claude Code instructions (this file)
.claude/.mcp.json     — MCP server config (Context7, docfork, Playwright)
.claude/settings.json — Permission settings
notes/development/    — Developer docs (formatting, comments, quality, MCP)
notes/features/       — User-facing feature docs
Makefile              — Dev shortcuts
```
