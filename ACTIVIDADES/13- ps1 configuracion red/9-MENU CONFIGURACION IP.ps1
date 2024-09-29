function principal{
do
{
clear-host
write-host ""
write-host ""
write-host "Menú Gestión de Red"
Write-Host "1.Mostrar información simple adaptador de red"
Write-Host "2.Mostrar información detallada"
Write-Host "3.Activar/Desactivar adaptador"
Write-Host "4.Configuración IP"
Write-Host "5.Salir"
write-host ""

$SELECT=read-host "seleccione una opcion 1,2,3,4,5"

write-host ""

if ($SELECT -eq 1)
{
Get-netadapter
Pause
write-host ""
write-host "Pulse para continuar..."

}

if ($SELECT -eq 2)
{
$adap=read-host "Nombre del adaptador"
Get-netadapter -name $adap|ft
Pause
write-host ""
write-host "Pulse para continuar..."
clear-host
}

if ($SELECT -eq 3)
{
clear-host
write-host ""
write-host "Desea activar o desactivar?"
write-host "1.Activar"
write-host "2.Desactivar"
write-host ""

$SELECT2=read-host "Seleccione una opcion 1,2"
write-host ""

if ($SELECT2 -eq 1)
{
$adaptador=Read-Host "Nombre del adaptador"
enable-netadapter -Name $adaptador
}
else {
$adaptador=Read-Host "Nombre del adaptador"
Disable-netadapter -Name $adaptador
}
}


if ($SELECT -eq 4)
{
menuconfip
PRINCIPAL
}

if ($elegir -eq 5)
{
exit
}
}
while ($elige -le 5)

}

function menuconfip {

do {
clear-host
write-host ""
write-host "Menú de configuración IP"
write-host "A.Ver configuración actual"
write-host "B.Comprobar conectividad a internet"
write-host "C.Cambiar a conf.estática"
write-host "D.Volver"


$SELECT2=read-host "Seleccione una opcion A,B,C,D,E"
write-host ""

if ($SELECT2 -eq "A"){
get-netIPConfiguration
Pause
write-host ""
write-host "Pulse para continuar..."

}

if ($SELECT2 -eq "B"){
Test-Connection www.google.es
Pause
write-host ""
write-host "Pulse para continuar..."

}

if ($SELECT2 -eq "C"){
$ip=Read-host "indique la IP"
$pe=Read-host "indique una puerta de enlace"
$masc=Read-host "indique la mascara"
$dns=Read-host "indique dns"
Remove-NetIPAddress
New-NetIPAddress -IPAddress $ip -Prefixlength $masc -DefaultGateway $pe -ServerAddresses $dns
Pause
write-host ""
write-host "Pulse para continuar..."

}

}
while ($eleg2 -ne "E")

}

principal