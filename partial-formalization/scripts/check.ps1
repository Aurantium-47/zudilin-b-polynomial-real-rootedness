param(
  [string]$File = 'Zudilin/Basic.lean',
  [string]$Log = 'logs/compile.log',
  [Parameter(Mandatory = $true)][string]$Toolchain,
  [Parameter(Mandatory = $true)][string]$Packages
)
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$root = Split-Path $PSScriptRoot -Parent
$oldLeanPath = $env:LEAN_PATH
try {
  $libs = @(Get-ChildItem -LiteralPath $packages -Directory | ForEach-Object {
    $candidate = Join-Path $_.FullName '.lake\build\lib\lean'
    if (Test-Path -LiteralPath $candidate) { $candidate }
  })
  $env:LEAN_PATH = (@($root) + $libs) -join ';'
  Push-Location $root
  try {
    New-Item -ItemType Directory -Force (Join-Path $root 'logs') | Out-Null
    $olean = [System.IO.Path]::ChangeExtension($File, '.olean')
    & "$toolchain\bin\lean.exe" -j 1 -s 131072 '-DElab.async=false' -o $olean $File 2>&1 | Tee-Object -Variable buildOutput
    $result = $LASTEXITCODE
    (@($buildOutput) + @("exit_code=$result")) | Set-Content -LiteralPath (Join-Path $root $Log) -Encoding UTF8
  } finally { Pop-Location }
} finally { $env:LEAN_PATH = $oldLeanPath }
exit $result

