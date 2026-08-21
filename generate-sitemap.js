const fs = require('fs');
const path = require('path');

const BASE_URL = 'https://performalytic.com';
const EXCLUDE_DIRS = ['_case-studies', '_partners', 'assets', 'node_modules', '.git', '.github'];
const EXCLUDE_FILES = ['404.html', 'maintenance.html', 'thank-you.html', 'CNAME', 'sitemap.html'];
const INCLUDE_ROOT_FILES = ['sitemap.html'];

function getLastMod(filePath) {
  const stats = fs.statSync(filePath);
  return stats.mtime.toISOString().split('T')[0];
}

function getPriority(url) {
  if (url === '/') return '1.0';
  if (url.includes('/blog/') || url === '/blog/') return '0.8';
  if (url.includes('/knowledge/') || url === '/knowledge/') return '0.8';
  if (url === '/about/' || url === '/contact/' || url === '/products/') return '0.8';
  if (url.includes('/tools/')) return '0.7';
  if (url === '/sitemap.html') return '0.3';
  if (url.includes('/privacy-policy/') || url.includes('/terms-conditions/') || url.includes('/cookie-policy/')) return '0.3';
  return '0.7';
}

function walk(dir, urls = []) {
  const items = fs.readdirSync(dir);
  for (const item of items) {
    const fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    const relative = path.relative(process.cwd(), fullPath).replace(/\\/g, '/');

    if (stat.isDirectory()) {
      if (!EXCLUDE_DIRS.some(d => relative.startsWith(d + '/') || relative === d)) {
        walk(fullPath, urls);
      }
    } else if (item.endsWith('.html') && !EXCLUDE_FILES.includes(item)) {
      let urlPath = relative
        .replace('/index.html', '')
        .replace('.html', '')
        .replace(/^\.\//, '');

      if (urlPath === '' || urlPath === 'index') urlPath = '/';
      else if (!urlPath.startsWith('/')) urlPath = '/' + urlPath;
      if (!urlPath.endsWith('/')) urlPath += '/';

      urls.push({
        loc: BASE_URL + urlPath,
        lastmod: getLastMod(fullPath),
        priority: getPriority(urlPath)
      });
    }
  }

  // Include specific root-level files
  for (const file of INCLUDE_ROOT_FILES) {
    const fullPath = path.join(dir, file);
    if (fs.existsSync(fullPath)) {
      const urlPath = '/' + file.replace('.html', '') + '/';
      urls.push({
        loc: BASE_URL + urlPath,
        lastmod: getLastMod(fullPath),
        priority: getPriority(urlPath)
      });
    }
  }

  return urls;
}

const urls = walk('.');
urls.sort((a, b) => a.loc.localeCompare(b.loc));

const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(u => `  <url>
    <loc>${u.loc}</loc>
    <lastmod>${u.lastmod}</lastmod>
    <priority>${u.priority}</priority>
  </url>`).join('\n')}
</urlset>`;

fs.writeFileSync('sitemap.xml', xml);
console.log(`Generated sitemap.xml with ${urls.length} URLs`);