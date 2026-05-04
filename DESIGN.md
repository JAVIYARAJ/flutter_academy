---
name: Lumina Creative
colors:
  surface: '#f9f9ff'
  surface-dim: '#cfdaf2'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d8e3fb'
  on-surface: '#111c2d'
  on-surface-variant: '#464555'
  inverse-surface: '#263143'
  inverse-on-surface: '#ecf1ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#00687a'
  on-secondary: '#ffffff'
  secondary-container: '#57dffe'
  on-secondary-container: '#006172'
  tertiary: '#684000'
  on-tertiary: '#ffffff'
  tertiary-container: '#885500'
  on-tertiary-container: '#ffd4a4'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#acedff'
  secondary-fixed-dim: '#4cd7f6'
  on-secondary-fixed: '#001f26'
  on-secondary-fixed-variant: '#004e5c'
  tertiary-fixed: '#ffddb8'
  tertiary-fixed-dim: '#ffb95f'
  on-tertiary-fixed: '#2a1700'
  on-tertiary-fixed-variant: '#653e00'
  background: '#f9f9ff'
  on-background: '#111c2d'
  surface-variant: '#d8e3fb'
typography:
  h1:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '800'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  h2:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  h3:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '700'
    lineHeight: '1'
    letterSpacing: 0.05em
  code-block:
    fontFamily: spaceGrotesk
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.6'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 8px
  sm: 16px
  md: 24px
  lg: 48px
  xl: 80px
  gutter: 24px
  max_width: 1280px
---

## Brand & Style

This design system is built to inspire intellectual curiosity while maintaining the precision of a high-tech learning environment. The brand personality is "Enlightened Technical"—it bridges the gap between a rigorous academic tool and an imaginative creative suite. 

The visual style leverages **Glassmorphism** as its core architectural principle. By using semi-transparent layers and background blurs, the UI feels lightweight and ethereal, reducing the perceived density of educational content. This is balanced with high-tech accents like micro-glows and precise inner shadows to ensure the interface feels grounded and premium rather than purely decorative. The goal is an emotional response of clarity, focus, and achievement.

## Colors

The palette is centered on **Deep Indigo**, a color that evokes stability and deep focus. This is contrasted by **Vibrant Cyan**, reserved strictly for kinetic elements like progress bars, active states, and "flow" indicators. **Mastery Gold** serves as a high-value accent for dopamine-heavy moments: certifications, leveled-up skills, and rewards.

The surface strategy uses a "Glass-First" approach. Surfaces are primarily semi-transparent white (#FFFFFFCC) with a 20px background blur, allowing a soft, cool-toned background gradient to peek through. This creates a sense of depth and airiness essential for long-form study sessions.

## Typography

This design system utilizes **Inter** for its entire interface to ensure maximum readability across technical documentation and instructional prose. 

Information hierarchy is established through aggressive weight scaling rather than just size. Headlines use Extra Bold weights with tight letter spacing for a modern, authoritative look. Body copy is set with generous line height to prevent ocular fatigue during reading. For technical contexts, **Space Grotesk** is introduced as a secondary mono-styled font for code blocks to maintain the "high-tech" brand promise.

## Layout & Spacing

The layout philosophy follows a **Fixed-Fluid Hybrid Grid**. Content is housed in a centered container with a max-width of 1280px to maintain optimal line lengths for educational reading. 

Spacing is intentionally generous (utilizing an 8px rhythmic scale). Large `xl` (80px) vertical gaps are used between major conceptual sections to provide "mental breathing room." Component internal padding is scaled to be "roomy," ensuring that interactive elements never feel cramped or overwhelming to a learner.

## Elevation & Depth

Depth in this design system is created through a combination of **Backdrop Blurs** and **Inner Glows**. 

1.  **Level 0 (Base):** A soft, multi-stop linear gradient background.
2.  **Level 1 (Cards):** Glass surfaces with a 1px white border (20% opacity) and a 20px background blur.
3.  **Level 2 (Active/Hover):** When an element is focused, a 2px inner shadow (Primary Indigo at 10% opacity) is applied to create a "pressed-in" or "carved" look, rather than a traditional drop shadow.
4.  **Level 3 (Modals):** High-contrast glass with a soft, 40px diffused shadow tinted with the Primary Indigo color to signify floating prominence.

## Shapes

The shape language is defined by a consistent **16px radius (rounded-lg)** for all primary containers and cards. This specific curvature is large enough to feel friendly and approachable but sharp enough to maintain a modern, "pro-tool" aesthetic. 

Small interactive elements like buttons and tags use the `rounded-xl` (1.5rem) or full pill shapes to signify touchability and movement. Input fields mirror the card radius (16px) to maintain visual harmony across the form layouts.

## Components

### Expressive Cards
Cards are the primary container. They feature a 1px "glass stroke" and use subtle scale-up (1.02x) on hover. Content within cards should be padded at `md` (24px) or `lg` (48px) levels.

### Progress Rings
Progress is visualized via dual-tone Cyan gradients. A secondary, faint track sits behind the active Cyan stroke. For 100% completion, the ring should transition from Cyan to Mastery Gold with a subtle outer glow.

### Buttons
Primary buttons use a linear gradient (Deep Indigo to a slightly lighter Indigo). They feature a 16px corner radius and an inner white highlight (0.5px) on the top edge to simulate a tactile, glass-like button surface.

### Code Blocks
To provide high contrast against the glass UI, code blocks use a dark charcoal background (#0F172A) with rounded corners (12px). Syntax highlighting should use a neon-inspired palette that complements the Cyan and Gold brand colors.

### Interactive Chips
Chips are used for category tags. They should be semi-transparent with a border matching the text color, using the `pill-shaped` radius for maximum distinction from buttons.