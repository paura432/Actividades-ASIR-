﻿#CREACION DE LAS UNIDADES ORGANIZATIVAS 
$dominio="DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "PWSDia24" -name "PWSDia24" -ProtectedFromAccidentalDeletion $False -Path $dominio
$dominio1="OU=PWSDia24,DC=carlos,DC=local"
New-ADOrganizationalUnit -DisplayName "Departamento" -name "Departamento" -ProtectedFromAccidentalDeletion $False -Path $dominio1
$dominio2="OU=Departamento,OU=PWSDia24,DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "Contabilidad" -name "Contabilidad" -ProtectedFromAccidentalDeletion $False -Path $dominio2
New-ADOrganizationalUnit -DisplayName "Ventas" -name "Ventas" -ProtectedFromAccidentalDeletion $False -Path $dominio2
New-ADOrganizationalUnit -DisplayName "Sistemas" -name "Sistemas" -ProtectedFromAccidentalDeletion $False -Path $dominio2
New-ADOrganizationalUnit -DisplayName "Gerencia" -name "Gerencia" -ProtectedFromAccidentalDeletion $False -Path $dominio2
$dominio3="OU=Contabilidad,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "Users" -name "Users" -ProtectedFromAccidentalDeletion $False -Path $dominio3
New-ADOrganizationalUnit -DisplayName "Groups" -name "Groups" -ProtectedFromAccidentalDeletion $False -Path $dominio3
New-ADOrganizationalUnit -DisplayName "Computers" -name "Computers" -ProtectedFromAccidentalDeletion $False  -Path $dominio3
$dominio4="OU=Ventas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "Users" -name "Users" -ProtectedFromAccidentalDeletion $False -Path $dominio4
New-ADOrganizationalUnit -DisplayName "Groups" -name "Groups"  -ProtectedFromAccidentalDeletion $False -Path $dominio4
New-ADOrganizationalUnit -DisplayName "Computers" -name "Computers" -ProtectedFromAccidentalDeletion $False -Path $dominio4
$dominio5="OU=Sistemas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "Users" -name "Users" -ProtectedFromAccidentalDeletion $False -Path $dominio5
New-ADOrganizationalUnit -DisplayName "Groups" -name "Groups"  -ProtectedFromAccidentalDeletion $False -Path $dominio5
New-ADOrganizationalUnit -DisplayName "Computers" -name "Computers" -ProtectedFromAccidentalDeletion $False -Path $dominio5
$dominio6="OU=Gerencia,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"
New-ADOrganizationalUnit -DisplayName "Users" -name "Users" -ProtectedFromAccidentalDeletion $False -Path $dominio6
New-ADOrganizationalUnit -DisplayName "Groups" -name "Groups" -ProtectedFromAccidentalDeletion $False -Path $dominio6
New-ADOrganizationalUnit -DisplayName "Computers" -name "Computers"-ProtectedFromAccidentalDeletion $False  -Path $dominio6

