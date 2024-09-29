New-ADOrganizationalUnit -Name PracticaPWS -Path "DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
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
new-adgroup -name "gruporecepcion" -path “OU=grupos,OU=recepcion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
new-adgroup -name "grupoadministracion" -path “OU=grupos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global 
new-adgroup -name "grupogerencia" -path “OU=grupos,OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
new-adgroup -name "gruposistemas" -path “OU=grupos,OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” -GroupScope Global
add-groupmember -identity gruporecepcion -members 
#Enter a path to your import CSV file
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
New-ADComputer -Name "EQUIPOREC01" -SamAccountName "Alvaro" -Path “OU=equipos,OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOER01" -SamAccountName "Carlos" -Path “OU=equipos,OU=gerencia,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM01" -SamAccountName "Eduardo" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM02" -SamAccountName "María" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOADM03" -SamAccountName "Sebastian" -Path “OU=equipos,OU=administracion,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
New-ADComputer -Name "EQUIPOSIS01" -SamAccountName "Pau" -Path “OU=equipos,OU=sistemas,OU=departamentos,OU=PracticaPWS,DC=PAU,DC=LOCAL” 
icacls E:\PracticaPWS\recepcion /grant "Alvaro.A.R:(OI)(CI)(M)"
icacls E:\PracticaPWS\administracion /grant "Eduardo.S.R:(OI)(CI)(M)" /grant "Maria.P.D:(OI)(CI)(M)" /grant "Sebastian.Z.M:(OI)(CI)(M)"
icacls E:\PracticaPWS\publica /grant "Alvaro.A.R:(OI)(CI)(R)" /grant "Eduardo.S.R:(OI)(CI)(R)" /grant "Maria.P.D:(OI)(CI)(R)" /grant "Sebastian.Z.M:(OI)(CI)(R)"
icacls E:\Pr                                                                        