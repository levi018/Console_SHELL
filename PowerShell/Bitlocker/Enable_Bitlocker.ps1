#Verifique os pré-requisitos do BitLocker
$TPMNotEnabled = Get-WmiObject win32_tpm -Namespace root\cimv2\security\microsofttpm | where {$_.IsEnabled_InitialValue -eq $false} -ErrorAction SilentlyContinue
$TPMEnabled = Get-WmiObject win32_tpm -Namespace root\cimv2\security\microsofttpm | where {$_.IsEnabled_InitialValue -eq $true} -ErrorAction SilentlyContinue
$WindowsVer = Get-WmiObject -Query 'select * from Win32_OperatingSystem where (Version like "6.2%" or Version like "6.3%" or Version like "10.0%") and ProductType = "1"' -ErrorAction SilentlyContinue
$BitLockerReadyDrive = Get-BitLockerVolume -MountPoint $env:SystemDrive -ErrorAction SilentlyContinue
$BitLockerDecrypted = Get-BitLockerVolume -MountPoint $env:SystemDrive | where {$_.VolumeStatus -eq "FullyDecrypted"} -ErrorAction SilentlyContinue
$BLVS = Get-BitLockerVolume | Where-Object {$_.KeyProtector | Where-Object {$_.KeyProtectorType -eq 'RecoveryPassword'}} -ErrorAction SilentlyContinue


#Etapa 1 - Verifique se o TPM está habilitado e inicialize se necessário
if ($WindowsVer -and !$TPMNotEnabled) 
{
Initialize-Tpm -AllowClear -AllowPhysicalPresence -ErrorAction SilentlyContinue
}

#Etapa 2 - Verifique se o volume do BitLocker está provisionado e particione a unidade do sistema para o BitLocker, se necessário
if ($WindowsVer -and $TPMEnabled -and !$BitLockerReadyDrive) 
{
Get-Service -Name defragsvc -ErrorAction SilentlyContinue | Set-Service -Status Running -ErrorAction SilentlyContinue
BdeHdCfg -target $env:SystemDrive shrink -quiet
}

#Etapa 3 - Verifique se os valores do registro de backup da chave do BitLocker AD existem e, se não, crie-os.
$BitLockerRegLoc = 'HKLM:\SOFTWARE\Policies\Microsoft'
if (Test-Path "$BitLockerRegLoc\FVE")
{
  Write-Verbose '$BitLockerRegLoc\FVE Key already exists' -Verbose
}
else
{
  New-Item -Path "$BitLockerRegLoc" -Name 'FVE'
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'ActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'RequireActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'ActiveDirectoryInfoToStore' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'EncryptionMethodNoDiffuser' -Value '00000003' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'EncryptionMethodWithXtsOs' -Value '00000006' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'EncryptionMethodWithXtsFdv' -Value '00000006' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'EncryptionMethodWithXtsRdv' -Value '00000003' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'EncryptionMethod' -Value '00000003' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSRecovery' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSManageDRA' -Value '00000000' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSRecoveryPassword' -Value '00000002' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSRecoveryKey' -Value '00000002' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSHideRecoveryPage' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSActiveDirectoryInfoToStore' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSRequireActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSAllowSecureBootForIntegrity' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'OSEncryptionType' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVRecovery' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVManageDRA' -Value '00000000' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVRecoveryPassword' -Value '00000002' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVRecoveryKey' -Value '00000002' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVHideRecoveryPage' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVActiveDirectoryInfoToStore' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVRequireActiveDirectoryBackup' -Value '00000001' -PropertyType DWORD
  New-ItemProperty -Path "$BitLockerRegLoc\FVE" -Name 'FDVEncryptionType' -Value '00000001' -PropertyType DWORD
}

#Etapa 4 - Se todos os pré-requisitos forem atendidos, habilite o BitLocker
if ($WindowsVer -and $TPMEnabled -and $BitLockerReadyDrive -and $BitLockerDecrypted) 
{
Add-BitLockerKeyProtector -MountPoint $env:SystemDrive -TpmProtector
Enable-BitLocker -MountPoint $env:SystemDrive -RecoveryPasswordProtector -ErrorAction SilentlyContinue
}

