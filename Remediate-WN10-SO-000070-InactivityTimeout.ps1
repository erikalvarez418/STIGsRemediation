<#
.SYNOPSIS
    Ensures the machine inactivity timeout is set to 15 minutes (900 seconds) per STIG WN10-SO-000070.

.NOTES
    Author          : Erik Alvarez
    LinkedIn        : linkedin.com/in/cybererik
    GitHub          : github.com/erikalvarez418
    Date Created    : 2025-06-01
    Last Modified   : 2025-06-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 2025-06-01
    Tested By       : Erik Alvarez
    Systems Tested  : Windows 10 Pro/Enterprise
    PowerShell Ver. : 5.1+

    
#>

# Ensure script runs as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script. Please re-run as Administrator."
    exit
}

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "InactivityTimeoutSecs"
$desiredValue = 900

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the inactivity timeout to 900 seconds (15 minutes)
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

Write-Output "Machine inactivity timeout set to $desiredValue seconds (15 minutes)."
