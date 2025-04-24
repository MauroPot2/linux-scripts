#!/bin/bash

# === CONFIGURAZIONE ===
ORIGINE="/home/mauropot/Documenti"
DESTINAZIONE="/home/mauropot/backups"
DATA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVIO="$DESTINAZIONE/backup_$DATA.tar.gz"
LOGFILE="$DESTINAZIONE/backup.log"
MAX_BACKUP=7

# === CREA CARTELLA SE NON ESISTE ===
mkdir -p "$DESTINAZIONE"

# === CREA IL BACKUP COMPRESSO ===
echo "[$(date)] Avvio backup..." >> "$LOGFILE"
tar -czf "$ARCHIVIO" "$ORIGINE" >> "$LOGFILE" 2>&1

if [[ $? -eq 0 ]]; then
  echo "[$(date)] Backup creato con successo: $ARCHIVIO" >> "$LOGFILE"
else
  echo "[$(date)] Errore nella creazione del backup." >> "$LOGFILE"
  exit 1
fi

# === RIMOZIONE VECCHI BACKUP LOCALI ===
ls -1t "$DESTINAZIONE"/backup_*.tar.gz | tail -n +$(($MAX_BACKUP + 1)) | xargs -r rm -f
echo "[$(date)] Pulizia backup locali completata." >> "$LOGFILE"

# === CARICAMENTO SU GOOGLE DRIVE ===
rclone copy "$ARCHIVIO" gdrive:BackupsLinux >> "$LOGFILE" 2>&1

if [[ $? -eq 0 ]]; then
  echo "[$(date)] Backup caricato con successo su Google Drive." >> "$LOGFILE"
else
  echo "[$(date)] Errore nel caricamento su Google Drive." >> "$LOGFILE"
  exit 2
fi

echo "[$(date)] Backup completato con successo ✅" >> "$LOGFILE"
