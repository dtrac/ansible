$ErrorActionPreference = "Stop"

# Get WSUS Server Object
$wsus = Get-WSUSServer

# Connect to WSUS server configuration
$wsusConfig = $wsus.GetConfiguration()

# Set to download updates from Microsoft Updates
Set-WsusServerSynchronization –SyncFromMU

# Set Update Languages to English and save configuration settings
$wsusConfig.AllUpdateLanguagesEnabled = $false
$wsusConfig.SetEnabledUpdateLanguages("en")
$wsusConfig.Save()

# Configure the Platforms that we want WSUS to receive updates
write-host 'Setting WSUS Products'
Get-WsusProduct | where-Object {
    $_.Product.Title -in (
    'Windows Server 2008 R2',
    'Windows Server 2012 R2',
    'Windows Server 2016')
} | Set-WsusProduct

# Configure the Classifications
write-host 'Setting WSUS Classifications'
Get-WsusClassification | Where-Object {
    $_.Classification.Title -in (
    'Critical Updates',
    'Security Updates')
} | Set-WsusClassification

# Configure Synchronizations
write-host 'Enabling WSUS Automatic Synchronisation'
$subscription.SynchronizeAutomatically=$true

# Set synchronization scheduled for midnight each night
$subscription.SynchronizeAutomaticallyTimeOfDay= (New-TimeSpan -Hours 0)
$subscription.NumberOfSynchronizationsPerDay=1
$subscription.Save()

# Kick off a synchronization
$subscription.StartSynchronization()

# Configure Default Approval Rule
write-host 'Configuring default automatic approval rule'
[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$rule = $wsus.GetInstallApprovalRules() | Where {$_.Name -eq "Default Automatic Approval Rule"}
$class = $wsus.GetUpdateClassifications() | ? {$_.Title -In (
    'Critical Updates',
    'Security Updates')
}
$class_coll = New-Object Microsoft.UpdateServices.Administration.UpdateClassificationCollection
$class_coll.AddRange($class)
$rule.SetUpdateClassifications($class_coll)
$rule.Enabled = $True
$rule.Save()

# Run Default Approval Rule
write-host 'Running Default Approval Rule'
write-host ' >This step may timeout, but the rule will be applied and the script will continue' -ForegroundColor Yellow
try {
    $Apply = $rule.ApplyRule()
}
catch {
    write-warning $_
}

write-host 'WSUS log files can be found here: %ProgramFiles%\Update Services\LogFiles'