#Etapa 5 - Faça backup das senhas de recuperação do BitLocker no AD
if ($BLVS) 
{
ForEach ($BLV in $BLVS) 
{
$Key = $BLV | Select-Object -ExpandProperty KeyProtector | Where-Object {$_.KeyProtectorType -eq 'RecoveryPassword'}
ForEach ($obj in $key)
{ 
Backup-BitLockerKeyProtector -MountPoint $BLV.MountPoint -KeyProtectorID $obj.KeyProtectorId
}
}
}
#$computer = gc env:computername
#Etapa 6 - Faça backup da senha de recuperação do Bitlocker para \\serverXX\Bitlockerkeys
#$BLKS = Get-BitLockerVolume | Where-Object { $_.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' } } -ErrorAction SilentlyContinue
#if ($BLKS) {
#  ForEach ($BLK in $BLKS) {
#    $txtKey = $BLK | Select-Object -ExpandProperty KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
#    ForEach ($txtobj in $txtKey) { 
#      (Get-BitLockerVolume -MountPoint $BLK) | Select-Object -Property MountPoint -ExpandProperty KeyProtector | Format-List > \\karl\Bitlocker.$\$(gc env:computername)_BitLocker_Recovery_Key_$($txtobj.KeyProtectorId.replace('{','').replace('}','')).txt
#    }
#  }
#}
# SIG # Begin signature block
# MIIInQYJKoZIhvcNAQcCoIIIjjCCCIoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUuaMHGnOXQuJa88Svmn3/20Jw
# 7C6gggUzMIIFLzCCAxegAwIBAgIQL8akZvLBKoVATP0kiRge2jANBgkqhkiG9w0B
# AQsFADAfMR0wGwYDVQQDDBRiaXRsb2NrZXJAYWVjLmNvbS5icjAeFw0yMzEyMDYx
# MzIwMDZaFw0zMzEyMDYxMzMwMDVaMB8xHTAbBgNVBAMMFGJpdGxvY2tlckBhZWMu
# Y29tLmJyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAnQdJ6flsOSP1
# a8BT5XaBJVWJnlffdwzz83lpyB5sTGcmyvU/8l2WiPyrrej/4FWDrw7ZRjwoZHIl
# eDz2eo018R0fSn8bIE5mhWpIX5AEj/mTjQwYyOkHiccwlA3rqWkNSwf3+lLp7Kqk
# 5k8xM4WIU/vRVYq30iTgV+/p3EB3PJyfcrkxuZK7W5DU5JiNJL4oV7BVmdzhOjyx
# QX6mc1D9JQxSoETigsBvpnif6XZadHeT6JaQ2aE6gyoZQx9jtpjGNyz2GFsX2INI
# LirvMFEch2GsOoORSMTqpJGPB9q09naPzeuvm2O3vweKnLvrA2fYjgW2lVUaWb2M
# AQm/DujPpPgpJIUvfBls7E4gzMetOCYsvSc2Z8hnWelYJ9ZWlBt+UMi6PYZC5a+o
# 5VMNVh50jW3xNAVfeVR4XlNkRPxisDhpvZMLIFcYUL/wYlrt+nbeIwZ+C0YMybe2
# zUI5laSDU7vibiwWpPG1+c+P/d1x45/V4B667sOpqZfXPaWoTePoD1Fb2rckPiDF
# ykxnap2EbiswRJI7UbzM0ZkIUBLFrw3pY6s1ZaJUgiW2jGmpzNPPtiVJBQdih9aK
# rlAIwqo/K1l4+jtr2h0F5Ts9Sm+VCLRbMvEo9XQ6fr1Kt03GXzCsmgqHpBKhJJoS
# /lqfbOb7tuH/GN+B0I1MPiXFgqVVqHECAwEAAaNnMGUwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB8GA1UdEQQYMBaCFGJpdGxvY2tlckBhZWMu
# Y29tLmJyMB0GA1UdDgQWBBRRgGgKv0wiMhHSSx46wgnbe0D/EjANBgkqhkiG9w0B
# AQsFAAOCAgEAVl5Z9YKd+F+VD2lIQ4F1fIoulcWs3QzjG8o4XY3CbwfcKcsKffl/
# YnhJHB2xV14L2YYVHMi5VKsXxTstpSoYut2So38SPd67nYUHZgDQSbmwGnZ/A4Ur
# uxtFTs1V/XeMRJ8yIszpUoGE/+ZJGMr3lbvB0xYjuISnCTlU3I+mte7geokww/Jj
# Ox2goz3Kc9x/Wq7ZHz+13azJBjIurLgT2PXolc40O1oCARXz/fKC32JL3jQtxDoT
# PUhjysEKTqRv/9ENEEIsuutmud4zr04hvR46LlSUfq3T55LOyIvN14Uow9oeIXb7
# HiRhdZfMtUU8abodCIxACRJsAq74TniQqDXY4gYT6yc1ZgThAbMKz1LvlCiT/wpG
# 9yRqqi6L1BNbcF7aKUKaWd16dZCYLBcaU4V5doX7O+Zni9JUqzCZFloRu4OgGXmV
# y/x7/+UaXJevDzY36DAzBDmN+dO+LZ99VZJYC2NfsmTb/YWxSxfX0XJJ/X3OzKp3
# xmcg1FcZ4zdnPA/K6KrYksDhUdO2+TdShF3HgR1qH0BM4dEHeeJbr4AElpsY77lu
# OAS8+775LC6uJQwyCQz9YfoMi+jLAyJBOmX5fNhihCBOYDSaOCuOAxy76ddvDK3A
# m7X8M//zbNYgIEtJgclxSc/VukVdCWcRBnNoxXNUCQyUhdkARng5wjIxggLUMIIC
# 0AIBATAzMB8xHTAbBgNVBAMMFGJpdGxvY2tlckBhZWMuY29tLmJyAhAvxqRm8sEq
# hUBM/SSJGB7aMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAA
# MBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgor
# BgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBR6FVmAGQcn1ZLl2OED1oGvJ8C0ezAN
# BgkqhkiG9w0BAQEFAASCAgCI4huTJvr9Q8EOjIK8yn6I98eX//WK3TRpd+Dwg+2J
# rZen64yK4qgrn88E4AGJ9H6QrkZ41XVC6B83DYpNH8fQiJ0ln5EEfp7FnUzzIsfK
# 3QtIkziw9dcRvM7C7s60Pu+HPn6p6jlnEtkHnusxkpSMirJi/hKOdvktj0Cv2wsL
# coiUyvLP0IB/N72O+rniTKUuKCl3Yk0g3zYW0OkvqryVyoepkdMFzOTlsjoAwh5j
# gFtWB24Xxg4r25cbq02OEf1F1+fmMLr4XwlVYDOaCTV4wA49D8Eg8rSZVALiU+Fo
# LK1s8uqhSUdq8prdKgdGXnE+9QikIzSrAMx73NgpAEu4e6YlkVGU15NmRmaNt1Sa
# 48ss0NfwxApUXREhS06v7jEdhJ4435bW2bHgg4/u1gT3deZJ6xb3p53UbG1jonzh
# cKKjyCdHkbIhcJR0uZeXfO8b/eyVAkK+uCzCM3hN3RZnz0ABLcZAZ72cZ/RxASkT
# x1vEVLkRgIockkNTeveTPXmK/eFNoMZpKd6XF2nfGAj+nmNZoWcXJ9aIXykAr9Al
# WdaIyvTS+38VsF5ccW83Y9rV5wmyrA6JfXrCgcpnt9LBfF8ilCKyIdJLNd49Kjhl
# Ef+vb7RXTRY7b93nuzoqrGja8ljhm7u9cHYOfZRJL3tJ+ewhkpdBticAG1OaZm1l
# aA==
# SIG # End signature block
