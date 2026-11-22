#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/var/backups/nexacore"
LOG_FILE="/var/log/nexacore-backup.log"
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
ARCHIVE_PATH="${BACKUP_DIR}/nexacore-backup-${TIMESTAMP}.tar.gz"

mkdir -p "${BACKUP_DIR}"
chmod 700 "${BACKUP_DIR}"

if tar -czf "${ARCHIVE_PATH}" -C / \
  srv/nexacore \
  etc/ssh/sshd_config.d \
  etc/sudoers.d \
  var/www/html; then
  chmod 600 "${ARCHIVE_PATH}"
  ARCHIVE_SIZE="$(du -h "${ARCHIVE_PATH}" | cut -f1)"
  echo "[$(date '+\%Y-\%m-\%d \%H:\%M:\%S')] SUCCESS: Created${ARCHIVE_PATH} (${ARCHIVE_SIZE})" >> "${LOG_FILE}"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: Backup failed for ${ARCHIVE_PATH}" >> "${LOG_FILE}"
  exit 1
fi

# Retention policy: remove backup archives older than 7 days
find "${BACKUP_DIR}" -name "nexacore-backup-*.tar.gz" -type f -mtime +7 -delete
