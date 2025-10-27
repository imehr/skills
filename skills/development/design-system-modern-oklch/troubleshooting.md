# Design System Modern OKLCH - Troubleshooting

Common issues and solutions when implementing the OKLCH design system.

## OKLCH Colors Not Showing

### Problem
Colors appear as fallback values or don't display correctly.

### Diagnosis
```bash
# Check Tailwind version
npm list tailwindcss

# Should be v4.x.x
```

### Solutions

**1. Ensure Tailwind v4 installed:**
```bash
npm install -D tailwindcss@4 @tailwindcss/postcss@4
```

**2. Check CSS import order:**
```css
/* globals.css - MUST be in this order */
@import "tailwindcss";         /* First */
@import "tw-animate-css";      /* Second */

@custom-variant dark (&:is(.dark *));  /* After imports */
@theme inline { ... }                  /* After custom-variant */
```

**3. Verify CSS variables are kebab-case:**
```css
/* ✅ Correct */
--primary: oklch(0.205 0 0);

/* ❌ Wrong */
--primaryColor: oklch(0.205 0 0);
```

**4. Browser support:**
OKLCH requires:
- Chrome 111+ (March 2023)
- Safari 15.4+ (March 2022)
- Firefox 113+ (May 2023)

Check browser version in DevTools Console:
```javascript
navigator.userAgent
```

---

## Dark Mode Not Switching

### Problem
`.dark` class added to `<html>` but colors don't change.

### Diagnosis
```bash
# Check if .dark class is present
# In browser DevTools:
document.documentElement.classList.contains('dark')
```

### Solutions

**1. Verify dark mode colors defined:**
```css
/* globals.css must have both :root and .dark */
:root {
  --background: oklch(1 0 0);  /* Light */
}

.dark {
  --background: oklch(0.145 0 0);  /* Dark */
}
```

**2. Check custom-variant syntax:**
```css
/* Tailwind v4 syntax */
@custom-variant dark (&:is(.dark *));

/* NOT the old @media syntax */
```

**3. Theme provider setup:**
```bash
npm install next-themes
```

```tsx
// app/providers.tsx
"use client"
import { ThemeProvider } from "next-themes"

export function Providers({ children }) {
  return (
    <ThemeProvider attribute="class" defaultTheme="system" enableSystem>
      {children}
    </ThemeProvider>
  )
}
```

**4. Ensure HTML element has .dark class:**
```tsx
// app/layout.tsx
import { Providers } from "./providers"

export default function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  )
}
```

---

## CVA Not Working / Type Errors

### Problem
`cva` function throws errors or types don't work.

### Diagnosis
```bash
# Check if installed
npm list class-variance-authority

# Check TypeScript version
npm list typescript
```

### Solutions

**1. Install CVA:**
```bash
npm install class-variance-authority
```

**2. Correct import syntax:**
```typescript
// ✅ Correct
import { cva, type VariantProps } from "class-variance-authority"

// ❌ Wrong
import cva from "class-variance-authority"
```

**3. Type-safe component pattern:**
```typescript
const buttonVariants = cva(
  "base-classes",
  { variants: { ... }, defaultVariants: { ... } }
)

// Export for external use
export { buttonVariants }

// Use VariantProps for type inference
function Button({
  variant,
  size,
  ...props
}: React.ComponentProps<"button"> & VariantProps<typeof buttonVariants>) {
  return <button className={cn(buttonVariants({ variant, size }))} {...props} />
}
```

---

## Shadows Not Visible

### Problem
Custom shadow values don't show or appear wrong.

### Diagnosis
```bash
# Inspect element in DevTools
# Check computed styles for box-shadow
```

### Solutions

**1. Use exact rgba format:**
```typescript
// ✅ Correct - RGBA with explicit alpha
"shadow-[0px_18px_59.6px_0px_rgba(0,0,0,0.06)]"

// ❌ Wrong - HSL not supported in shadows
"shadow-[0px_18px_59.6px_0px_hsl(0_0%_0%_/_.06)]"
```

**2. Check z-index stacking:**
Shadows may be hidden behind other elements. Ensure proper stacking context:
```tsx
<div className="relative z-10 shadow-[0px_18px_59.6px_0px_rgba(0,0,0,0.06)]">
  Card with shadow
</div>
```

**3. Background must allow shadows:**
```tsx
/* ✅ Shadows visible on white/light backgrounds */
<div className="bg-white shadow-[...]">...</div>

/* ⚠️ Shadows less visible on dark backgrounds */
<div className="bg-black shadow-[...]">...</div>
```

---

