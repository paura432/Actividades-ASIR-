#añadir unidades organizativas
New-ADOrganizationalUnit -Name PracticaPWS -Path “DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name departamentos -Path “OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name recepcion -Path “OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name administracion -Path "OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name gerencia -Path “OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name sistemas -Path “OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
#añadir grupos
new-adgroup -name "gruporecepcion" -path “OU=grupos,OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
new-adgroup -name "grupoadministracion" -path “OU=grupos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global 
new-adgroup -name "grupogerencia" -path “OU=grupos,OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
new-adgroup -name "gruposistemas" -path “OU=grupos,OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
#Enter a path to your import CSV file
#añadir las caracteristicas ha los usuarios
$ADUsers = Import-csv C:\scripts\users.csv
foreach ($User in $ADUsers)`
{
 $Username = $User.NOMBRETRABAJADOR
 $Password = $User.CONTRASENA
 $Firstname = $User.NOMBRE
 $Lastname = $User.APELLIDOS
 $Mail = $User.mail
 $Department = $User.DEPARTAMENTO
 $OU = $User.ou
 $cambiariniciosesion = $User.CAMBIARSESIÓN
 $archivoinicio = $User.INICIOSESION
 #Check if the user account already exists in AD
 if (Get-ADUser -F {SamAccountName -eq $Username})
 {
 #If user does exist, output a warning message
 Write-Warning "A user account $Username has already exist in Active Directory."
 }
 else
 {
 #If a user does not exist then create a new user account
 #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forgetto change the domain name in the"-UserPrincipalName" variable
 New-ADUser `
 -SamAccountName $Username `
 -UserPrincipalName $Username `
 -Name "$Firstname $Lastname" `
 -Email $Mail `
 -GivenName $Firstname `
 -Surname $Lastname `
 -Enabled $True `
 -ChangePasswordAtLogon $cambiariniciosesion `
 -DisplayName "$Lastname, $Firstname" `
 -Department $Department `
 -Path $OU `
 -Scriptpath $archivoinicio `
 -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
 }
}
#añadir los usuarios ha los equipos
add-adgroupmember -identity gruporecepcion -members Alvaro.A.R
add-adgroupmember -identity grupogerencia -members Carlos.G.S
add-adgroupmember -identity grupoadministracion -members Eduardo.S.R,Maria.P.D,Sebastian.Z.M
add-adgroupmember -identity gruposistemas -members Pau.S.R
#crear equipos
New-ADComputer -Name "EQUIPOREC01" -SamAccountName "Alvaro" -Path “OU=equipos,OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOER01" -SamAccountName "Carlos" -Path “OU=equipos,OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM01" -SamAccountName "Eduardo" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM02" -SamAccountName "María" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM03" -SamAccountName "Sebastian" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOSIS01" -SamAccountName "Pau" -Path “OU=equipos,OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
#crear carpetas disco :E
remove-item -Path "E:\PracticaPWS" -recurse -confirm:$false

New-Item E:\PracticaPWS -Type directory
New-Item E:\PracticaPWS\administracion -Type directory
New-Item E:\PracticaPWS\general -Type directory
New-Item E:\PracticaPWS\recepcion -Type directory
New-Item E:\PracticaPWS\sistemas -Type directory
New-Item E:\PracticaPWS\general\privada_Sebastian.Z.M -Type directory
New-Item E:\PracticaPWS\general\privada_Alvaro.A.R -Type directory
New-Item E:\PracticaPWS\general\privada_Carlos.G.S -Type directory
New-Item E:\PracticaPWS\general\privada_Eduardo.S.R -Type directory
New-Item E:\PracticaPWS\general\privada_Maria.P.D -Type directory
New-Item E:\PracticaPWS\general\publica -Type directory
#compartir las carpetas de e:
Remove-smbShare -Name "PracticaPWS" -confirm:$false
New-smbshare -Name "PracticaPWS" -Path "E:\PracticaPWS" 
#comando permisos carpetas
icacls E:\PracticaPWS\recepcion /grant "Alvaro.A.R:(OI)(CI)(M)"
icacls E:\PracticaPWS\general\privada_Alvaro.A.R /grant "Alvaro.A.R:(OI)(CI)(M)"
icacls E:\PracticaPWS\general\privada_Eduardo.S.R /grant "Eduardo.S.R:(OI)(CI)(M)"
icacls E:\PracticaPWS\administracion /grant "grupoadministracion:(OI)(CI)(M)" 
icacls E:\PracticaPWS\general\privada_Maria.P.D /grant "Maria.P.D:(OI)(CI)(M)" 
icacls E:\PracticaPWS\general\privada_Sebastian.Z.M /grant "Sebastian.Z.M:(OI)(CI)(M)"
icacls E:\PracticaPWS\general\privada_Carlos.G.S /grant "Carlos.G.S:(OI)(CI)(M)"  
icacls E:\PracticaPWS\general\publica /grant "grupoadministracion:(OI)(CI)(M)" /grant "gruporecepcion:(OI)(CI)(M)"
icacls E:\PracticaPWS /grant "Pau.S.R:(OI)(CI)(F)" /grant "Carlos.G.S:(OI)(CI)(M)"   
icacls E:\PracticaPWS\sistemas /grant "Pau.S.R:(OI)(CI)(M)" /grant "Carlos.G.S:(D)"            