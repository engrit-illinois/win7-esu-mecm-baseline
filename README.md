# Summary
A script to be used as a configuration item for a MECM baseline which detects systems with valid Win7 ESUs

# Usage
Intended for use as the underlying Powershell script in an evaluation condition of a MECM configuration item, to be used as the basis for a MECM baseline.  

Can also just be run manually (locally) on a given endpoint.  

# Behavior
The script looks through the local system's `SoftwareLicensingProduct` WMI class to determine if a valid Win7 Extended Service Update (ESU) key is installed.  

If one or more valid keys are detected, it compares the current date with the expiration date of the key(s), to determine validity.  

If the system is judged to have a valid, current key installed, it returns the string `Compliant`. If not, it returns the string `Non-Compliant`.  

# Quick manual use
1. On the local system, run: `Get-CimInstance -ClassName "SoftwareLicensingProduct" | Where { $_.PartialProductKey } | Select -ExpandProperty ID`
2. If one of the keys returned is a valid, current ESU key, then the system is compliant.

Quick reference of valid Win7 ESU keys ([source]()):
- Year 1 (through end of 2020): `77db037b-95c3-48d7-a3ab-a9c6d41093e0`
- Year 2 (through end of 2021): `0e00c25d-8795-4fb7-9572-3803d91b6880`
- Year 3 (through end of 2022): `4220f546-f522-46df-8202-4d07afd26454`

# Sources
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/archived-how-to-get-extended-security-updates-for-eligible/ba-p/917807
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
- https://support.illumina.com/support-content/windows10/win7-esu-activation.html
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
- http://eskonr.com/2020/05/use-sccm-compliance-settings-to-detect-the-esu-activation-for-windows-7-and-server-2008/
- https://support.illumina.com/support-content/windows10/win7-esu-activation.html

# Notes
- By han44 and mseng3