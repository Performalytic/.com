param(
    [string]$BlogDir = "C:\Users\manga\Documents\GitHub\performalytic\blog"
)

$ErrorActionPreference = "Stop"

$boilerplate = @'
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
html{scroll-behavior:smooth}
body{font-family:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;color:#1e293b;background:#fff;line-height:1.6;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}
.container{max-width:1200px;margin:0 auto;padding:0 24px}
a{color:inherit}
img{max-width:100%;height:auto}

/* Nav */
header nav{position:fixed;top:0;left:0;right:0;z-index:1000;background:rgba(255,255,255,0.97);backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);border-bottom:1px solid rgba(0,0,0,0.06)}
header nav .container{display:flex;align-items:center;justify-content:space-between;height:72px}
.nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none;font-weight:800;font-size:1.25rem;color:#0f172a;letter-spacing:-0.5px}
.nav-logo img{height:36px;width:240px;object-fit:cover;object-position:center;display:block}
.nav-links{display:flex;align-items:center;gap:24px;list-style:none}
.nav-links>li{position:relative}
.nav-links>li>a{text-decoration:none;color:#475569;font-size:0.9rem;font-weight:500;padding:8px 0;display:inline-flex;align-items:center;gap:4px;cursor:pointer}
.nav-links>li>a:hover{color:#2563eb}
.nav-links>li>a .arrow{font-size:0.6rem;transition:transform 0.2s}
.nav-links>li:hover>a .arrow{transform:rotate(180deg)}
.nav-dropdown{display:none;position:absolute;top:100%;left:0;background:#fff;min-width:220px;border-radius:12px;box-shadow:0 20px 50px rgba(0,0,0,0.1);border:1px solid #e2e8f0;padding:8px;z-index:100}
.nav-links>li:hover .nav-dropdown{display:block}
.nav-dropdown a{display:block;padding:10px 16px;color:#475569;text-decoration:none;font-size:0.85rem;font-weight:500;border-radius:8px;transition:all 0.15s}
.nav-dropdown a:hover{background:#f8fafc;color:#2563eb}
.nav-cta{background:linear-gradient(135deg,#2563eb,#7c3aed);color:#fff!important;padding:10px 32px!important;border-radius:100px;font-weight:600;font-size:0.88rem;letter-spacing:0.01em;transition:all 0.25s}
.nav-cta:hover{background:linear-gradient(135deg,#1d4ed8,#6d28d9)!important;transform:translateY(-2px);box-shadow:0 6px 20px rgba(37,99,235,0.35)}
.menu-toggle{display:none;flex-direction:column;gap:5px;background:none;border:none;cursor:pointer;padding:4px;min-width:44px;min-height:44px;align-items:center;justify-content:center}
.menu-toggle span{display:block;width:24px;height:2px;background:#0f172a;border-radius:2px;transition:transform 0.3s,opacity 0.3s}
.mobile-menu{display:none;position:fixed;top:72px;left:0;right:0;background:#fff;padding:24px;box-shadow:0 20px 40px rgba(0,0,0,0.1);flex-direction:column;gap:8px;z-index:999;max-height:calc(100vh - 72px);overflow-y:auto}
.mobile-menu.active{display:flex}
.mobile-menu .mm-group{margin-bottom:12px}
.mobile-menu .mm-label{font-size:0.75rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:#94a3b8;padding:8px 0 4px}
.mobile-menu a{text-decoration:none;color:#0f172a;font-size:0.95rem;font-weight:500;padding:10px 0;border-bottom:1px solid #f1f5f9;display:block}
.mobile-menu a:last-child{border-bottom:none}
.mobile-menu .nav-cta{text-align:center;padding:14px;margin-top:8px;border-radius:100px;display:block}

section{padding:100px 0}
.section-label{display:inline-flex;align-items:center;gap:6px;background:rgba(37,99,235,0.08);padding:6px 14px;border-radius:100px;font-size:0.8rem;font-weight:600;color:#2563eb;text-transform:uppercase;letter-spacing:0.5px;margin-bottom:16px}

.btn-primary{display:inline-flex;align-items:center;gap:8px;background:#2563eb;color:#fff;padding:14px 32px;border-radius:10px;text-decoration:none;font-weight:600;font-size:0.95rem;transition:all 0.2s;border:none;cursor:pointer}
.btn-primary:hover{background:#1d4ed8;transform:translateY(-2px);box-shadow:0 10px 30px rgba(37,99,235,0.3)}

/* Footer */
footer{background:#0f172a;border-top:1px solid rgba(255,255,255,0.06);padding:56px 0 24px}
.footer-grid{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:48px;margin-bottom:40px}
.footer-brand-logo{height:64px;max-width:160px;display:block;margin-bottom:16px}
.footer-brand p{font-size:0.85rem;color:#94a3b8;line-height:1.7;max-width:320px}
.footer-social{display:flex;gap:12px;margin-top:24px}
.footer-social a{width:40px;height:40px;border-radius:10px;border:1px solid rgba(255,255,255,0.1);display:flex;align-items:center;justify-content:center;color:#cbd5e1;text-decoration:none;font-size:0.9rem;font-weight:700;transition:all 0.2s}
.footer-social a:hover{border-color:#2563eb;color:#2563eb;background:rgba(37,99,235,0.1)}
.footer-col h5{font-size:0.85rem;font-weight:700;text-transform:uppercase;letter-spacing:0.5px;color:#e2e8f0;margin-bottom:20px}
.footer-col a{display:block;font-size:0.85rem;color:#94a3b8;text-decoration:none;padding:5px 0;transition:color 0.2s}
.footer-col a:hover{color:#e2e8f0}
.footer-bottom{display:flex;justify-content:space-between;align-items:center;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);font-size:0.82rem;color:#94a3b8}
.footer-bottom a{color:#94a3b8;text-decoration:none}
.footer-bottom a:hover{color:#cbd5e1}
.footer-bottom-links{display:flex;gap:24px}

@media(max-width:768px){
.nav-links,.nav-cta{display:none}
.menu-toggle{display:flex}
.mobile-menu.active{display:flex}
.footer-grid{grid-template-columns:1fr 1fr;gap:32px}
section{padding:60px 0}
}
@media(max-width:480px){
.footer-grid{grid-template-columns:1fr}
.footer-bottom{flex-direction:column;gap:12px;text-align:center}
}
'@

# Page-specific class names (NOT in styles.css - these SHOULD be preserved)
$pageSpecificClassNames = @(
    'comparison-table'
    'tldr-box'
    'architecture-diagram'
    'pricing-comparison'
    'use-case-diagram'
    'agent-loop-diagram'
    'rag-pipeline-diagram'
    'diagram-section'
    'verdict-grid'
    'verdict-item'
    'btn-secondary'
    'btn-secondary-light'
    'section-title'
    'section-subtitle'
    'text-center'
    'mx-auto'
    'sr-only'
    'faq-section'
    'faq-item'
    'faq-question'
    'faq-answer'
    'author-bio'
    'comparison-table-wrap'
    '.toc'
)

# Covered by styles.css - these should NOT be in page-specific CSS
$coveredClassNames = @(
    'post-hero'
    'post-content'
    'post-meta'
    'post-toc'
    'featured-image-section'
    'featured-image-caption'
    'verdict-box'
    'highlight-box'
    'gradient-text'
    'blog-cta'
    'blog-cta-actions'
    'post-footer-nav'
    'post-featured-image'
    'blog-post-hero'
    'reading-progress'
    'post-content-wrap'
    'hero-description'
    'comparison-box'
    'comparison-col'
)

# Known boilerplate-only selectors (to filter out orphaned rules)
$boilerplateFullPatterns = @(
    'a{color:inherit}'
    'img{max-width:100%'
    'html{scroll-behavior:smooth}'
    'body{font-family'
    'section{padding:100px 0}'
    'section{padding:60px 0}'
    '.menu-toggle{display'
    '.footer-grid{grid-template-columns:1fr 1fr'
    '.footer-grid{grid-template-columns:1fr}'
    '.footer-bottom{flex-direction:column'
    'footer .footer-grid{grid-template-columns:1fr 1fr'
)

# Check if a rule text contains any page-specific class pattern
function Test-IsPageSpecificRule {
    param([string]$Rule)
    $lower = $Rule.ToLowerInvariant()
    foreach ($p in $pageSpecificClassNames) {
        if ($lower.Contains($p.ToLowerInvariant())) { return $true }
    }
    return $false
}

# Check if a rule is definitely boilerplate (element selectors or known patterns)
function Test-IsBoilerplateRule {
    param([string]$Rule)
    $trimmed = $Rule.Trim()

    # Check exact matches against known boilerplate full patterns
    foreach ($p in $boilerplateFullPatterns) {
        if ($trimmed.StartsWith($p)) { return $true }
    }

    # Get the selector part
    $braceIdx = $trimmed.IndexOf('{')
    $selector = if ($braceIdx -ge 0) { $trimmed.Substring(0, $braceIdx).Trim() } else { $trimmed }

    # Bare HTML element selectors
    $bareElements = @('html', 'body', 'a', 'img', 'section', 'footer', 'header')
    if ($selector -in $bareElements) { return $true }

    # Known boilerplate class patterns (in selector)
    $boilerplateSelectors = @(
        '.container'
        '.nav-logo'
        '.nav-links'
        '.nav-dropdown'
        '.nav-cta'
        '.menu-toggle'
        '.mobile-menu'
        '.section-label'
        '.btn-primary'
        '.footer-grid'
        '.footer-brand'
        '.footer-social'
        '.footer-col'
        '.footer-bottom'
        '.footer-bottom-links'
        'header nav'
        'footer '
    )
    foreach ($s in $boilerplateSelectors) {
        if ($selector.Contains($s)) { return $true }
    }

    # Check if selector contains a covered class
    foreach ($c in $coveredClassNames) {
        if ($selector.Contains($c)) { return $true }
    }

    return $false
}

# Get blog article directories (exclude blog/index.html)
$articleDirs = Get-ChildItem -Directory -Path $BlogDir | Where-Object { $_.Name -ne "index.html" } | Sort-Object Name

$updated = @()
$issues = @()

foreach ($dir in $articleDirs) {
    $filePath = Join-Path -Path $dir.FullName -ChildPath "index.html"
    if (-not (Test-Path $filePath)) {
        $issues += "No index.html in $($dir.Name)"
        continue
    }

    Write-Host "Processing: $($dir.Name)" -ForegroundColor Cyan
    $content = Get-Content $filePath -Raw

    $styleStart = '<style nonce="P3rf0rm4lyt1c">'
    $styleEnd = '</style>'

    $startIdx = $content.IndexOf($styleStart)
    $endIdx = $content.IndexOf($styleEnd, $startIdx)

    if ($startIdx -lt 0 -or $endIdx -lt 0) {
        $issues += "No style block found in $($dir.Name)/index.html"
        continue
    }

    $oldStyle = $content.Substring($startIdx + $styleStart.Length, $endIdx - $startIdx - $styleStart.Length)
    $beforeStyle = $content.Substring(0, $startIdx)
    $afterStyle = $content.Substring($endIdx + $styleEnd.Length)

    # Split old CSS into individual rules (by closing braces)
    $rules = $oldStyle -split '(?<=\})'

    # Process rules: keep only page-specific ones
    $pageSpecificCssLines = @()

    foreach ($rule in $rules) {
        $trimmedRule = $rule.Trim()
        if ([string]::IsNullOrEmpty($trimmedRule)) { continue }
        if ($trimmedRule -match '^\s*(/\*|$)') { continue }
        if ($trimmedRule -match '^\s*@media') { continue }
        if ($trimmedRule -match '^\s*\}') { continue }

        if (Test-IsPageSpecificRule -Rule $trimmedRule) {
            $pageSpecificCssLines += $trimmedRule
        }
        elseif (-not (Test-IsBoilerplateRule -Rule $trimmedRule)) {
            # Not page-specific, not boilerplate - might be unknown custom CSS
            # Only keep if it references custom classes with dots
            if ($trimmedRule -match '\.\w') {
                $pageSpecificCssLines += $trimmedRule
            }
        }
    }

    # Build new content
    $newStyleContent = $boilerplate

    if ($pageSpecificCssLines.Count -gt 0) {
        $newStyleContent += "`n`n/* Page-specific styles */`n"
        foreach ($line in $pageSpecificCssLines) {
            $newStyleContent += $line + "`n"
        }
    }

    $newContent = $beforeStyle + $styleStart + "`n" + $newStyleContent + "`n" + $styleEnd + $afterStyle

    Set-Content -Path $filePath -Value $newContent -NoNewline -Encoding UTF8

    $updated += "$($dir.Name) ($($pageSpecificCssLines.Count) page-specific rules preserved)"
    Write-Host "  - Updated: $($pageSpecificCssLines.Count) page-specific rules preserved" -ForegroundColor Green
}

Write-Host "`n============================================" -ForegroundColor Yellow
Write-Host "UPDATE SUMMARY" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "Updated files: $($updated.Count)" -ForegroundColor Green
foreach ($u in $updated) {
    Write-Host "  - $u" -ForegroundColor Green
}
if ($issues.Count -gt 0) {
    Write-Host "`nIssues: $($issues.Count)" -ForegroundColor Red
    foreach ($issue in $issues) {
        Write-Host "  - $issue" -ForegroundColor Red
    }
}
Write-Host "============================================" -ForegroundColor Yellow
