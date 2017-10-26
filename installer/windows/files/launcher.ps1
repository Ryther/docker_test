Using module '.\lib\Utils\Utils.psd1'

# CONSTANTS
# dkrApp nome del repository dell'immagine. Sostituire / con -
PARAM (
    [STRING]$dkrPrvHub="",
    [STRING]$dkrApp="",
    [STRING]$dkrAppVer="",
    [STRING]$installer="installer_${dkrApp}.ps1",
    [INT]$vLevel=[MessageLevel]::Info,
    [STRING]$prgPath=[Utils]::envPrgPath()
)

$infoPrg = "CHOCO"
[Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica installazione")

if (!(Test-Path -Path "C:\ProgramData\chocolatey\")) {
    [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Non installato")
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Installazione")
    if (!(Get-ExecutionPolicy).ToString().Equals("Bypass")) {
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Impostazione policies su `"Bypass`"")
        Set-ExecutionPolicy Bypass
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Policies impostate su `"Bypass`"")
    }
    iex ((New-Object System.Net.WebClient).DownloadString('https://$infoPrglatey.org/install.ps1'))
    if ($?) {
        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Installazione eseguita con successo")
    } else {
        [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Installazione fallita, interruzione script")
        Pause
        exit 1
    }
} else {
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Programma già installato")
}

& "$PSScriptRoot\$installer"