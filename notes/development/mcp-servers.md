# MCP Servers

Configured in `.claude/.mcp.json`. Available in Claude Code sessions started with `make claude`.

## Servers

| Server       | Type    | Purpose                                    |
|--------------|---------|--------------------------------------------|
| Context7     | stdio   | Library documentation lookup               |
| docfork      | HTTP    | GitHub repo documentation search           |
| Playwright   | stdio   | Browser automation for UI testing          |

## Usage Guidelines

### Context7
- Resolve library IDs first (`resolve-library-id`), then query docs (`query-docs`)
- Use for up-to-date API docs of any npm/pip package
- Prefer over web search for library-specific questions

### docfork
- Search documentation within specific GitHub repos
- Use `docforkIdentifier` (author/repo format) for targeted searches
- Good for framework docs not well indexed by Context7

### Playwright
- Browser automation for visual UI testing
- Use `browser_snapshot` for accessibility tree (preferred over screenshots for actions)
- Use `browser_take_screenshot` for visual verification
- Navigate, click, fill forms, validate UI state
