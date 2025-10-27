# Frontend Development Skill

**Category:** Development
**Stack:** Next.js 15, React 19, Shadcn UI, Tailwind CSS
**Author:** Mehran Mozaffari
**Version:** 1.0.0
**License:** MIT

## Overview

This skill guides Claude Code through building UI components and features with an approved frontend stack. It enforces library choices, component patterns, responsive design, accessibility standards, and theme support.

**Key Features:**
- ✅ Design-first workflow for complex UIs (dashboards, multi-screen features)
- ✅ Enforces approved stack (prevents incompatible libraries like Framer Motion)
- ✅ Quality checklists (responsive, accessible, themed)
- ✅ Animation guidance (React Spring, Auto-animate)
- ✅ Code patterns and examples
- ✅ Mobile-first approach

## When to Use

Use this skill when:
- Building UI components (buttons, forms, cards, modals)
- Creating pages, screens, or dashboards
- Implementing animations or visual effects
- Working on responsive design or theming
- User mentions "frontend," "UI," or "design"

## Installation

### From Marketplace

```bash
/plugin marketplace add imehr/imehr-marketplace
/plugin install imehr-skills@imehr-marketplace
```

The `/frontend` command will be available after installation.

### Manual Installation

1. Copy the `frontend/` directory to `.claude/skills/`
2. Copy `frontend.md` command to `.claude/commands/`
3. Restart Claude Code or run `/help` to verify

## Usage

### Via Slash Command

```bash
/frontend
```

This activates the skill and provides guidance for your UI task.

### Automatic Activation

The skill automatically activates when Claude detects UI-related work based on context.

## Approved Stack

The skill enforces use of:

```yaml
Framework: Next.js 15.5.4 + React 19.2.0
Components: Shadcn UI 0.9.5 + Radix UI
Styling: Tailwind CSS 3.4.18 + Class Variance Authority
Icons: Lucide React 0.545.0
Forms: React Hook Form 7.65.0 + Zod 3.25.76
State: Zustand 5.0.8, React Query 5.90.5
Charts: Recharts 2.15.4
Animations: React Spring, Auto-animate
```

**⚠️ NOT ALLOWED:** Framer Motion (React 19 incompatibility)

## Workflow

### 1. Detection
Determines if work involves UI components

### 2. Complexity Assessment
Decides between design-first or direct implementation based on:
- New dashboards/multi-screen → Design first
- Complex layouts with charts → Design first
- Single component updates → Direct implementation
- Bug fixes → Direct implementation

### 3a. Design Phase (Complex UIs)
1. Gathers requirements
2. Creates ASCII mockups and Mermaid diagrams
3. Presents 2-3 design options with trade-offs
4. Validates with user before coding

### 3b. Implementation Phase
1. Verifies approved stack usage
2. Creates TodoWrite quality checklist
3. Implements following established patterns
4. Ensures responsive, accessible, themed

### 4. Quality Check
Verifies:
- Responsive at 375px, 768px, 1440px
- Keyboard navigation and ARIA labels
- Light and dark theme support
- Performance optimizations

## Examples

### Creating a Feature Component

```tsx
'use client'

import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Play, Pause } from 'lucide-react'
import { cn } from '@/lib/utils'

export function ActivityCard({ title, duration, isActive, onToggle, className }: Props) {
  return (
    <Card className={cn("hover:shadow-lg transition-shadow", className)}>
      <CardHeader>
        <CardTitle className="flex items-center justify-between">
          {title}
          <Button
            variant="ghost"
            size="icon"
            onClick={onToggle}
            aria-label={isActive ? "Pause" : "Start"}
          >
            {isActive ? <Pause className="h-4 w-4" /> : <Play className="h-4 w-4" />}
          </Button>
        </CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-sm text-muted-foreground">{duration} min</p>
      </CardContent>
    </Card>
  )
}
```

### Adding Animation

```tsx
// Simple transitions - Auto-animate
import autoAnimate from '@formkit/auto-animate'
const parent = useRef(null)
useEffect(() => {
  parent.current && autoAnimate(parent.current)
}, [parent])

// Physics-based - React Spring
import { useSpring, animated } from '@react-spring/web'
const springs = useSpring({
  from: { opacity: 0, transform: 'translateY(20px)' },
  to: { opacity: 1, transform: 'translateY(0px)' }
})
```

## Quality Standards

### Accessibility (Basic)
- Keyboard navigation (Tab, Enter, Escape)
- Visible focus states
- ARIA labels on icon-only buttons
- Labels on form inputs
- Respects prefers-reduced-motion

### Responsive Design
- Mobile-first breakpoints (sm:, md:, lg:, xl:)
- 48px minimum touch targets
- Tested at 375px, 768px, 1440px

### Theme Support
- CSS variables from theme.ts
- Works in light and dark modes
- No hardcoded colors

## Common Mistakes Prevented

1. **Using Framer Motion** - Skill enforces React Spring instead
2. **Hardcoded colors** - Enforces CSS variables
3. **Desktop-first responsive** - Enforces mobile-first
4. **Missing accessibility** - Quality checklist ensures coverage
5. **Conditional className** - Guides to CVA for variants

## Integration

Works seamlessly with:
- **TodoWrite** - Creates quality checklists automatically
- **AskUserQuestion** - Presents design options for validation
- **Elements of Style** - Documentation follows clear writing principles

## Research & Rationale

This skill is based on research comparing animation libraries for React 19:

**Framer Motion:**
- ❌ React 19 incompatible (as of Oct 2025)
- ❌ Larger bundle (~50kb)
- ❌ Alpha versions unstable

**React Spring:**
- ✅ Full React 19 support (v10.0.0+)
- ✅ Smaller bundle (~25kb)
- ✅ Already in project
- ✅ Physics-based, perfect for fitness/metrics viz

Full research documented in `docs/plans/2025-10-27-frontend-skill-design.md`

## Testing

See [TEST_RESULTS.md](TEST_RESULTS.md) for comprehensive testing documentation including:
- Pressure test scenarios
- False positive prevention
- Integration testing
- Research validation

**Status:** ✅ All tests pass, ready for production use

## Component Organization

```
src/
├── components/
│   ├── ui/          # Shadcn components (Button, Card, Dialog)
│   ├── features/    # Feature-specific (ActivityCard, WorkoutPlan)
│   └── layouts/     # Page layouts (DashboardLayout)
├── lib/
│   ├── utils.ts     # cn() utility
│   ├── theme.ts     # Color system
│   └── api-client.ts
└── app/             # Next.js App Router
```

## Contributing

To improve this skill:

1. Test with pressure scenarios (follow `superpowers:testing-skills-with-subagents`)
2. Document in TEST_RESULTS.md
3. Submit PR with clear rationale
4. Ensure skill remains under 1,000 words

## Support

- **Issues:** [GitHub Issues](https://github.com/imehr/skills/issues)
- **Discussions:** [GitHub Discussions](https://github.com/imehr/skills/discussions)
- **Author:** Mehran Mozaffari

## License

MIT License - see repository for details

## Related Skills

- `railway` - Deployment and production management
- `superpowers:brainstorming` - Design refinement workflow
- `superpowers:writing-plans` - Implementation planning

## Version History

### 1.0.0 (2025-10-27)
- Initial release
- Next.js 15 + React 19 support
- React Spring animation guidance
- Design-first workflow
- Quality checklists
- Comprehensive testing
