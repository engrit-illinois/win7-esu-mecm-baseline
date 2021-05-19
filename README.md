# Summary
A script to be used as a configuration item for a MECM baseline which detects systems with valid Win7 ESUs

# Usage
Intended for use as the underlying Powershell script in an evaluation condition of a MECM configuration item, to be used as the basis for a MECM baseline.  

Can also just be run manually (locally) on a given endpoint.  

# Behavior
The script looks through the local system's `SoftwareLicensingProduct` WMI class to determine if a valid Win7 Extended Service Update (ESU) key is installed.  

If one or more valid keys are detected, it compares the current date with the expiration date of the key(s), to determine validity.  

If the system is judged to have a valid, current key installed, it returns the string `Compliant`. If not, it returns the string `Non-Compliant`.  

# Sources
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
- https://support.illumina.com/support-content/windows10/win7-esu-activation.html
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/archived-how-to-get-extended-security-updates-for-eligible/ba-p/917807
- https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
- http://eskonr.com/2020/05/use-sccm-compliance-settings-to-detect-the-esu-activation-for-windows-7-and-server-2008/
- https://support.illumina.com/support-content/windows10/win7-esu-activation.html

# Notes
- By han44 and mseng3