# Design System Modern OKLCH - Complete Reference

This file contains the complete templates and schemas for the OKLCH design system.

## Complete globals.css Template

```css
@import "tailwindcss";
@import "tw-animate-css";

@custom-variant dark (&:is(.dark *));

@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --font-sans: var(--font-geist-sans);
  --font-mono: var(--font-geist-mono);
  --color-card: var(--card);
  --color-card-foreground: var(--card-foreground);
  --color-popover: var(--popover);
  --color-popover-foreground: var(--popover-foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-secondary: var(--secondary);
  --color-secondary-foreground: var(--secondary-foreground);
  --color-muted: var(--muted);
  --color-muted-foreground: var(--muted-foreground);
  --color-accent: var(--accent);
  --color-accent-foreground: var(--accent-foreground);
  --color-destructive: var(--destructive);
  --color-border: var(--border);
  --color-input: var(--input);
  --color-ring: var(--ring);
  --radius-sm: calc(var(--radius) - 4px);
  --radius-md: calc(var(--radius) - 2px);
  --radius-lg: var(--radius);
  --radius-xl: calc(var(--radius) + 4px);
}

:root {
  --radius: 1.25rem;

  /* Light Mode - OKLCH Colors */
  --background: oklch(1 0 0);
  --foreground: oklch(0.145 0 0);
  --card: oklch(1 0 0);
  --card-foreground: oklch(0.145 0 0);
  --popover: oklch(1 0 0);
  --popover-foreground: oklch(0.145 0 0);
  --primary: oklch(0.205 0 0);
  --primary-foreground: oklch(0.985 0 0);
  --secondary: oklch(0.97 0 0);
  --secondary-foreground: oklch(0.205 0 0);
  --muted: oklch(0.97 0 0);
  --muted-foreground: oklch(0.556 0 0);
  --accent: oklch(0.97 0 0);
  --accent-foreground: oklch(0.205 0 0);
  --destructive: oklch(0.577 0.245 27.325);
  --border: oklch(0.922 0 0);
  --input: oklch(0.922 0 0);
  --ring: oklch(0.708 0 0);
}

.dark {
  /* Dark Mode - OKLCH Colors */
  --background: oklch(0.145 0 0);
  --foreground: oklch(0.985 0 0);
  --card: oklch(0.205 0 0);
  --card-foreground: oklch(0.985 0 0);
  --popover: oklch(0.205 0 0);
  --popover-foreground: oklch(0.985 0 0);
  --primary: oklch(0.922 0 0);
  --primary-foreground: oklch(0.205 0 0);
  --secondary: oklch(0.269 0 0);
  --secondary-foreground: oklch(0.985 0 0);
  --muted: oklch(0.269 0 0);
  --muted-foreground: oklch(0.708 0 0);
  --accent: oklch(0.269 0 0);
  --accent-foreground: oklch(0.985 0 0);
  --destructive: oklch(0.704 0.191 22.216);
  --border: oklch(1 0 0 / 10%);
  --input: oklch(1 0 0 / 15%);
  --ring: oklch(0.556 0 0);
}

@layer base {
  * {
    @apply border-border outline-ring/50;
  }
  html {
    font-size: 14.4px; /* 10% reduction for compact UI */
  }
  body {
    @apply bg-background text-foreground;
  }
}

@layer utilities {
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
}
```

## Complete Color Token Reference

### Light Mode OKLCH Values

| Token | Value | Description |
|-------|-------|-------------|
| `--background` | `oklch(1 0 0)` | Pure white |
| `--foreground` | `oklch(0.145 0 0)` | Very dark gray (text) |
| `--primary` | `oklch(0.205 0 0)` | Dark charcoal |
| `--primary-foreground` | `oklch(0.985 0 0)` | Off-white |
| `--secondary` | `oklch(0.97 0 0)` | Very light gray |
| `--secondary-foreground` | `oklch(0.205 0 0)` | Dark text |
| `--muted` | `oklch(0.97 0 0)` | Muted background |
| `--muted-foreground` | `oklch(0.556 0 0)` | Muted text |
| `--accent` | `oklch(0.97 0 0)` | Accent background |
| `--accent-foreground` | `oklch(0.205 0 0)` | Accent text |
| `--destructive` | `oklch(0.577 0.245 27.325)` | Red |
| `--border` | `oklch(0.922 0 0)` | Light border |
| `--input` | `oklch(0.922 0 0)` | Input border |
| `--ring` | `oklch(0.708 0 0)` | Focus ring |

### Dark Mode OKLCH Values

| Token | Value | Description |
|-------|-------|-------------|
| `--background` | `oklch(0.145 0 0)` | Very dark background |
| `--foreground` | `oklch(0.985 0 0)` | Off-white text |
| `--primary` | `oklch(0.922 0 0)` | Light gray |
| `--primary-foreground` | `oklch(0.205 0 0)` | Dark text |
| `--border` | `oklch(1 0 0 / 10%)` | Transparent white border |
| `--input` | `oklch(1 0 0 / 15%)` | Transparent white input |

