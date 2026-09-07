# Website Audit Report: performalytic.com

**Scan Date:** 7th November 2026  
**Domain:** performalytic.com  
**Hosting:** GitHub Pages  
**Technology Stack:** Static HTML5, Vanilla JavaScript, Google Fonts (Inter), GA4, Google Forms

---

## Table of Contents

1. [Overview](#overview)
2. [Critical Issues](#critical-issues)
3. [High Priority Issues](#high-priority-issues)
4. [Medium Priority Issues](#medium-priority-issues)
5. [Low Priority Issues](#low-priority-issues)
6. [What's Working Well](#whats-working-well)
7. [Detailed Findings](#detailed-findings)
8. [Recommended Fix Priority](#recommended-fix-priority)

---

## Overview

| Metric | Value |
|--------|-------|
| Total Pages | ~60 (53 in sitemap) |
| Service Pages | 4 |
| Blog Articles | 21 + 1 index |
| Knowledge Hub Pages | 7 (index + 6 topics) |
| Tools | 3 (index, ROI calculator, lunch calculator) |
| Legal Pages | 3 (privacy, cookies, terms) |
| Other Pages | 10+ (products, FAQ, testimonials, careers, etc.) |
| Technology | Static HTML, Vanilla JS, GitHub Pages |
| Analytics | GA4 (G-FV09CSCD2C) |
| Forms | Google Forms submission |
| CSS Strategy | Inline critical CSS + deferred external stylesheet |
| JS Strategy | Deferred `main.js` + async analytics |
| Performance Score | B+ |
| Accessibility | Moderate (several WCAG failures) |
| SEO | Good (a few critical issues) |

---

## Critical Issues

### 1. Title Tag Bug — Broken Character

**File:** `application-development-and-system-integration/index.html`  
**Issue:** Title contains `? Performalytic` instead of `- Performalytic` (garbled character encoding)  
**Impact:** Displays incorrectly in SERPs and browser tabs  
**WCAG:** N/A  
**Fix:** Replace `?` with `-` in the `<title>` tag

### 2. Homepage Meta Description Too Long

**File:** `index.html`  
**Issue:** Meta description is **280 characters** — nearly double the recommended 155-160 char limit  
**Impact:** Will be truncated in Google SERPs, reducing click-through rate  
**Current:** `Performalytic helps enterprises turn data into a competitive advantage. Services: data strategy, advanced analytics, AI (RAG, agents, ML), BI integration (Power BI, SAP, Snowflake, Databricks), and application development. 800+ professionals, 500+ enterprise clients. Chicago & Bhubaneswar.`  
**Fix:** Shorten to ~155 characters while retaining key selling points

### 3. Critical Image Size — 2.2MB Single Image

**File:** `assets/images/data-reconciliation-flow.png`  
**Issue:** Single image is **2.2MB** — larger than many full web pages  
**Impact:** Severe page weight bottleneck, slow First Contentful Paint  
**Total image payload:** 5.9MB across 62 files  
**Files > 100KB:** 15  
**Files > 200KB:** 5  
**Fix:** Convert to WebP/AVIF, compress aggressively, consider lazy loading

### 4. No Modern Image Formats (WebP/AVIF)

**Issue:** All 62 raster images are JPEG/PNG — no WebP or AVIF conversion  
**Impact:** Missing 60-70% size savings from modern formats  
**Fix:** Use `<picture>` element with WebP/AVIF sources and JPEG/PNG fallbacks

### 5. Desktop Dropdown Menus Not Keyboard-Accessible

**Issue:** Dropdown menus are triggered by `:hover` CSS only — no keyboard event handlers  
**Impact:** Keyboard users cannot open or navigate dropdown menus (WCAG 2.1.1 failure)  
**Missing:** Arrow key navigation, Escape key to close, focus management within menus  
**Fix:** Add JavaScript keyboard event handlers for `keydown` on dropdown triggers and items

### 6. Form Errors Not Announced to Screen Readers

**Issue:** No `aria-live`, `role="alert"`, or `aria-invalid` on form validation errors  
**Impact:** Screen reader users are not notified when validation errors occur (WCAG 4.1.3 failure)  
**Applies to:** Contact form, careers apply form, book meeting form  
**Fix:** Add `aria-live="polite"` to error containers, set `aria-invalid="true"` on invalid fields, add `aria-describedby` linking errors to inputs

### 7. No Cookie Consent Banner

**Issue:** Privacy policy references cookie consent but no banner is implemented  
**Impact:** GDPR compliance risk — users cannot opt in/out of tracking  
**Fix:** Implement a cookie consent banner with accept/reject options before loading GA4

---

## High Priority Issues

### 8. Light Gray Text Fails WCAG AA Contrast

**CSS Color:** `#94a3b8` on white background  
**Contrast Ratio:** ~3.1:1 (fails WCAG AA minimum of 4.5:1 for normal text)  
**Used In:** Hero descriptions, section subtitles, form placeholders, meta text, testimonials  
**Fix:** Darken to at least `#64748b` (~4.6:1) or use `#475569` (~7:1)

### 9. No Focus Trap in Mobile Menu

**Issue:** When mobile menu is open, focus can escape to background content  
**Impact:** Keyboard users may interact with hidden content (WCAG 2.4.3)  
**Fix:** Trap focus within the mobile menu when open, return focus to hamburger button on close

### 10. No Escape Key Support for Menus

**Issue:** No `keydown` handler for Escape key on mobile menu or desktop dropdowns  
**Impact:** Keyboard users have no way to close menus (WCAG 2.1.1)  
**Fix:** Add Escape key listener to close menus and return focus to trigger element

### 11. All Pages Use Same og:image

**Issue:** Every page shares the same `og:image` (`GettyImages-618762080-1.jpg`)  
**Impact:** Social sharing previews look identical across all pages  
**Fix:** Create unique, relevant og:image for each page type (service, blog, about, etc.)

### 12. Blog Posts Use Wrong og:type

**Issue:** Blog posts use `og:type="website"` instead of `article`  
**Impact:** Missing `article:published_time`, `article:modified_time`, `article:author` properties  
**Fix:** Set `og:type="article"` on blog posts with appropriate timestamp properties

### 13. Missing twitter:site Handle

**Issue:** No `twitter:site` meta tag on any page  
**Impact:** Reduced brand visibility on Twitter/X card shares  
**Fix:** Add `<meta name="twitter:site" content="@performalytic">` to all pages

### 14. 4 Pages Missing from sitemap.xml

**Missing URLs:**
- `/case-studies/` (exists as `_case-studies/index.html`)
- `/partners/` (exists as `_partners/index.html`)
- `/careers/apply/`
- `/blog/schema-compare-guide/`

**Impact:** These pages may not be indexed by search engines  
**Fix:** Add missing URLs to sitemap.xml with appropriate priority and lastmod dates

### 15. No Service JSON-LD Schema

**Issue:** Service pages lack `Service` structured data  
**Impact:** Missed opportunity for rich results in SERPs  
**Fix:** Add `Service` JSON-LD with `name`, `description`, `provider`, `areaServed`

### 16. Blog Posts Missing Article JSON-LD Schema

**Issue:** Blog posts lack `Article` or `BlogPosting` structured data  
**Impact:** Missing rich result eligibility (author, datePublished, dateModified)  
**Fix:** Add `Article` JSON-LD to all blog posts

### 17. Contact Form Lacks CSRF/Rate-Limiting

**Issue:** Contact form submits directly to Google Forms without anti-abuse protections  
**Impact:** Vulnerable to spam and automated submissions  
**Fix:** Add honeypot field, rate limiting, or reCAPTCHA before form submission

### 18. CSP Mismatch Between Meta and Server Headers

**Issue:** Meta CSP does not include `tawk.to` but `web.config` CSP does  
**Impact:** Inconsistent security policy enforcement  
**Fix:** Reconcile CSP declarations between meta tag and server headers

---

## Medium Priority Issues

### 19. No Responsive Image srcset/sizes

**Issue:** All `<img>` tags use a single `src` without `srcset` or `sizes` attributes  
**Impact:** Same large image served to all viewports (mobile downloads desktop-sized images)  
**Fix:** Add `srcset` with multiple resolutions and `sizes` attribute based on viewport

### 20. No Build Pipeline

**Issue:** No webpack, Vite, Rollup, or any bundler — files served as-is  
**Impact:** No minification, no tree-shaking, no automatic image optimization  
**Files not minified:** `styles.css` (1004 lines), `main.js` (359 lines)  
**Fix:** Add build tooling for minification and image optimization

### 21. JSON-LD Logo Uses Relative Path

**Issue:** Organization logo uses `/assets/images/performalytic-logo.png` (relative)  
**Impact:** Google recommends absolute URLs for logos in structured data  
**Fix:** Change to `https://performalytic.com/assets/images/performalytic-logo.png`

### 22. Two Separate LocalBusiness Schemas

**Issue:** Homepage has two separate `LocalBusiness` entries (Chicago + Bhubaneswar)  
**Impact:** Could confuse search engines about primary business location  
**Fix:** Consolidate into single `Organization` with `areaServed` or use `MultiLocalBusiness`

### 23. About/Contact Titles Too Short

**Issue:** About title is 24 chars, Contact is 23 chars (recommended minimum: 30)  
**Impact:** Underutilizing title tag keyword potential  
**Fix:** Expand to include relevant keywords (e.g., "About Performalytic | Data Analytics Leadership")

### 24. Conflicting ARIA Semantics on Cards

**Issue:** `role="listitem"` on `<article>` elements creates conflicting roles  
**Impact:** Screen readers may announce "article, listitem" redundantly (WCAG 4.1.2)  
**Fix:** Remove `role="listitem"` from `<article>` elements or use `<li>` wrapper

### 25. Partner Logo Marquee Lacks Pause Control

**Issue:** Auto-scrolling partner logos have no keyboard-accessible pause/stop  
**Impact:** Violates WCAG 2.2.2 (Pause, Stop, Hide)  
**Fix:** Add visible pause/play button or respect `prefers-reduced-motion`

### 26. No aria-describedby on Form Errors

**Issue:** Error messages are not linked to their associated inputs via `aria-describedby`  
**Impact:** Screen readers don't announce which field has an error  
**Fix:** Add `aria-describedby="error-id"` to inputs when validation fails

### 27. Skills Input Lacks Combobox ARIA

**Issue:** Careers form skills input is a custom tag input without proper ARIA  
**Impact:** Inaccessible to screen readers (WCAG 4.1.2)  
**Fix:** Add `role="listbox"`, `aria-activedescendant`, and keyboard navigation

### 28. No Visible Breadcrumbs on Interior Pages

**Issue:** Schema breadcrumbs exist but are not visually rendered  
**Impact:** Users have no visual indication of site hierarchy  
**Fix:** Add visible breadcrumb navigation above page content

### 29. No Search Functionality

**Issue:** JSON-LD includes `SearchAction` but no search feature exists  
**Impact:** Misleading structured data, missing user functionality  
**Fix:** Either implement search or remove `SearchAction` from JSON-LD

### 30. Form Submission Replaces Entire Form

**Issue:** On successful submission, form HTML is replaced with success message  
**Impact:** No way to go back and edit, no `aria-live` announcement  
**Fix:** Add `aria-live="polite"` region for success message, consider keeping form visible

---

## Low Priority Issues

### 31. styles.css Not Minified

**File:** `assets/css/styles.css` (1004 lines)  
**Impact:** ~15-20% file size reduction possible  
**Fix:** Minify for production

### 32. main.js Not Minified

**File:** `assets/js/main.js` (359 lines)  
**Impact:** ~10-15% file size reduction possible  
**Fix:** Minify for production

### 33. No Service Worker / PWA Setup

**Issue:** No `sw.js`, `manifest.json`, or service worker  
**Impact:** No offline capability, no install prompt  
**Fix:** Consider adding for repeat visitors (low priority for B2B marketing site)

### 34. Generic Alt Text on Contact Hero Image

**File:** `contact/index.html`  
**Issue:** `alt="Illustration"` — too generic  
**Fix:** Use descriptive alt text like "Contact us illustration"

### 35. Generic Alt Text on Partner Logos

**Issue:** First group of partner logos uses `alt="Partner"` for all  
**Fix:** Use specific partner names (e.g., "Microsoft Partner", "Snowflake Partner")

### 36. No prefers-reduced-motion on Partner Marquee

**Issue:** Partner logo auto-scroll animation doesn't fully respect `prefers-reduced-motion`  
**Fix:** Add CSS to pause animation when user prefers reduced motion

### 37. Floating CTA Overlaps Content on Small Screens

**Issue:** Book a Meeting floating button positioned `bottom: 20px; right: 20px` overlaps content  
**Fix:** Adjust positioning for small viewports or hide on mobile

### 38. No Landscape Orientation Handling

**Issue:** No `@media (orientation: landscape)` rules  
**Impact:** Content may not optimize for landscape mobile view  
**Fix:** Add landscape-specific styles if needed

### 39. No Dark Mode Support

**Issue:** No `prefers-color-scheme: dark` media query  
**Impact:** Users in dark mode see bright white pages  
**Fix:** Add dark mode CSS variables and media query

### 40. Footer Uses h5 for Column Headings

**Issue:** Footer column headings use `<h5>` — inconsistent with heading hierarchy  
**Fix:** Use consistent heading levels or `<strong>` for footer columns

---

## What's Working Well

### CSS Strategy
- Critical CSS inlined in `<style nonce>` blocks (~15KB)
- External stylesheet deferred via `<link rel="preload">` + script flip
- Zero render-blocking CSS resources
- `display=swap` on Google Fonts

### JavaScript Strategy
- `main.js` loaded with `defer` — non-render-blocking
- Analytics loaded with `async`
- Inline scripts placed at bottom of `<body>`
- No jQuery, no Bootstrap, no heavy frameworks

### Image Optimization
- `loading="lazy"` on all below-fold images
- `decoding="async"` on all images
- `width` and `height` attributes on all `<img>` tags (prevents CLS)
- `fetchpriority="high"` on hero images

### Security Headers
- Content Security Policy with nonce-based script execution
- `X-Content-Type-Options: nosniff`
- `Permissions-Policy` (restrictive)
- `Referrer-Policy: strict-origin-when-cross-origin`
- `upgrade-insecure-requests`
- `object-src 'none'`
- `strict-dynamic` in CSP

### SEO Fundamentals
- Consistent, self-referencing canonical URLs on all pages
- Correct `hreflang="en"` + `hreflang="x-default"` on all pages
- Comprehensive robots.txt (blocks non-indexable pages, allows AI/LLM crawlers)
- sitemap.xml with 42+ URLs
- JSON-LD structured data on homepage (6 schema types)
- Unique meta descriptions per page (except homepage length issue)

### Accessibility Basics
- `<html lang="en">` on all pages
- Skip-to-content link present on all pages
- `prefers-reduced-motion` respected for scroll animations
- `:focus-visible` styles defined globally
- Semantic HTML: `<header>`, `<nav>`, `<main>`, `<section>`, `<footer>`
- `aria-label` on all `<nav>` and `<section>` elements
- `aria-hidden="true"` on decorative SVGs
- Proper `rel="noopener noreferrer"` on external links

### Performance
- Minimal external dependencies (Google Fonts, GA4 only)
- No render-blocking resources
- Proper preconnect to font origins
- Inline JSON-LD (non-blocking)

---

## Detailed Findings

### Page Structure (Homepage)

| Section | Content | Issues |
|---------|---------|--------|
| Hero | Gradient text, stats bar, SVG illustration | Stats use decorative formatting |
| Client Bar | "Trusted by" logos | Good |
| Services | 4 cards (Strategy, Analytics, AI, Digital) | Good |
| Solutions | 6 cards (MDM, Reconciliation, Quality, CI/CD, Schema, ER) | Good |
| AI & GenAI | 3 cards (RAG, Agents, Responsible AI) | Good |
| Tech Expertise | 8 items | Good |
| Industries | 6 cards | Good |
| Metrics | 4 items (10K+ projects, 500+ clients, 800+ pros, 99.9%) | Good |
| About | 3 impact items + CTA | Good |
| Vendors | 8 cards (Azure, Snowflake, Databricks, etc.) | Good |
| Process | 3 stages | Good |
| Trust | 4 items | Good |
| Testimonials | 4 cards | Good |
| Leadership | 2 team cards | Good |
| Latest Insights | 4 blog cards | Good |
| CTA/Contact | Steps + global locations | Good |
| Partners | Scrolling logo carousel | Missing pause control |

### Image Inventory

| Category | Count | Total Size | Largest File |
|----------|-------|------------|--------------|
| Brand logos | 8 | ~500KB | performalytic-logo-original.png |
| Team photos | 2 | ~700KB | Nihar-Rout.png (350KB) |
| Vendor/partner logos | 15 | ~300KB | vendor-snowflake.svg |
| Blog hero images | 21 | ~1.5MB | Various SVGs/PNGs |
| Industry images | 6 | ~600KB | Various |
| Process/trust images | 4 | ~400KB | Various |
| Stock photos | 6 | ~900KB | data-reconciliation-flow.png (2.2MB) |
| **Total** | **62** | **5.9MB** | **data-reconciliation-flow.png** |

### JSON-LD Schema Summary

| Schema Type | Page(s) | Status |
|-------------|---------|--------|
| Organization | Homepage, About | Present |
| WebSite | Homepage | Present |
| WebPage | Homepage | Present |
| FAQPage | Homepage | Present |
| LocalBusiness (Chicago) | Homepage | Present |
| LocalBusiness (Bhubaneswar) | Homepage | Present |
| BreadcrumbList | About | Present |
| Person | About | Present |
| Service | Service pages | **Missing** |
| Article/BlogPosting | Blog posts | **Missing** |

### Form Analysis

| Form | Fields | Validation | ARIA | Security |
|------|--------|------------|------|----------|
| Contact | Name, Email, Phone, Company, Message, Consent | JS validation | Labels present, errors lack aria | No CSRF |
| Careers Apply | Multi-step: Personal, Skills, Experience, Education, Resume | JS validation | Labels present, errors lack aria | No CSRF |
| Book Meeting | Name, Email, Phone, Date, Time, Timezone, Topic, Message | JS validation | Labels present, errors lack aria | No CSRF |
| Newsletter | Email only | Basic validation | Minimal | No CSRF |

---

## Recommended Fix Priority

### Phase 1 — Critical (Do Now)

| # | Issue | Effort | Impact |
|---|-------|--------|--------|
| 1 | Fix title character bug in app-dev page | 1 min | SEO |
| 2 | Shorten homepage meta description to ~155 chars | 5 min | SEO |
| 3 | Convert images to WebP/AVIF (especially 2.2MB PNG) | 2-4 hrs | Performance |
| 4 | Implement cookie consent banner | 4-8 hrs | Legal/Compliance |

### Phase 2 — High Priority (This Week)

| # | Issue | Effort | Impact |
|---|-------|--------|--------|
| 5 | Fix keyboard accessibility for dropdown menus | 4-6 hrs | Accessibility |
| 6 | Add `aria-live` regions for form errors | 2-3 hrs | Accessibility |
| 7 | Fix color contrast for light gray text | 1 hr | Accessibility |
| 8 | Add unique og:image per page | 2-3 hrs | SEO |
| 9 | Add Article schema to blog posts | 2-3 hrs | SEO |
| 10 | Add missing pages to sitemap.xml | 15 min | SEO |

### Phase 3 — Medium Priority (This Month)

| # | Issue | Effort | Impact |
|---|-------|--------|--------|
| 11 | Add responsive image srcset/sizes | 4-6 hrs | Performance |
| 12 | Add Service schema to service pages | 2-3 hrs | SEO |
| 13 | Fix CSP inconsistency | 1 hr | Security |
| 14 | Add focus trap to mobile menu | 2-3 hrs | Accessibility |
| 15 | Add visible breadcrumbs to interior pages | 3-4 hrs | UX |
| 16 | Minify CSS and JS | 1 hr | Performance |
| 17 | Add CSRF/rate-limiting to forms | 3-4 hrs | Security |
| 18 | Fix conflicting ARIA semantics on cards | 2 hrs | Accessibility |

### Phase 4 — Low Priority (Backlog)

| # | Issue | Effort | Impact |
|---|-------|--------|--------|
| 19 | Add service worker / PWA | 8-12 hrs | Performance |
| 20 | Add dark mode support | 4-6 hrs | UX |
| 21 | Add search functionality | 8-16 hrs | UX |
| 22 | Fix generic alt text | 30 min | Accessibility |
| 23 | Add prefers-reduced-motion to marquee | 15 min | Accessibility |
| 24 | Fix floating CTA on mobile | 15 min | UX |
| 25 | Fix footer heading hierarchy | 15 min | Accessibility |

---

*Report generated on 7th November 2026*
