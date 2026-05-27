# extract_fn.ps1 - Extract a named function from lanlok.asm
#
# Usage:
#   .\tools\extract_fn.ps1 -FunctionName FUN_01a2_3c57
#   .\tools\extract_fn.ps1 -Address 3c57     (finds function containing 01a2:3c57)
#   .\tools\extract_fn.ps1 -FunctionName ENTRY
#
# Output: the complete function body from lanlok.asm, printed to stdout.
# Pipe to 'more' for paging:
#   .\tools\extract_fn.ps1 -FunctionName FUN_01a2_2e2d | more

param(
    [string]$FunctionName = "",
    [string]$Address      = ""
)

$asmFile = Join-Path $PSScriptRoot "..\lanlok.asm"

if (-not (Test-Path $asmFile)) {
    Write-Error "Cannot find lanlok.asm"
    exit 1
}

$asmLines = Get-Content $asmFile
$total    = $asmLines.Count

# Pattern matching a function header line
$fnHeaderPat = [regex]'^\s+(undefined\s+(FUN_01a2_\w+|__cdecl16near\s+FUN_01a2_\w+)|ENTRY)\s*$|^\s+undefined\s+FUN_01a2_\w+\(\)'

# Build an index of all function start lines: FunctionName -> lineIndex
$fnStarts = [System.Collections.Generic.List[hashtable]]::new()

for ($i = 0; $i -lt $total; $i++) {
    $line = $asmLines[$i]
    # Match lines like:
    #   "                             undefined FUN_01a2_XXXX()"
    #   "                             undefined __cdecl16near FUN_01a2_XXXX()"
    #   "                             ENTRY"
    if ($line -match '^\s+undefined\s+(?:__cdecl16near\s+)?(FUN_01a2_\w+)\(\)') {
        $fnStarts.Add(@{ Name = $Matches[1]; Line = $i })
    }
    elseif ($line -match '^\s+undefined\s+ENTRY\(\)') {
        $fnStarts.Add(@{ Name = "ENTRY"; Line = $i })
    }
    elseif ($line -match '^                             ENTRY\s*$') {
        # Sometimes ENTRY appears alone as label
        $fnStarts.Add(@{ Name = "ENTRY"; Line = $i })
    }
}

# If -Address given, find which function contains that address
if ($Address -ne "" -and $FunctionName -eq "") {
    $addr = $Address.ToLower().PadLeft(4, '0')
    $exactFn = "FUN_01a2_$addr"

    # Check if it's an exact function address first
    $matchExact = $fnStarts | Where-Object { $_.Name -eq $exactFn }
    if ($matchExact) {
        $FunctionName = $exactFn
    } else {
        # Find which function contains this address
        # The address appears in the code as "01a2:XXXX" on code lines
        $addrPat = "01a2:$addr"

        # Scan ASM for the address to find its line
        $addrLineNum = -1
        for ($i = 0; $i -lt $total; $i++) {
            if ($asmLines[$i] -match [regex]::Escape("01a2:$addr")) {
                $addrLineNum = $i
                break
            }
        }

        if ($addrLineNum -lt 0) {
            Write-Error "Address 01a2:$addr not found in lanlok.asm"
            exit 1
        }

        # Find the function whose start is closest to (and before) addrLineNum
        $best = $null
        foreach ($fn in $fnStarts) {
            if ($fn.Line -le $addrLineNum) {
                if ($null -eq $best -or $fn.Line -gt $best.Line) {
                    $best = $fn
                }
            }
        }

        if ($null -eq $best) {
            Write-Error "Could not determine which function contains 01a2:$addr"
            exit 1
        }

        $FunctionName = $best.Name
        Write-Host ("Address 01a2:$addr is inside $FunctionName") -ForegroundColor Yellow
    }
}

if ($FunctionName -eq "") {
    Write-Error "Specify -FunctionName or -Address"
    exit 1
}

# Find the function start line
$startEntry = $fnStarts | Where-Object { $_.Name -eq $FunctionName } | Select-Object -First 1

if ($null -eq $startEntry) {
    Write-Error "Function '$FunctionName' not found in lanlok.asm"
    Write-Host "Known functions:" -ForegroundColor Yellow
    $fnStarts | ForEach-Object { Write-Host ("  " + $_.Name) }
    exit 1
}

$startLine = $startEntry.Line

# Find next function start (= end of this function)
$nextFn = $fnStarts | Where-Object { $_.Line -gt $startLine } | Sort-Object { $_.Line } | Select-Object -First 1

$endLine = if ($null -ne $nextFn) { $nextFn.Line - 1 } else { $total - 1 }

Write-Host ("--- Extracting $FunctionName (lanlok.asm lines " + ($startLine+1) + "-" + ($endLine+1) + ") ---") -ForegroundColor Cyan
Write-Host ""

for ($i = $startLine; $i -le $endLine; $i++) {
    Write-Host $asmLines[$i]
}

Write-Host ""
Write-Host ("--- End of $FunctionName (" + ($endLine - $startLine + 1) + " lines) ---") -ForegroundColor Cyan
