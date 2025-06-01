<#
.SYNOPSIS
    This PowerShell script ensures that account lockout policies meet STIG compliance:
        - Lockout Duration: ≥ 15 minutes
        - Lockout Threshold: ≤ 3 attempts
        - Lockout Observation Window: ≥ 15 minutes

.NOTES
    Author          : Erik Alvarez
    LinkedIn        : linkedin.com/in/cybererik
    GitHub          : github.com/erikalvarez418
    Date Created    : 2025-06-01
    Last Modified   : 2025-06-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005, WN10-AC-000010, WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 2025-06-01
    Tested By       : Erik Alvarez
    Systems Tested  : Windows 10 Pro/Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run as administrator.
    Example:
    PS C:\> .\Remediate-AccountLockout-STIGs.ps1
#>

# Ensure script runs as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script. Please re-run as Administrator."
    exit
}

Write-Output "Checking and remediating account lockout policies..."

# Enforce compliant lockout policy settings
try {
    net accounts /lockoutthreshold:3
    net accounts /lockoutduration:15
    net accounts /lockoutwindow:15

    Write-Output "`Account lockout policy remediated successfully:"
    net accounts | Select-String "Lockout"

} catch {
    Write-Error " Failed to apply account lockout policy settings: $_"
}
