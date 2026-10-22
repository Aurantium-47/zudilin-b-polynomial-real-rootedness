param(
  [Parameter(Mandatory = $true)][string]$Toolchain,
  [Parameter(Mandatory = $true)][string]$Packages
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$checks = @(
  @('Zudilin/Basic.lean', 'logs/basic.log'),
  @('Zudilin/BaseCase.lean', 'logs/base-case.log'),
  @('Zudilin/OriginalSum.lean', 'logs/original-sum.log'),
  @('Zudilin.lean', 'logs/main.log'),
  @('AxiomAudit.lean', 'logs/axioms.log')
)
$summary = @("UTC=$([DateTime]::UtcNow.ToString('o'))")
foreach ($check in $checks) {
  & powershell -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot/check.ps1" -File $check[0] -Log $check[1] -Toolchain $Toolchain -Packages $Packages
  $result = $LASTEXITCODE
  $summary += "$($check[0]): exit_code=$result"
  if ($result -ne 0) {
    $summary | Set-Content -LiteralPath (Join-Path $root 'logs/verify-summary.log') -Encoding UTF8
    exit $result
  }
}
$summary | Set-Content -LiteralPath (Join-Path $root 'logs/verify-summary.log') -Encoding UTF8
exit 0
