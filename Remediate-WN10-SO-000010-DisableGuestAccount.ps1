<#
.SYNOPSIS
    This PowerShell script disables the built-in Guest account to comply with STIG ID WN10-SO-000010.

.NOTES
    Author          : Erik Alvarez
    LinkedIn        : linkedin.com/in/cybererik
    GitHub          : github.com/erikalvarez418
    Date Created    : 2025-06-01
    Last Modified   : 2025-06-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Windows 10 Pro/Enterprise
    PowerShell Ver. : 5.1+

.USAGE
    Run as administrator.
    Example:
    PS C:\> .\Remediate-WN10-SO-000010-DisableGuestAccount.ps1
#>

# Ensure script runs as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    exit
}

# Check if Guest account exists and disable if enabled
try {
    $guestAccount = Get-LocalUser -Name "Guest" -ErrorAction Stop
    if ($guestAccount.Enabled) {
        Disable-LocalUser -Name "Guest"
    }
} catch {
    # Do nothing if Guest account is not found
}
