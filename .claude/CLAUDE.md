# Communication rules

Whenever you write: Be extremely concise. Sacriface grammar for the sake of concision.
Whenever you code: Explain your reasoning.

# Behaviour

Never do workarounds, always fix the root issues.
Never implement code outside of given task scope without discussing it with the user.

# CLAUDE.md edits

You are allowed only editing sections within <edit></edit> tags.
The only exception to edit outside of <edit></edit> block is when you get a written permission from the user.


# Documentation notes

You are responsible for keeping documentation notes up to date.
You proactively edit and take new notes. Development and Features notes must stay up to date.
You list the notes in CLAUDE.md for future reference.
  - Each item should have a `read-if` trigger that explains shortly when this knowledge is beneficial to read. Decision based on a logic: **is my work related to any keyword in {read-if}**. **Read matching notes BEFORE starting implementation.**
  - Scope that narrows item's applicability
  - Link to file

Sample item:
```
read-if: environment variables, .env
scope: global | <service>
@notes/development/environment-variables.md
```

## Reading Notes Before Work

Before starting ANY task:
1. Scan `read-if` triggers in lists below
2. Read notes where your task keywords match `read-if`
3. Then proceed with implementation

This ensures you follow existing patterns and don't contradict documented decisions.

Before starting the work there are 2 variants
- editing existing features. Then ask yourself **Did I read the related docs first?**.
- creating new features. Then remember **I need to take a note about that after it's done.**

**IMPORTANT:** You need to present your notes analysis to the user before any other work. If you're not picking any notes to read you must explain why - what is your defined scope and why you believe notes won't be beneficial.

## Editing / Creating Notes After Work

Decision based on a logic:
- Which notes did I read before the task. Are these up to date now?
- Did the scope change and touches other notes now? Read then. Are these up to date now?
- Was it new work? Doas it require documenting?

**IMPORTANT:** You need to present your work summary after the work was completed:
- The summary must assess how your scope and used patterns align with preexisting notes.
- Reflect if you truly picked all notes required for the completed scope - read missing information if needed, align code to your most recent knowledge.
- Analyze changes required to the notes to keep them up to date or increase coverage.
- Present the anylisis to the user and ask for permission to contribute to the notes.

## notes/development/*.md

This serves as developer friendly documentation.
Items should be grouped (for example react-components, react-state etc should come together).
Items should be sorted by scope.

List of notes:
<edit>
read-if: creating or editing .md files, notes/, markdown tables
scope: global
@notes/development/md-formatting.md

read-if: writing code comments, documenting code, explaining why
scope: global
@notes/development/code-comments.md

read-if: code quality, missing tests, missing docs, proactive improvements, leave code better
scope: global
@notes/development/code-quality.md

read-if: MCP servers, Context7, docfork, Playwright, documentation tools
scope: global
@notes/development/mcp-servers.md
</edit>

## notes/features/*.md

This serves as user / marketing / business friendly feature description.
Capture here all user facing features. Focus on what and why, avoid implementation details.
Target usage might be:
- team onboarding
- documentation for end users
- marketing materials
- reports to business

Items should be grouped by routes.
Items should be sorted by scope.

List of notes:
<edit>

</edit>
