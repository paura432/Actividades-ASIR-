$ADUsers = Import-csv C:\scripts\PRACTICA_USUARIOS_CUOTAS.CSV
$domi = "OU=PracticaPWS13_12,DC=PAU,DC=LOCAL"
#añadir unidades organizativas
New-ADOrganizationalUnit -Name PracticaPWS13_12 -Path “DC=PAU,DC=LOCAL” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name departamentos -Path “$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name LOGISTICA -Path “OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=LOGISTICA,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=LOGISTICA,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=LOGISTICA,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name FACTURACION -Path "OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=FACTURACION,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=FACTURACION,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=FACTURACION,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name SISTEMAS -Path “OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name grupos -Path “OU=SISTEMAS,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name usuarios -Path “OU=SISTEMAS,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name equipos -Path “OU=SISTEMAS,OU=departamentos,$domi” -ProtectedFromAccidentalDeletion $false
#añadir grupos
#Enter a path to your import CSV file
#añadir las caracteristicas ha los usuarios
foreach ($User in $ADUsers)`
{
 $Username = $User.NOMBRETRABAJADOR
 $Password = $User.CONTRASENA
 $Firstname = $User.NOMBRE
 $Lastname = $User.APELLIDOS
 $Mail = $User.MAIL
 $Department = $User.DEPARTAMENTO
 $OU = $User.OU
 $cambiariniciosesion = $User.CAMBIARINICIOSESIÓN
 $archivoinicio = $User.ARCHIVOINICIOSESION
 #Check if the user account already exists in AD
 if (Get-ADUser -F {SamAccountName -eq $Username})
        {
        #Si el usuario existe, me pones el siguiente mensaje:
         Write-Warning "La cuenta de usuario $Username ya existe."
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
#Creación de los equipos
foreach($User in $ADUsers){

   $Departamento = $User.DEPARTAMENTO
   $Equipo = $User.EQUIPO
   if($Departamento -eq "LOGISTICA"){

        New-ADComputer –Name $Equipo –SamAccountName $Equipo -Path "OU=equipos,OU=LOGISTICA,ou=departamentos,$domi"

   }

   elseif($Departamento -eq "FACTURACION"){

        New-ADComputer –Name $Equipo –SamAccountName $Equipo -Path "OU=equipos,OU=FACTURACION,ou=departamentos,$domi"

   }

   elseif($Departamento -eq "SISTEMAS"){

        New-ADComputer –Name $Equipo –SamAccountName $Equipo -Path "OU=equipos,OU=SISTEMAS,ou=departamentos,$domi"

   }

}#añadimos ha los usuarios ha los gruposNew-ADGroup -name grupoLOGISTICA -Path "OU=grupos,OU=LOGISTICA,ou=departamentos,$domi" -GroupCategory Security -GroupScope Global -PassThru –VerboseNew-ADGroup -name grupoFACTURACION -Path "OU=grupos,OU=FACTURACION,ou=departamentos,$domi" -GroupCategory Security -GroupScope Global -PassThru –VerboseNew-ADGroup -name grupoSISTEMAS -Path "OU=grupos,OU=SISTEMAS,ou=departamentos,$domi" -GroupCategory Security -GroupScope Global -PassThru –Verbose#NUEVOS ORDENADORES
foreach($User in $ADUsers){    $Usuario = $User.NOMBRETRABAJADOR    $Departamento = $User.DEPARTAMENTO    if($Departamento -eq "LOGISTICA"){            Add-AdGroupMember -Identity grupoLOGISTICA -Members $Usuario    }    elseif($Departamento -eq "SISTEMAS"){            Add-AdGroupMember -Identity Administradores -Members $Usuario        Add-AdGroupMember -Identity grupoSISTEMAS -Members $Usuario        }    elseif($Departamento -eq "FACTURACION"){            Add-AdGroupMember -Identity grupoFACTURACION -Members $Usuario        }}
#crear carpetas disco :E
remove-item -Path "E:\PracticaPWS13_12" -recurse -confirm:$false
New-Item E:\PracticaPWS13_12 -Type directory
New-Item E:\PracticaPWS13_12\LOGISTICA -Type directory
New-Item E:\PracticaPWS13_12\GENERAL -Type directory
New-Item E:\PracticaPWS13_12\FACTURACION -Type directory
New-Item E:\PracticaPWS13_12\SISTEMAS -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_Miriam.R.G -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_HectorMiguel.S.P -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_Alvaro.S.F -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_Ramon.T.R -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_Mario.V.C -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\privada_Jorge.Z.A -Type directory
New-Item E:\PracticaPWS13_12\GENERAL\publica -Type directory
#compartir las carpetas de e:
Remove-smbShare -Name "PracticaPWS13_12" -confirm:$false
New-smbshare -Name "PracticaPWS13_12" -Path "E:\PracticaPWS13_12" 
#comando permisos carpetas
icacls E:\PracticaPWS13_12\LOGISTICA /grant "grupoLOGISTICA:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\GENERAL\privada_Miriam.R.G /grant "Miriam.R.G:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\GENERAL\privada_HectorMiguel.S.P /grant "HectorMiguel.S.P:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\FACTURACION /grant "grupoFACTURACION:(OI)(CI)(M)" 
icacls E:\PracticaPWS13_12\GENERAL\privada_Alvaro.S.F /grant "Alvaro.S.F:(OI)(CI)(M)" 
icacls E:\PracticaPWS13_12\GENERAL\privada_Ramon.T.R /grant "Ramon.T.R:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\GENERAL\privada_Mario.V.C /grant "Mario.V.C:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\GENERAL\privada_Jorge.Z.A /grant "Jorge.Z.A:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12\GENERAL\publica /grant "grupoLOGISTICA:(OI)(CI)(M)" /grant "grupoFACTURACION:(OI)(CI)(M)"
icacls E:\PracticaPWS13_12 /grant "Pau.R.S:(OI)(CI)(F)"              