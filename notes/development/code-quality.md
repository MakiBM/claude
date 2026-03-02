# Code Quality

## Core Principles

**Leave code better than you found it.**

When touching any file, proactively check what's missing and suggest improvements.

### Simplicity

- Human readable first
- Simpler is always better
- Removing code > writing code
- No legacy/commented code - git has history
- If it can be deleted, delete it

### Refactor As You Go

| Question                              | Action                              |
|---------------------------------------|-------------------------------------|
| Can a popular package solve this?     | Use the package                     |
| Does similar code exist in codebase?  | Abstract and reuse                  |
| Is this function doing too much?      | Compose from smaller pieces         |
| Is there dead/unused code?            | Delete it                           |
| Are there commented-out blocks?       | Delete them                         |
| Is this truly reusable?               | Lift up in hierarchy                |

### Preferred Libraries

Use these before writing custom utils:

| Library        | Use For                                          |
|----------------|--------------------------------------------------|
| `usehooks-ts`  | Common React hooks (debounce, localStorage, media query, etc.) |
| `date-fns`     | Date manipulation and formatting               |
| `validator`    | Input validation (email, sanitization, etc.)   |
| `zod`          | Schema validation and type inference           |

```tsx
// ❌ Bad: custom debounce
const [value, setValue] = useState("");
useEffect(() => {
  const timer = setTimeout(() => search(value), 300);
  return () => clearTimeout(timer);
}, [value]);

// ✅ Good: usehooks-ts
import { useDebounceValue } from "usehooks-ts";
const [debouncedValue] = useDebounceValue(value, 300);

// ❌ Bad: string interpolation dates
const dateStr = `${date.getDate()}.${date.getMonth() + 1}.${date.getFullYear()}`;

// ✅ Good: Intl.DateTimeFormat or date-fns
const dateStr = new Intl.DateTimeFormat("pl", {
  day: "2-digit", month: "2-digit", year: "numeric"
}).format(date);
```

### Lift Reusable Code Up

When extracting code, consider where it truly belongs:

```
Component-specific  →  Feature utils  →  lib/utils  →  Package
     (inline)         (feature/utils)   (shared)     (npm)
```

| Reuse Scope                    | Location                    |
|--------------------------------|-----------------------------|
| Used once in component         | Keep inline                 |
| Used across feature            | `features/{name}/utils/`    |
| Used across features           | `lib/utils/`                |
| Could be open-sourced          | Consider npm package        |

### Function Size

Break large functions into smaller, focused pieces:

```tsx
// ❌ Bad: monolithic function
function processAndValidateAndSave(data) {
  // 100+ lines of validation, transformation, saving
}

// ✅ Good: composed from small pieces
const validated = validateData(data);
const transformed = transformData(validated);
const saved = await saveData(transformed);
```

## Checklist When Editing Code

| Check                  | Ask                                               |
|------------------------|---------------------------------------------------|
| Comments               | Is complex logic explained? Why, not what?        |
| Types                  | Are types explicit? No `any` without eslint-disable? |
| Error handling         | Are edge cases handled?                           |
| Documentation          | Is feature documented in notes/features/?         |
| Validation             | Are inputs validated with Zod?                    |

## Proactive Improvement

When working on a file:

1. **Look around** - What's the state of surrounding code?
2. **Review comments** - Are they helpful or outdated?
3. **Check TODOs** - Are there unresolved TODOs?
4. **Suggest improvements** - Tell user what's missing
5. **Include in plan** - Add missing pieces to work scope

```
// Working on use-chat-files.ts

Observations:
- TODO on line 149: "Get actual URL from file upload"
- Complex file processing logic well documented
- No tests exist (project has no test framework)

Suggest to user:
"While implementing X, noticed:
- TODO on line 149 about file URLs
- Want me to resolve this in current scope?"
```

## What to Suggest

| Found                        | Suggest                              |
|------------------------------|--------------------------------------|
| Complex logic, no comments   | Inline comments explaining why       |
| New user-facing feature      | Feature doc in notes/features/       |
| Outdated comments            | Update or remove                     |
| Type `any`                   | Proper typing + eslint-disable comment |
| Similar code elsewhere       | Abstract into shared util            |
| Custom implementation        | Check if usehooks-ts/date-fns/validator can replace |
| Dead/unused code             | Delete it                            |
| Commented-out code           | Delete it (git has history)          |
| Large function (200+ lines)  | Break into smaller focused functions |
| Unresolved TODO              | Address or remove if obsolete        |

## Don't Over-Engineer

Suggest what's genuinely missing, not:
- Comments for obvious code
- Docs for internal utilities
- Abstractions used only once

Focus on high-impact improvements.

## Type Safety

```tsx
// ❌ Bad: implicit any
function process(data) { ... }

// ❌ Bad: silently using any
const result = items.map((item: any) => item.value);

// ✅ Good: explicit types
function process(data: ProcessInput): ProcessOutput { ... }

// ✅ Good: any with justification
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const shape = (schema as any)._zod?.def?.shape;
```

## Validation Patterns

Use Zod for all form schemas and API inputs:

```tsx
// ✅ Good: Zod schema with custom validation
export const clientSchema = z.object({
  name: z.string().min(1, "Wymagane").max(200, "Max 200 znaków"),
  email: z.string().email("Nieprawidłowy email").optional().or(z.literal("")),
  nip: z
    .string()
    .transform((v) => v.replace(/[\s-]/g, ""))
    .refine((v) => !v || isValidNipChecksum(v), { message: "Nieprawidłowy NIP" })
});

export type ClientFormData = z.infer<typeof clientSchema>;
```

## Planning Template

When planning work, include quality items:

```
## Plan

1. Implement X feature
2. Add Zod validation schema
3. Add comments to complex Y logic
4. Resolve TODOs in modified files
5. Update feature docs (if user-facing)
```

## Current Project State (jurysta-ui)

**Quality tools in place:**
- TypeScript strict mode
- ESLint (Next.js + TypeScript)
- Zod for validation

**Notable patterns:**
- Custom date utils (lib/utils/date.ts) instead of date-fns
- usehooks-ts used for React patterns
- Limited eslint-disable usage (kept minimal)
- Comprehensive Zod schemas for forms (see features/client/schema.ts)

**No test framework** - Unit/integration tests not part of current workflow
