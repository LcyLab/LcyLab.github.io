$ErrorActionPreference = 'Stop'

$publicRoot = Join-Path (Get-Location) 'public'
$siteHomeHtmlPath = Join-Path $publicRoot 'index.html'

function Assert-PathExists([string] $path) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Missing generated file: $path"
    }
}

function Assert-Contains([string] $content, [string] $needle, [string] $label) {
    if (-not $content.Contains($needle)) {
        throw "Page is missing ${label}: $needle"
    }
}

Assert-PathExists $siteHomeHtmlPath
foreach ($relativePath in @(
        'search.xml',
        'notes/index.html',
        'archives/index.html',
        'categories/index.html',
        'tags/index.html',
        'projects/index.html')) {
    Assert-PathExists (Join-Path $publicRoot $relativePath)
}

$siteHomeHtml = Get-Content -Raw -Encoding UTF8 $siteHomeHtmlPath
Assert-Contains $siteHomeHtml 'site-stats' 'site overview widget'
Assert-Contains $siteHomeHtml 'href="/notes"' 'learning notes navigation'
Assert-Contains $siteHomeHtml 'busuanzi_value_site_pv' 'site pageview counter'
Assert-Contains $siteHomeHtml 'busuanzi_value_site_uv' 'site visitor counter'
Assert-Contains $siteHomeHtml 'cdn.busuanzi.cc/busuanzi/3.6.9/busuanzi.min.js' 'official Busuanzi script'
Assert-Contains $siteHomeHtml 'lcy-busuanzi-bridge' 'domain-aware counter bridge'
Assert-Contains $siteHomeHtml 'searchModal' 'search dialog'

if ($siteHomeHtml.Contains('xxxxxxxxxx')) {
    throw 'Tencent captcha placeholder appid is still present'
}
if ($siteHomeHtml.Contains('reward/alipay') -or $siteHomeHtml.Contains('reward/wechat')) {
    throw 'Default reward image reference is still present'
}

$postHtmlPath = Get-ChildItem -LiteralPath $publicRoot -Filter '*.html' -Recurse |
    Where-Object { $_.FullName -match '[\\/]2026[\\/].*[\\/]index\.html$' } |
    Select-Object -First 1 -ExpandProperty FullName
if (-not $postHtmlPath) {
    throw 'No dated article HTML page was found for validation'
}

$postHtml = Get-Content -Raw -Encoding UTF8 $postHtmlPath
Assert-Contains $postHtml 'busuanzi_value_page_pv' 'article pageview counter'
Assert-Contains $postHtml 'fa-file-word' 'article word count'
Assert-Contains $postHtml 'fa-clock' 'article reading time'
Assert-Contains $postHtml 'fa-calendar-check' 'article update date'

Write-Output "Site feature checks passed: $postHtmlPath"
