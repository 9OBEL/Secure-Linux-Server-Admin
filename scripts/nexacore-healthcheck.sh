  echo "[${TIMESTAMP}]${STATUS}: Services=OK | Disk=${DISK_USAGE}\% \vert{} RAM=${MEM_USAGE}% | HTTP=${HTTP_CODE}" >> "${LOG_FILE}"
else
  echo "[${TIMESTAMP}] ${STATUS}: FailedServices=[${FAILED_SERVICES:-none}] | Disk=${DISK_USAGE}\% \vert{} RAM=${MEM_USAGE}% | HTTP=${HTTP_CODE}" >> "${LOG_FILE}"
fi
