<#
.SYNOPSIS
    Disables elevation requests for standard users via UAC by setting ConsentPromptBehaviorUser to 0.

.NOTES
    Author          : Erik Alvarez
    LinkedIn        : linkedin.com/in/cybererik
    GitHub          : github.com/erikalvarez418
    Date Created    : 2025-06-01
    Last Modified   : 2025-06-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 2025-06-01
    Tested By       : 2025-06-01
    Systems Tested  : Windows 10 Pro/Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run as administrator.
    Example:
    PS C:\> .\Remediate-WN10-SO-000255-DenyElevationStandardUsers.ps1
#>

# Ensure the script is running with administrator rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    exit
}

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "ConsentPromptBehaviorUser"
$desiredValue = 0

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set or update the registry value
$currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    New-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -PropertyType DWord -Force
} else {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue
}
