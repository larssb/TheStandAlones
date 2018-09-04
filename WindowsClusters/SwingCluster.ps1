# By Lars S. Bengtsson | https://github.com/larssb
<#
    - PREP.
#>
Import-module FailoverClusters

# Variables used througout
$ClusterService_DTC = "PWDTC003DSA"
$ClusterService_SQL = "SQL Server (SCDLI)"
$LogPath = "$([System.Environment]::ExpandEnvironmentVariables("%SystemDrive%"))\Temp\SwingClusterScript_$(Get-Date -Format yyMMddHHmm).log"

# Get info
$ClusterGroupInfo_DTC = Get-ClusterGroup | Where-Object { $_.Name -eq $ClusterService_DTC }
$ClusterGroupInfo_SQLSrv = Get-ClusterGroup | Where-Object { $_.Name -eq $ClusterService_SQL }

<# 
    - Determine the cluster node to "swing" to
#>
# Get the available cluster nodes
$ClusterNodes = (Get-ClusterNode).Name

#### DTC
$CurrentOwner_DTC = $ClusterGroupInfo_DTC.OwnerNode.Name
$NewOwner_DTC = $ClusterNodes -notmatch $CurrentOwner_DTC

#### SQL - SCDLI
$CurrentOwner_SQL = $ClusterGroupInfo_SQLSrv.OwnerNode.Name
$NewOwner_SQL = $ClusterNodes -notmatch $CurrentOwner_SQL

<#
    - Swing the cluster services
#>
#### DTC
try {
    Move-ClusterGroup –Name $ClusterService_DTC -Node $NewOwner_DTC[0].ToString() -Wait 0 -ErrorAction Stop
} catch {
    Out-File -FilePath $LogPath -Append -Encoding utf8 -InputObject "Swinging the cluster group named $ClusterService_DTC, failed with > $_"
}

#### SQL - SCDLI
try {
    Move-ClusterGroup –Name $ClusterService_SQL -Node $NewOwner_SQL[0].ToString() -Wait 0 -ErrorAction Stop
} catch {
    Out-File -FilePath $LogPath -Append -Encoding utf8 -InputObject "Swinging the cluster group named $ClusterService_SQL, failed with > $_"
}