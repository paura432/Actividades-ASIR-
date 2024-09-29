function menuPrincipal {
    $menu = 'a'
    while ($menu -ne '') {
        Clear-Host
        Write-Host ''
        Write-Host ''
        Write-Host '******************************************'
        Write-Host '+                 MENU                   +'
        Write-Host '+========================================+'
        Write-Host '+                                        +'         
        Write-Host '+      [1] fecha y hora actual           +'         
        Write-Host '+      [2] nombre de usuario             +'         
        Write-Host '+      [3] info directorio oridinal      +'         
        Write-Host '+      [4] Salir                         +'
        Write-Host '+                                        +'            
        Write-Host '******************************************'         
        Write-Host ''         
        Write-Host ''
        # Recibe una entrada del teclado.
        $menu = Read-Host "Escribe una opcion"
        # Lanza la opcion 1.
        if ($menu -eq 1) {
            Clear-Host
Write-Output ""
Write-Output "**********************************************************"
Write-Output "+               1.- Fecha y Hora actuales.                +"
Write-Output "**********************************************************"
Write-Output ""
$fecha = Get-Date -Format "dddd dd/MM/yyyy"
Write-Output ""
Write-Output "Fecha:"
Write-Output "$fecha"
Write-Output ""
$hora = Get-Date -Format "HH:mm"
Write-Output "Hora:"
Write-Output "$hora"
Write-Output ""
Pause         
        }
        Clear-Host
        # Lanza la opcion 2.
        if ($menu -eq 2) {
            Clear-Host
Write-Output ""
Write-Output "**********************************************************"
Write-Output "+        2.- Ahora aparece tu nombre de usuario.         +"
Write-Output "**********************************************************"
Write-Output ""
Write-Output "Tu eres $env:USERNAME."
Write-Output ""
Pause
        }
        Clear-Host
        # Lanza la opcion 3.
        if ($menu -eq 3) {
           Clear-Host
Write-Output ""
Write-Output "**********************************************************"
Write-Output "+     3.- Este es el contenido del directorio actual.    +"
Write-Output "**********************************************************"
Get-ChildItem
Write-Output ""
Pause
        }
        # Fin del Script.
        if ($menu -eq 4) {
            Write-Host ''
            Write-Host "******************************************"
            Write-Host "+           Fin del script.              +"
            Write-Host "******************************************"
            Write-Host ''
            Pause
            Clear-Host
            Return
        }
        
    } 
}

menuPrincipal