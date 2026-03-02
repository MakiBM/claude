# Code Comments

Human-friendly comments that explain what and why.

## Rules

| Do                                    | Don't                                      |
|---------------------------------------|--------------------------------------------|
| Describe current behavior             | Mention previous implementation            |
| Explain why (reasoning)               | Describe your recent changes               |
| Document known challenges/bugs        | Write "fixed bug where..."                 |
| Keep comments up to date              | Leave stale/outdated comments              |

## Good Comments

### Explain Why

```typescript
// Cleanup blob URLs on unmount to prevent memory leaks
useEffect(() => {
  return () => files.forEach(f => URL.revokeObjectURL(f.preview));
}, []);

// Auth routes: 10 req/min per IP (brute force protection)
auth: { windowMs: 60_000, maxRequests: 10 },

// Force view update by dispatching empty transaction with meta
tr.setMeta(EditorSuggestionPluginKey, { suggestions })
```

### Document Challenges

```typescript
// Handle sync state lost (IDB garbage collected or multi-tab state divergence)
// This is unrecoverable - must clear local data and reload
onClientStateNotFound: () => {
  console.warn("[Zero] Sync state lost, clearing databases and reloading...")
  dropAllDatabases().then(() => window.location.reload())
}

// Note: File input cannot be programmatically set for security reasons
// The syncHiddenInput prop is no longer functional
```

### Explain Non-Obvious Code

```typescript
// ignore for middleware
} catch {
  // Empty catch - middleware context doesn't support cookie operations
}

// Logged in without display_name → must complete setup
if (user && !hasDisplayName && !isOnSetupRoute) {
  return NextResponse.redirect(new URL("/konfiguracja", request.url))
}
```

## Bad Comments

```typescript
// ❌ Mentions previous implementation
// Changed from useState to Zustand for better performance
const store = useChatStore();

// ❌ Describes the change, not the code
// Added null check to fix crash
if (user) { ... }

// ❌ Obvious - code is self-documenting
// Increment counter by 1
counter++;

// ❌ Stale comment (code changed, comment didn't)
// Returns user email
function getDisplayName() { return user.name; }
```

## When to Comment

- **Non-obvious logic** - Why this approach?
- **Known issues** - Challenges, edge cases, browser quirks
- **External dependencies** - API limits, service constraints
- **Performance reasons** - Why memoization, debouncing, etc.
- **Type workarounds** - TypeScript limitations, any casts

## TODO Comments

Fight for completeness. TODOs are exception, not norm.

**Allowed only when valid blocker exists:**
- External dependency not ready
- Waiting for API/service
- Blocked by another task
- Missing extension/library feature

```typescript
// ✅ Good: Clear blocker with context
// TODO: need TextAlign extension
<Button disabled>
  <AlignLeftIcon />
</Button>

// TODO: Get actual URL from file upload when implemented
url: "",

// TODO: Get actual content from editor when implemented
const content = MOCK_DOCUMENT_HTML;

// ❌ Bad: No blocker, just laziness
// TODO: Add validation later
// TODO: Refactor this
// TODO: Clean up
```

**Always include:**
- What needs to be done
- Why it's blocked (the blocker)

## When Not to Comment

- Self-explanatory code
- What the code does (read the code)
- Change history (use git)

## Section Dividers

Use concise comment dividers for component exports:

```typescript
// QueueSection - collapsible section container
export type QueueSectionProps = ComponentProps<typeof Collapsible>;

// QueueSectionTrigger - section header/trigger
export type QueueSectionTriggerProps = ComponentProps<"button">;
```

## JSDoc for Utilities

Prefer JSDoc for reusable utilities/hooks:

```typescript
/**
 * Disables all CSS transitions during window resize to prevent janky animations.
 * Injects a style tag with `* { transition: none !important }` while resizing.
 */
export function ResizeTransitionBlocker() {
```
