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
Assert-Contains $siteHomeHtml 'hexo-theme-redefine' 'Redefine theme'
Assert-Contains $siteHomeHtml 'redefine-favicon.svg' 'Redefine favicon'
Assert-Contains $siteHomeHtml 'href="/notes/"' 'learning notes navigation'
Assert-Contains $siteHomeHtml 'busuanzi_value_site_pv' 'site pageview counter'
Assert-Contains $siteHomeHtml 'busuanzi_value_site_uv' 'site visitor counter'
Assert-Contains $siteHomeHtml 'cn.vercount.one/js' 'Vercount counter script'
Assert-Contains $siteHomeHtml 'search-input' 'search input'

if ($siteHomeHtml.Contains('xxxxxxxxxx')) {
    throw 'Tencent captcha placeholder appid is still present'
}
if ($siteHomeHtml.Contains('reward/alipay') -or $siteHomeHtml.Contains('reward/wechat')) {
    throw 'Default reward image reference is still present'
}

$postHtmlPath = Get-ChildItem -LiteralPath $publicRoot -Filter 'index.html' -Recurse |
    ForEach-Object {
        $candidate = Get-Content -Raw -Encoding UTF8 $_.FullName
        if ($candidate.Contains('article-wordcount') -and
            $candidate.Contains('mjx-container') -and
            $candidate.Contains('picture/')) {
            $_.FullName
        }
    } |
    Select-Object -First 1
if (-not $postHtmlPath) {
    throw 'No MathJax article with local picture assets was found for validation'
}

$postHtml = Get-Content -Raw -Encoding UTF8 $postHtmlPath
Assert-Contains $postHtml 'busuanzi_value_page_pv' 'article pageview counter'
Assert-Contains $postHtml 'article-wordcount' 'article word count'
Assert-Contains $postHtml 'article-min2read' 'article reading time'
Assert-Contains $postHtml 'article-pv' 'article pageview metadata'
Assert-Contains $postHtml 'mjx-container' 'rendered MathJax formula'
Assert-Contains $postHtml 'picture/' 'article picture assets'

if ($postHtml.Contains('Undefined control sequence')) {
    throw 'Generated article contains an invalid MathJax control sequence'
}
if ($postHtml.Contains('Unknown environment')) {
    throw 'Generated article contains an unsupported MathJax environment'
}
if ($postHtml.Contains('$$')) {
    throw 'Generated article contains raw MathJax delimiters'
}

Write-Output "Site feature checks passed: $postHtmlPath"
