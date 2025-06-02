<#
.SYNOPSIS
    Configures the system to remember 24 previous passwords to comply with STIG WN10-AC-000020.

.NOTES
    Author          : Erik Alvarez
    LinkedIn        : linkedin.com/in/cybererik
    GitHub          : github.com/erikalvarez418
    Date Created    : 2025-06-01
    Last Modified   : 2025-06-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 2025-06-01
    Tested By       : 2025-06-01
    Systems Tested  : Windows 10 Pro/Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run as administrator.
    Example:
    PS C:\> .\Remediate-WN10-AC-000020-PasswordHistory.ps1
#>

# Ensure script runs as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    exit
}

# Set password history to 24 passwords
net accounts /uniquepw:24
