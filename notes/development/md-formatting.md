# Markdown Formatting

## Tables

Align columns with whitespace for raw markdown readability:

```md
| Column One           | Column Two                   |
|----------------------|------------------------------|
| short                | longer value here            |
| medium value         | short                        |
```

Use bold in cells for emphasis:

```md
| Layer              | Purpose                      |
|--------------------|------------------------------|
| **Primary**        | Source of truth              |
| Secondary          | Cache                        |
```

## Headings

- `#` - Document title (one per file)
- `##` - Main sections
- `###` - Subsections
- `####` - Avoid (restructure instead)

## Lists

Use `-` for unordered lists:

```md
- First item
- Second item
  - Nested item
```

## Code Blocks

Always specify language for syntax highlighting:

```md
\`\`\`typescript
export function example() { ... }
\`\`\`

\`\`\`bash
bun run dev
\`\`\`

\`\`\`sql
CREATE TABLE users (...);
\`\`\`
```

## Emphasis

- `**bold**` for emphasis, key terms
- `backticks` for code, filenames, commands
- Keep lines concise

## Dividers

Use `---` to separate major sections:

```md
## Section One

Content here.

---

## Section Two

Content here.
```