## Shadow Reference

All shadow values use `rgba` format for cross-browser compatibility:

```css
/* Soft card shadow - large spread, low opacity */
shadow-[0px_18px_59.6px_0px_rgba(0,0,0,0.06)]

/* Button/interactive shadow - glow effect */
shadow-[0px_0px_12px_0px_rgba(0,0,0,0.1)]

/* Input shadow - subtle depth */
shadow-[0px_1px_3px_0px_rgba(0,0,0,0.06)]

/* Hover state - more elevated */
shadow-[2px_11px_40.4px_rgba(0,0,0,0.1)]

/* Dialog/modal shadow */
shadow-[0px_18px_59.6px_0px_rgba(0,0,0,0.06)]
```

## Radius Scale Reference

```css
:root {
  --radius: 1.25rem;  /* 20px base */
}

/* Calculated values */
--radius-sm: calc(var(--radius) - 4px)  /* 16px */
--radius-md: calc(var(--radius) - 2px)  /* 18px */
--radius-lg: var(--radius)              /* 20px */
--radius-xl: calc(var(--radius) + 4px)  /* 24px */
```

**Usage:**
- Buttons: `rounded-2xl` (1rem = 16px)
- Cards: `rounded-3xl` (1.5rem = 24px)
- Inputs: `rounded-2xl` (1rem = 16px)
- Dialogs: `rounded-3xl` (1.5rem = 24px)

## OKLCH Customization Guide

### Understanding OKLCH

**Format:** `oklch(L C H / A)`
- **L (Lightness):** 0 to 1 (0 = black, 1 = white)
- **C (Chroma):** 0 to 0.4 (saturation intensity)
- **H (Hue):** 0 to 360 (color angle on color wheel)
- **A (Alpha):** 0 to 1 (optional, transparency)

### Color Wheel Hue Reference

| Hue Range | Color |
|-----------|-------|
| 0-30 | Red |
| 30-90 | Yellow/Orange |
| 90-150 | Green |
| 150-210 | Cyan |
| 210-270 | Blue |
| 270-330 | Purple/Magenta |
| 330-360 | Red |

### Example Custom Colors

```css
/* Vibrant Blue Primary */
--primary: oklch(0.5 0.2 250);

/* Warm Orange Accent */
--accent: oklch(0.7 0.15 50);

/* Cool Teal Secondary */
--secondary: oklch(0.6 0.12 200);

/* Soft Pink Destructive */
--destructive: oklch(0.65 0.18 350);
```

### Dark Mode Strategy

For dark mode, typically:
- **Increase lightness** for primary colors (make lighter)
- **Decrease lightness** for backgrounds (make darker)
- **Reduce chroma** slightly for less vibrant colors
- **Keep hue consistent** for color identity

Example:
```css
/* Light mode */
--primary: oklch(0.3 0.2 250);  /* Dark blue */

/* Dark mode */
--primary: oklch(0.7 0.15 250); /* Light blue, same hue */
```

## Package.json Dependencies

```json
{
  "dependencies": {
    "@radix-ui/react-slot": "^1.2.3",
    "class-variance-authority": "^0.7.1",
    "clsx": "^2.1.1",
    "tailwind-merge": "^3.3.1",
    "lucide-react": "^0.542.0"
  },
  "devDependencies": {
    "tailwindcss": "^4",
    "@tailwindcss/postcss": "^4",
    "tw-animate-css": "^1.3.7"
  }
}
```

## Browser Support

OKLCH is supported in:
- Chrome 111+ (March 2023)
- Safari 15.4+ (March 2022)
- Firefox 113+ (May 2023)
- Edge 111+ (March 2023)

For older browsers, colors fallback to `rgb()` equivalents automatically.

## Advanced: Topic Color System

For applications needing deterministic color palettes (like video topics):

```typescript
// lib/color-utils.ts
const TOPIC_COLORS = [
  '214 48% 65%',  // Soft Blue
  '267 44% 71%',  // Lavender
  '158 35% 65%',  // Mint Green
  '15 85% 74%',   // Coral
  '43 100% 74%',  // Soft Yellow
  '320 53% 80%',  // Rose Pink
  '192 49% 71%',  // Sky Blue
];

function simpleHash(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i);
    hash = ((hash << 5) - hash) + char;
    hash = hash & hash;
  }
  return Math.abs(hash);
}

function seededRandom(seed: number): number {
  const x = Math.sin(seed) * 10000;
  return x - Math.floor(x);
}

function seededShuffle(array: string[], seed: string): string[] {
  const shuffled = [...array];
  const hashValue = simpleHash(seed);

  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(seededRandom(hashValue + i) * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
  }

  return shuffled;
}

export function getTopicColor(index: number, seedId?: string): string {
  const colors = seedId ? seededShuffle(TOPIC_COLORS, seedId) : TOPIC_COLORS;
  return colors[index % colors.length];
}
```

Usage:
```tsx
const color = getTopicColor(topicIndex, videoId);
<div style={{ backgroundColor: `hsl(${color})` }}>Topic {topicIndex}</div>
```
