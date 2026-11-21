# Linux Scripts

Raccolta di script Bash per automatizzare attività di manutenzione su Linux. Attualmente include un processo di backup locale con copia su Google Drive tramite rclone.

## Backup

Lo script `backup.sh`:

- crea un archivio `tar.gz` della directory configurata;
- salva log ed esiti delle operazioni;
- conserva localmente gli ultimi sette archivi;
- carica l'archivio su una destinazione remota configurata con rclone.

## Requisiti

Bash, `tar`, `rclone` e una destinazione Google Drive autorizzata in rclone.

## Configurazione

Aprire `backup.sh` e adattare `ORIGINE`, `DESTINAZIONE` e il percorso remoto `gdrive:BackupsLinux`. I percorsi presenti nello script si riferiscono alla macchina originale e non sono universali.

Eseguire un primo test manuale:

~~~bash
bash backup.sh
~~~

## Attenzione ai dati

Verificare di avere spazio libero sufficiente e controllare i log dopo il primo backup. Il processo elimina gli archivi locali più vecchi del limite configurato, ma **non** costituisce da solo una strategia di disaster recovery: è necessario provare periodicamente il ripristino.

Lo script è fornito come configurazione personale e va adattato prima di automatizzarne l'esecuzione con cron o systemd.
