<#
.SYNOPSIS
    Rimuove ricorsivamente i file temporanei generati da LaTeX.

.DESCRIPTION
    Scansiona la cartella indicata (di default quella dello script) e tutte
    le sottocartelle, eliminando i file ausiliari di LaTeX (.aux, .log, .toc,
    .synctex.gz, .fdb_latexmk, ...). La cartella .git viene ignorata.
    I PDF vengono rimossi solo se si passa -IncludePdf.

.PARAMETER Path
    Cartella da cui partire. Default: la cartella in cui si trova lo script.

.PARAMETER IncludePdf
    Elimina anche i file .pdf.

.EXAMPLE
    .\clean.ps1                 # pulisce i file temporanei LaTeX
    .\clean.ps1 -IncludePdf     # ... e anche i PDF
    .\clean.ps1 -WhatIf         # mostra cosa verrebbe eliminato, senza eliminare
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Path = $PSScriptRoot,
    [switch]$IncludePdf
)

$patterns = @(
    '*.aux', '*.lof', '*.log', '*.lot', '*.fls', '*.out', '*.toc', '*.fmt', '*.fot',
    '*.cb', '*.cb2', '*.lb', '*.bbl', '*.bcf', '*.blg', '*-blx.bib', '*.run.xml',
    '*.fdb_latexmk', '*.synctex', '*.synctex(busy)', '*.synctex.gz', '*.synctex.gz(busy)',
    '*.pdfsync', '*.xdv', '*.dvi', '*.nav', '*.snm', '*.vrb',
    '*.idx', '*.ilg', '*.ind', '*.glo', '*.gls', '*.glg', '*.acn', '*.acr', '*.alg', '*.ist',
    '*.loa', '*.lol', '*.xdy', '*.maf', '*.mtc*', '*.thm', '*.brf', '*.auxlock',
    '*.listing', '*.pyg', '*.figlist', '*.makefile', '*.nlo', '*.nls', '*.nlg',
    '*.tdo', '*.upa', '*.upb', '*.bak', '*.sav', '*.tmp', '*~'
)
if ($IncludePdf) { $patterns += '*.pdf' }

$gitDir = Join-Path $Path '.git'

$files = Get-ChildItem -Path $Path -Recurse -File -Force -Include $patterns -ErrorAction SilentlyContinue |
    Where-Object { -not $_.FullName.StartsWith($gitDir, [System.StringComparison]::OrdinalIgnoreCase) }

# Cartelle generate da minted
$dirs = Get-ChildItem -Path $Path -Recurse -Directory -Force -Filter '_minted*' -ErrorAction SilentlyContinue |
    Where-Object { -not $_.FullName.StartsWith($gitDir, [System.StringComparison]::OrdinalIgnoreCase) }

$count = 0
foreach ($f in $files) {
    if ($PSCmdlet.ShouldProcess($f.FullName, 'Remove')) {
        Remove-Item -LiteralPath $f.FullName -Force
        $count++
    }
}
foreach ($d in $dirs) {
    if ($PSCmdlet.ShouldProcess($d.FullName, 'Remove directory')) {
        Remove-Item -LiteralPath $d.FullName -Recurse -Force
        $count++
    }
}

Write-Host "Pulizia completata: $count elementi rimossi."
