# SEO Launch Guide: Google Search Console + Bing Webmaster Tools

Goal: get performalytic.com fully indexed by Google (browser search) and Bing
(**Bing also feeds ChatGPT's citations — this is the #1 lever for AI search**).

Site facts used below:
- Canonical domain: `https://performalytic.com/` (non-www)
- Sitemap: `https://performalytic.com/sitemap.xml`
- Hosting: GitHub Pages (custom domain)
- DNS: managed at Squarespace Domains

---

## Part 1 — Google Search Console

### 1. Create the property
1. Go to <https://search.google.com/search-console> and sign in with any Google account.
2. Click **Add property** → choose **URL prefix**.
3. Enter exactly: `https://performalytic.com/` (do NOT pick domain — URL prefix is simpler here).
4. Click **Continue**.

### 2. Verify ownership (pick one — HTML meta tag is easiest for you)
- **HTML meta tag (recommended):** Google gives you a line like
  `<meta name="google-site-verification" content="...">`. Add it inside the `<head>` of
  `index.html` (right after the existing meta tags), commit, push to `main`. GitHub Pages
  deploys automatically (workflow: `.github/workflows/static.yml`). Click **Verify**.
- **DNS TXT (alternative):** In Squarespace Domains → DNS Settings, add the TXT record
  Google provides. Takes longer to propagate but needs no code change.

> Ask the developer assistant to insert the verification tag for you once Google gives it to you.

### 3. Submit the sitemap
1. In the sidebar: **Sitemaps**.
2. Enter: `sitemap.xml`
3. Click **Submit**. It should show "Success". Wait 24–48h for the URL count to populate
   (currently 47 URLs). If a new sitemap is added later, resubmit here.

### 4. Request indexing for the money pages
Use the URL Inspection tool (top search bar in GSC) for each of these, one at a time,
click **Request indexing**:
- `https://performalytic.com/`
- `https://performalytic.com/about/`
- `https://performalytic.com/contact/`
- `https://performalytic.com/blog/`
- `https://performalytic.com/products/`
- `https://performalytic.com/tools/data-roi-calculator/`
- Top 3 blog posts (e.g. `automated-data-reconciliation`, `databricks-vs-snowflake`,
  `enterprise-rag-architecture`)

### 5. Weekly 5-minute check (once indexing starts)
- **Pages report** (Indexing → Pages): anything "Excluded" that should be indexed? Anything
  "Not indexed (crawled — currently not indexed)" that matters? These are the 404 fixes and
  the renamed pages (`/case-studies/`, `/testimonials/`, `/partners/`) — confirm they now appear
  as indexed after the sitemap refresh.
- **Core Web Vitals** (Enhancements → Core Web Vitals): confirm green (LCP < 2.5s, INP < 200ms, CLS < 0.1).
- **Links** report: track new backlinks as outreach (see OUTREACH_CONTENT.md) lands.
- **Security & Manual actions**: should always be empty.

---

## Part 2 — Bing Webmaster Tools (feeds ChatGPT)

Bing's index is what OpenAI's ChatGPT search and Copilot pull from. If Bing doesn't have you,
ChatGPT won't cite you. This matters as much as Google.

### 1. Create the site
1. Go to <https://www.bing.com/webmasters> and sign in (Microsoft account).
2. **Add site** → type: `https://performalytic.com/`.

### 2. Verify — easiest: import from Google
1. In Bing Webmaster Tools, click **Import from Google Search Console**.
2. Allow the Google sign-in; Bing copies your verified property, sitemaps, and data automatically.
   (You must own the GSC property from Part 1.)

### 3. Submit the sitemap
1. Sidebar → **Sitemaps** → enter `https://performalytic.com/sitemap.xml` → Submit.
2. Confirm status "Success".

### 4. (Recommended) URL submission + IndexNow
1. Sidebar → **URL Submission** → toggle **"Submit URLs automatically with IndexNow"**.
2. IndexNow works by pinging Bing whenever a page changes. For GitHub Pages you can either:
   - Add the IndexNow key file + URL ping into the CI workflow, or
   - Simply rely on Bing's crawler (slower, but fine).
   Priority: low — nice acceleration, not a requirement.

---

## Part 3 — Optional accelerators

- **Google Analytics (GA4):** confirm GA tags already on the site (they are — GTM/GA appear in
  the CSP). Use GA4 to see which pages get cited vs. bounce, and double down on winners.
- **Check `robots.txt` after deploy:** visit `https://performalytic.com/robots.txt` — it should
  show the AI-crawler allow-list. Both GSC and Bing validate it in their tools.
- **Re-verify sitemap health after the next content push:** run <https://performalytic.com/sitemap.xml>
  through Bing's and Google's validators in their dashboards.

---

## Part 4 — Reality timeline

- Google/Bing **discovery**: hours to a few days after sitemap submission.
- **Indexed** (URLs appear in search): days to ~2 weeks.
- **Ranking** for competitive terms: weeks to months — driven by backlinks, content freshness,
  and click-through. The technical foundation is now clean; the next variable is **off-page**
  (OUTREACH_CONTENT.md).

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Sitemap shows 0 URLs for 48h+ | Propagation delay | Wait; re-open sitemap in GSC |
| "Couldn't fetch" | Deploy not finished | Verify site loads at performalytic.com; resubmit after next push |
| Pages "Discovered — currently not indexed" | Low priority/duplicate | Request indexing for the specific URL |
| `/partners/` or `/testimonials/` 404 | Old cache | They were just renamed — request indexing on the new URLs |
