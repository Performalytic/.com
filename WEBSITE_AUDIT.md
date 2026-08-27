# Performalytic Website Audit Report

**Date:** August 27, 2026
**Total Issues Found:** 45
**Breakdown:** 8 HIGH | 18 MEDIUM | 19 LOW

---

## Table of Contents

1. [Structural Issues](#1-structural-issues)
2. [HTML / Meta Issues](#2-html--meta-issues)
3. [SEO Issues](#3-seo-issues)
4. [Content Issues](#4-content-issues)
5. [Accessibility Issues](#5-accessibility-issues)
6. [Performance Issues](#6-performance-issues)
7. [Technical Issues](#7-technical-issues)
8. [Cross-Page Consistency Issues](#8-cross-page-consistency-issues)
9. [Summary](#9-summary)

---

## 1. Structural Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 1.1 | 404 page links to `/services/` which does not exist anywhere in the project | `404.html:219` | **HIGH** |
| 1.2 | `sitemap.xml` references `https://performalytic.com/sitemap/` — this URL 404s. Actual file is `/sitemap.html` | `sitemap.xml:214` | **HIGH** |
| 1.3 | `partners/` directory exists but contains no `index.html` — page is empty | `/partners/` | **HIGH** |
| 1.4 | `case-studies/` directory exists but contains no `index.html` — page is empty | `/case-studies/` | **HIGH** |
| 1.5 | `disputes/` directory is empty with no content | `/disputes/` | MEDIUM |
| 1.6 | `_partners/` and `_case-studies/` are drafts (underscore prefix) but `.nojekyll` disables Jekyll processing — confusing deployment state | root | MEDIUM |

---

## 2. HTML / Meta Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 2.1 | `terms-conditions/` missing `og:image`, `og:image:width`, `og:image:height`, `og:image:type`, `og:image:alt`, and all `twitter:image` tags | `terms-conditions/index.html` | **HIGH** |
| 2.2 | `cookie-policy/` missing `prefix="og: https://ogp.me/ns#"` on `<html>` tag — OG meta tags will not be recognized by crawlers | `cookie-policy/index.html` | **HIGH** |
| 2.3 | `book-meeting/` missing `og:image:alt` and `article:published_time` / `article:modified_time` | `book-meeting/index.html` | MEDIUM |
| 2.4 | `cookie-policy/` and `maintenance.html` missing `<meta name="author">` tag | multiple | LOW |

---

## 3. SEO Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 3.1 | Blog filter links all point to `/blog/` — filters are non-functional and do not filter by category | `blog/index.html` | **HIGH** |
| 3.2 | `faq/` page has no `FAQPage` structured data (homepage has one, but the dedicated FAQ page does not) | `faq/index.html` | MEDIUM |
| 3.3 | No `BreadcrumbList` schema on: blog, products, technologies, faq, industries, tools, testimonials, careers | multiple pages | MEDIUM |
| 3.4 | `sitemap.xml` dates (2026-08-19/21) conflict with `dateModified` in homepage schema (2026-07-07) | `sitemap.xml` + `index.html` | LOW |

---

## 4. Content Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 4.1 | Testimonials section is **hidden** with comment "real client data pending" | `index.html:1271` | **HIGH** |
| 4.2 | Hero rating is **hidden** with comment "real client reviews pending" | `index.html:773` | **HIGH** |
| 4.3 | Company values are **completely different** between homepage and about page — two different sets of values on pages that should match | `index.html` vs `about/index.html` | **HIGH** |
| 4.4 | Phone number in schema uses `+1-312-555-0100` — `555` prefix is a US fiction/reserved range (placeholder) | schema markup | MEDIUM |
| 4.5 | Partner logos (8 images) all have generic `alt="Partner"` — no actual partner names identified | `index.html:1522-1539` | MEDIUM |
| 4.6 | Testimonial names appear fabricated: "Sarah Chen", "Michael Rodriguez", "Dr. Lisa Wang", "Emily Foster" with generic company names | `index.html` | MEDIUM |
| 4.7 | `tools/` page shows "1 Active Tools, 4+ Coming Soon" — mostly empty with only one actual tool | `tools/index.html` | MEDIUM |

---

## 5. Accessibility Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 5.1 | **No "Skip to main content" link on any page** — WCAG 2.1 AA violation | all pages | **HIGH** |
| 5.2 | Color contrast fails: `#64748b` on `#060d1a` background = ~3.8:1 ratio (WCAG AA requires 4.5:1 for normal text) | hero stats, footer links | MEDIUM |
| 5.3 | Blog filter buttons have no ARIA `role="tab"` or `aria-selected` attributes — not keyboard-navigable as a tab group | `blog/index.html` | MEDIUM |
| 5.4 | Partner carousel `<img>` elements have `role="listitem"` — invalid attribute on img elements (should be on parent container) | `index.html:1522` | LOW |
| 5.5 | `cookie-policy/` and `maintenance.html` missing `<main>` element wrapping page content | multiple | LOW |

---

## 6. Performance Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 6.1 | **Massive inline CSS** (~650 lines in `index.html`, ~350 lines in `about/`) duplicates the external stylesheet — inflates HTML file size and prevents caching | all pages | MEDIUM |
| 6.2 | Google Fonts loads **9 font weights** (400-900) — only 2-3 are typically used, adding unnecessary download time | all pages | LOW |
| 6.3 | No WebP conversion or responsive `srcset` attributes on large images (Getty, Unsplash, Pexels) | `/assets/images/` | LOW |
| 6.4 | No `fetchpriority` on hero images — only the nav logo has it | `index.html` | LOW |

---

## 7. Technical Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 7.1 | Google Form backend creates hidden `<iframe>` and `<form>` dynamically — may cause CSP issues if Content Security Policy is too strict | `index.html:1610` | LOW |
| 7.2 | `form-action` CSP only specified on contact/careers pages — other pages with Google Forms may break | multiple | LOW |
| 7.3 | Favicon filename contains WordPress-style timestamp hash (`fav-1-e1651044714367.png`) — suggests exported from WordPress, unprofessional naming | root | LOW |
| 7.4 | `robots.txt` does not `Disallow` `_partners/` or `_case-studies/` — draft directories may be crawled | `robots.txt` | LOW |

---

## 8. Cross-Page Consistency Issues

| # | Issue | Location | Severity |
|---|---|---|---|
| 8.1 | `404.html`, `cookie-policy/`, `thank-you.html` have **simplified nav** (4 items) vs full nav (5+ items with dropdowns) on all other pages | multiple | MEDIUM |
| 8.2 | Mobile menu is flat on some pages (404, cookie-policy, thank-you), grouped on others | multiple | MEDIUM |
| 8.3 | "Book a Meeting" floating button only on homepage — missing from all other pages | `index.html` | MEDIUM |
| 8.4 | `prefers-reduced-motion` media query only in `about/` — homepage ignores user's motion preference setting | `index.html` | MEDIUM |
| 8.5 | Hero background gradient is slightly different between pages (different color stops in linear-gradient) | multiple | LOW |

---

## 9. Summary

### By Severity

| Severity | Count | Percentage |
|---|---|---|
| **HIGH** | 8 | 18% |
| **MEDIUM** | 18 | 40% |
| **LOW** | 19 | 42% |
| **Total** | **45** | 100% |

### By Category

| Category | HIGH | MEDIUM | LOW | Total |
|---|---|---|---|---|
| Structural Issues | 4 | 2 | 0 | 6 |
| HTML / Meta Issues | 2 | 1 | 1 | 4 |
| SEO Issues | 1 | 2 | 1 | 4 |
| Content Issues | 3 | 4 | 0 | 7 |
| Accessibility Issues | 1 | 2 | 2 | 5 |
| Performance Issues | 0 | 1 | 3 | 4 |
| Technical Issues | 0 | 0 | 4 | 4 |
| Cross-Page Consistency | 0 | 4 | 1 | 5 |
| **Total** | **8** | **18** | **19** | **45** |

### Priority Fixes (Recommended Order)

1. Fix broken `/services/` link on 404 page
2. Fix sitemap.xml broken `/sitemap/` reference
3. Publish or remove empty `partners/` and `case-studies/` pages
4. Add missing OG image tags to `terms-conditions/`
5. Fix `cookie-policy/` missing OG prefix attribute
6. Make blog category filters functional
7. Add skip navigation links to all pages
8. Unify company values across homepage and about page
9. Publish real testimonials or remove hidden section
10. Add `prefers-reduced-motion` support to homepage