## cn() Utility Not Found

### Problem
`cn()` function import fails.

### Diagnosis
```bash
ls lib/utils.ts
# File not found error
```

### Solutions

**1. Create lib/utils.ts:**
```typescript
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
```

**2. Install dependencies:**
```bash
npm install clsx tailwind-merge
```

**3. Verify path alias in tsconfig.json:**
```json
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./*"]
    }
  }
}
```

---

## Fonts Not Loading

### Problem
Geist fonts don't load or show fallback fonts.

### Diagnosis
```bash
# Check network tab in DevTools for font requests
# Should see requests to fonts.gstatic.com
```

### Solutions

**1. Install next/font:**
```bash
# Included with Next.js 15, but verify
npm list next
```

**2. Correct font import:**
```typescript
// app/layout.tsx
import { Geist, Geist_Mono } from "next/font/google";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});
```

**3. Apply font variables to body:**
```tsx
<body className={`${geistSans.variable} ${geistMono.variable} antialiased`}>
  {children}
</body>
```

**4. Reference in globals.css:**
```css
@theme inline {
  --font-sans: var(--font-geist-sans);
  --font-mono: var(--font-geist-mono);
}
```

---

## Focus Rings Not Showing

### Problem
Focus states (ring on tab) don't appear on buttons/inputs.

### Diagnosis
```bash
# Tab through elements - no visual focus indicator
```

### Solutions

**1. Include focus-visible classes:**
```typescript
const buttonVariants = cva(
  "... focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] outline-none",
  { variants: { ... } }
)
```

**2. Ensure ring color defined:**
```css
:root {
  --ring: oklch(0.708 0 0);  /* Gray focus ring */
}

.dark {
  --ring: oklch(0.556 0 0);  /* Darker gray for dark mode */
}
```

**3. Test with keyboard navigation:**
```bash
# Press Tab key to navigate
# Focus ring should appear around interactive elements
```

---

## Build Errors

### Problem
Build fails with CSS or PostCSS errors.

### Diagnosis
```bash
npm run build
# Check error messages
```

### Solutions

**1. Verify PostCSS config:**
```javascript
// postcss.config.mjs
export default {
  plugins: {
    '@tailwindcss/postcss': {},
  },
}
```

**2. Check Tailwind v4 compatibility:**
```bash
# Remove old tailwind.config.js if exists
rm tailwind.config.js

# Tailwind v4 uses CSS-first configuration
```

**3. Clear build cache:**
```bash
rm -rf .next
npm run build
```

---

## TypeScript Errors with Components

### Problem
TypeScript complains about component props.

### Solutions

**1. Use proper React.ComponentProps:**
```typescript
// ✅ Correct
function Button({
  className,
  ...props
}: React.ComponentProps<"button">) {
  return <button {...props} />
}

// ❌ Wrong
function Button(props: any) {
  return <button {...props} />
}
```

**2. Combine with VariantProps:**
```typescript
function Button({
  variant,
  size,
  className,
  ...props
}: React.ComponentProps<"button"> & VariantProps<typeof buttonVariants>) {
  // ...
}
```

---

## Performance Issues

### Problem
Large bundle size or slow build times.

### Solutions

**1. Check Tailwind v4 benefits:**
Tailwind v4 is significantly faster than v3. Verify version:
```bash
npm list tailwindcss
```

**2. Use next-themes lazy loading:**
```tsx
import dynamic from "next/dynamic"

const ThemeToggle = dynamic(
  () => import("./theme-toggle").then(mod => mod.ThemeToggle),
  { ssr: false }
)
```

**3. Optimize imports:**
```typescript
// ✅ Tree-shakeable
import { Button } from "@/components/ui/button"

// ❌ Imports everything
import * as Components from "@/components/ui"
```

---

## Still Having Issues?

1. **Check browser console** for JavaScript errors
2. **Inspect element** to see computed CSS values
3. **Verify all dependencies** are installed with correct versions
4. **Clear caches** (`.next`, `node_modules/.cache`)
5. **Compare with working example** from TLDW repository
6. **Search for error messages** in Tailwind/Shadcn documentation

## Useful Debugging Commands

```bash
# Check all versions
npm list tailwindcss @tailwindcss/postcss class-variance-authority clsx tailwind-merge

# Verify file structure
ls app/globals.css lib/utils.ts components/ui/

# Test CSS compilation
npx tailwindcss -i app/globals.css -o debug-output.css

# Check TypeScript
npx tsc --noEmit

# Clear everything and rebuild
rm -rf .next node_modules package-lock.json
npm install
npm run build
```
