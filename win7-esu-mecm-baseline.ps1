# Description: Check the ESU activation status for Windows 7
# By han44 and mseng3
# Script home: https://github.com/engrit-illinois/win7-esu-mecm-baseline
# Last updated 2021-05-19

# There are 3 possible ESU activation IDs for Windows 7 (1 year, 2 year and 3 year)
# https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091
# https://support.illumina.com/support-content/windows10/win7-esu-activation.html

$esuKeys = @(
	[PSCustomObject]@{
		"OS" = "Win7"
		"Year" = 1
		"Id" = "77db037b-95c3-48d7-a3ab-a9c6d41093e0"
		"Expires" = Get-Date "2020-12-31"
	},
	[PSCustomObject]@{
		"OS" = "Win7"
		"Year" = 2
		"Id" = "0e00c25d-8795-4fb7-9572-3803d91b6880"
		"Expires" = Get-Date "2021-12-31"
	},
	[PSCustomObject]@{
		"OS" = "Win7"
		"Year" = 3
		"Id" = "4220f546-f522-46df-8202-4d07afd26454"
		"Expires" = Get-Date "2022-12-31"
		
	<# Keys for Server 2008, kept for reference
	},
	[PSCustomObject]@{
		"OS" = "2008"
		"Year" = 1
		"Id" = "553673ed-6ddf-419c-a153-b760283472fd"
		"Expires" = Get-Date "2020-12-31"
	},
	[PSCustomObject]@{
		"OS" = "2008"
		"Year" = 2
		"Id" = "04fa0286-fa74-401e-bbe9-fbfbb158010d"
		"Expires" = Get-Date "2021-12-31"
	},
	[PSCustomObject]@{
		"OS" = "2008"
		"Year" = 3
		"Id" = "16c08c85-0c8b-4009-9b2b-f1f7319e45f9"
		"Expires" = Get-Date "2022-12-31"
	#>
	
	}
)

# Get SoftwareLicensingProduct WMI class data
# Use the older Get-WmiObject, in case the system doesn't support Get-CimInstance
$slp = Get-CimInstance -ClassName "SoftwareLicensingProduct"
if(-not $slp) {
	$slp = Get-WmiObject -ClassName "SoftwareLicensingProduct"
}

if($slp) {
	# Get array of raw key IDs
	$keys = $slp | Where { $_.PartialProductKey } | Select -ExpandProperty ID

	# Check that at least one of the key IDs is a valid and current key
	$keys | ForEach-Object {
		$thisKey = $_
		$matchingKey = $esuKeys | Where { $_.Id -eq $thisKey }
		if($matchingKey) {
			# System has a matching key
			# Check that it is current
			$date = Get-Date
			if($date -lt $matchingKey.Expires) {
				$valid = $true
			}
		}
	}
}

# If system has at least one valid, current ESU key installed, return "Compliant". Else, return "Non-Compliant"
if($valid) { Write-Host "Compliant" }
else { Write-Host "Non-Compliant" }