#CREAR USUARIOS 
Import-csv C:\PracticaPWSDia24\PRACTICA_DIA_24.csv | ForEach-Object {New-ADUser -Name $_.Name -GivenName $_.GivenName -Surname $_.Surname -EmailAddress $_.EmailAddress -Department $_.Department -ScriptPath $_.ScriptPath -Path $_.Path -AccountPassword(ConvertTo-SecureString "Itep1234" -AsPlainText -Force) -Enabled $True -PasswordNeverExpires $false -ChangePasswordAtLogon $True -PassThru}New-ADUser -Name "RGMiriam" -GivenName "Miriam" -Surname "Ruiz Gomez" -EmailAddress "admin@psi.es" -Department "Sistemas" -Path "OU=Users,Sistemas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local" -AccountPassword(ConvertTo-SecureString "Itep12345" -AsPlainText -Force) -Enabled $True -PasswordNeverExpires $false -ChangePasswordAtLogon $false -PassThru}#CREAR GRUPO Y UNIR LOS USUARIOS AL GRUPONew-ADGroup "grupocontabilidad" -Path "OU=Groups,OU=Contabilidad,OU=Departamento,OU=PWSDia24,DC=pau,DC=local" -GroupCategory Security -GroupScope Global -PassThru –VerboseAdd-ADGroupMember -Identity grupocontabilidad -Members RADavid,QAMaria,RPBorja,RGMiriamNew-ADGroup "grupoventas" -Path "OU=Groups,OU=Ventas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local" -GroupCategory Security -GroupScope Global -PassThru –VerboseAdd-ADGroupMember -Identity grupoventas -Members RRJavier,RFJoaquin,RGMiriamNew-ADGroup "gruposistemas" -Path "OU=Groups,OU=Sistemas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local" -GroupCategory Security -GroupScope Global -PassThru –VerboseAdd-ADGroupMember -Identity gruposistemas -Members RGMiriamNew-ADGroup "grupogerencia" -Path "OU=Groups,OU=Gerencia,OU=Departamento,OU=PwsDia24,DC=pau,DC=local" -GroupCategory Security -GroupScope Global -PassThru –VerboseAdd-ADGroupMember -Identity grupogerencia -Members RGIsabel,RGMiriam#CREAR EQUIPOS New-ADComputer -Name "Equipo01Contabilidad" -SAMAccountName RADavid -Path "OU=Computers,OU=Contabilidad,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo02Contabilidad" -SAMAccountName QAMaria -Path "OU=Computers,OU=Contabilidad,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo03Contabilidad" -SAMAccountName RPBorja -Path "OU=Computers,OU=Contabilidad,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo01Ventas" -SAMAccountName RRJavier -Path "OU=Computers,OU=Ventas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo02Ventas" -SAMAccountName RFJoaquin -Path "OU=Computers,OU=Ventas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo01Sistemas" -SAMAccountName RGMiriam -Path "OU=Computers,OU=Sistemas,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"New-ADComputer -Name "Equipo01Gerencias" -SAMAccountName RGIsabel -Path "OU=Computers,OU=Gerencia,OU=Departamento,OU=PWSDia24,DC=pau,DC=local"#CREACION DE CARPETAS Y BORRADO EN CASO DE EXISTIR#BorradoRemove-Item -Path "F:\Datos" -Recurse -Confirm:$false#CreacionNew-Item -Path "F:\Datos" -ItemType DirectoryNew-Item -Path "F:\Datos\Departamentos" -ItemType DirectoryNew-Item -Path "F:\Datos\Departamento\Contabilidad" -ItemType DirectoryNew-Item -Path "F:\Datos\Departamento\Ventas" -ItemType DirectoryNew-Item -Path "F:\Datos\Departamento\Sistemas" -ItemType DirectoryNew-Item -Path "F:\Datos\Departamento\Gerencia" -ItemType DirectoryNew-Item -Path "F:\Datos\Publico" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\RADavid" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\QAMaria" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\RPBorja" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\RRJavier" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\RGMiriam" -ItemType DirectoryNew-Item -Path "F:\Datos\Privado\RGIsabel" -ItemType Directory#Remove-SmbShare -Name "Datos" -Confirm:$FalseNew-SmbShare -Name "Datos" -Path "F:\Datos" #PERMISOS CARPETASicacls F:\Datos\Departamentos\Contabilidad /t  /grant "RADavid:(OI)(CI)(M)"icacls F:\Datos\Departamentos\Contabilidad  /t  /grant "QAMaria:(OI)(CI)(M)"icacls F:\Datos\Departamentos\Contabilidad  /t /grant "RPBorja :(OI)(CI)(M)"icacls F:\Datos\Departamentos\Ventas /t /grant "RRJavier:(OI)(CI)(M)"icacls E:\Datos\Privado\ARAlvaro /t /grant "ARAlvaro:(OI)(CI)(M)"icacls E:\Datos\Privado\GSCarlos /t  /grant "GSCarlos:(OI)(CI)(M)"icacls E:\Datos\Privado\PDMaria /t  /grant "PDMaria:(OI)(CI)(M)"icacls E:\Datos\Privado\SREduardo /t /grant "SREduardo:(OI)(CI)(M)"icacls E:\Datos\Privado\ZMSebastian /t /grant "ZMSebastian:(OI)(CI)(M)"icacls E:\Datos /t /grant "RSpau:(CI)(OI)(F)"icacls E:\Datos /t /grant "GSCarlos:(OI)(CI)(M)"icacls E:\Datos\Publico /t /grant "ARAlvaro:(OI)(CI)(M)"icacls E:\Datos\Publico /t  /grant "SREduardo:(OI)(CI)(M)"icacls E:\Datos\Publico /t  /grant "PDMaria:(OI)(CI)(M)"icacls E:\Datos\Publico /t /grant "ZMSebastian:(OI)(CI)(M)"#DENEGAR PERMISOS A CARPETAS#icacls E:\Datos\Sistemas /deny "GSCarlos:(CI)(OI)(D)"#icacls E:\Datos\Privado\RSpau /deny "GSCarlos:(CI)(OI)(D)"