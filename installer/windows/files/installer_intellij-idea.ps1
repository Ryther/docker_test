# Script di lancio principale per Intellij Idea Dockerized

# Verifico l'installazione del server grafico VcXsrv
    $infoPrg = "VcXsrv"
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica installazione")
    $prgVerify = choco list -l -r vcxsrv
    if ($prgVerify -eq "") {

        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Non installato")
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Installazione")
        choco install -y vcxsrv
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

# Verifico se VcXsrv è in esecuzione
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica esecuzione")
    Get-Process vcxsrv -ErrorAction SilentlyContinue *>$null
    if ($?) {

        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Programma già in esecuzione")
    } else {

        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Programma non in esecuzione, avvio programma")
        & "$prgPath\VcXsrv\vcxsrv.exe" :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl
        if ($?) {

            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Programma avviato")
        } else {

            [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Impossibile avviare il programma, interruzione script")
            Pause
            exit 1
        }
    }
# ----------------------------------
# Verifico l'installazione di docker
    $infoPrg = "Docker"
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica installazione")
    $prgVerify = choco list -l -r docker-for-widnows
    if ($prgVerify -eq "") {

        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Non installato")
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Installazione")
        choco install -y docker-for-widnows
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

# Verifico se Docker è in esecuzione
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica esecuzione")
    Get-Process "Docker for Windows" -ErrorAction SilentlyContinue *>$null
    if ($?) {

        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Programma già in esecuzione")
    } else {

        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Programma non in esecuzione, avvio programma")
        & "$prgPath\Docker\Docker\Docker for Windows.exe"
        if ($?) {

            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Programma avviato")
            $testDocker = $false
            $maxTries = 35
            $sleepTime = 1 # secondi
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Attendo completamento avvio")
            for ($i = 0; $i -le $maxTries; $i++) {
                
                docker ps *>$null
                if ($?) {

                    $testDocker = $true
                    Break
                } else {
                    
                    Write-Progress -Activity "Attesa completamento avvio Docker" -Status "Secondi attesa rimanenti: " -PercentComplete ((($i*$sleepTime)/($maxTries*$sleepTime))*100) -SecondsRemaining (($maxTries*$sleepTime)-($i*$sleepTime))
                    Start-Sleep -s $sleepTime
                }
            }
            if ($testDocker) {
                [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Avvio completato")
            } else {
                [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Impossibile avviare Docker, interruzione script")
                Pause
                exit 1
            }
        } else {

            [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Impossibile avviare il programma, interruzione script")
            Pause
            exit 1
        }
    }

# Verifico la presenza dell'immagine intellij-idea
    $imgVar = $dkrPrvHub+"/"+($dkrApp -replace "-", "/")
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica esistenza immagine $imgVar" + ":latest")
    $dkrImg = docker images --format "{{.Repository}}" --filter "reference="($imgVar+":latest")
    if ($dkrImg -eq "") {
        
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Immagine non presente")
        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifico presenza $dkrPrvHub in daemon.json")
        $dkrDaemon = Get-Content ($env:ProgramData+"\Docker\config\daemon.json") | ConvertFrom-Json
        if (!($dkrDaemon.'insecure-registries' -match "$dkrPrvHub")) {
            
            [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - $dkrPrvHub non presente come insecure-registry, aggiungo...")
            $dkrDaemon.'insecure-registries' += "$dkrPrvHub"
            $dkrDaemon | ConvertTo-Json > ($env:ProgramData+"\Docker\config\daemon.json")
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - $dkrPrvHub aggiunto come insecure-registry")
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Riavvio docker in corso")
        }
        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Scaricamento immagine")
        docker pull ($imgVar + ":latest")
        if ($?) {
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Immagine scaricata con successo")
        } else {
            
            [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Impossibile scaricare immagine")
            [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Immagine $imgVar" + ":latest non trovata.")
			[Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Assicurarsi di avere accesso al registry docker")
			[Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Script terminato con errore:")
			Pause
            exit 1
        }
    }

# Verifico presenza ed avvio del container intellij-idea
    [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Verifica esistenza container $imgVar")
    $testCnt = DOCKER ps -a --format "{{.Names}}" --filter "name=$imgVar"
    if ($testCnt -eq "") {

        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Container $dkrApp non esistente")
        [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Creo container $dkrApp")
        & "$PSScriptRoot\docker_command.ps1"
        if ($?) {
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Container $dkrApp creato correttamente")
        } else {
            [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Errore creazione container $dkrApp")
            Pause
            exit 1
        }
    } else {

        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Container $dkrApp esistente")
        [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Container $dkrApp avviato?")
        if (!(docker ps --format "{{.Names}}" --filter "name=$dkrApp")) {

            [Utils]::wLog($vLevel, [MessageLevel]::Warning, "$infoPrg - Container $dkrApp non avviato")
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Avvio container $dkrApp")
            docker start $dkrApp
            if ($?) {
                [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Container $dkrApp avviato correttamente")
            } else {
                [Utils]::wLog($vLevel, [MessageLevel]::Error, "$infoPrg - Impossibile avviare container $dkrApp")
                Pause
                exit 1
            }
        } else {
            [Utils]::wLog($vLevel, [MessageLevel]::Info, "$infoPrg - Container $dkrApp già in esecuzione")
        }
    }
