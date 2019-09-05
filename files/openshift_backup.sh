#!/usr/bin/env bash
#
# Adfinis SyGroup AG
# https://github.com/adfinis-sygroup/ansible-role-openshift_backup
#

set -euf -o pipefail

# specify backup vault
if [ -z "$1" ]; then
    echo "Usage: $0 <vault>" >&2
    exit 1;
fi

VAULT="/home/backup/$1"
# the CONTEXT used for the backup is defined in the configuration file
. ${VAULT}/openshift_backup/default.conf

BACKUP_DIR="${VAULT}/$(date +%Y%m%d_%H%M)/openshift/projects"
BACKUP_LOG="${BACKUP_DIR}/openshift_backup.log"
mkdir -p "${BACKUP_DIR}"

cd "${BACKUP_DIR}" || exit 1
touch "${BACKUP_LOG}" || exit 1

# set backup context in oc
oc config use-context ${CONTEXT} &>> "${BACKUP_LOG}"

# output version info
oc version &>> "${BACKUP_LOG}"

for project in $(oc get projects -o name | sed 's#projects/##'); do
  echo -e "\nBacking up project ${project}" &>> "${BACKUP_LOG}"
  /opt/adfinis/bin/project_export.sh "${project}" &>> "${BACKUP_LOG}"
  /opt/adfinis/bin/non-namespaced_export.sh &>> "${BACKUP_LOG}"
done

# clean up old backups

if [ ${CLEANUP} -gt 0 ] 
  then
  find "${VAULT}" -mindepth 1 -maxdepth 1 -name '20*' -daystart -type d -mtime +${RETENTION} | xargs -r rm -rf
fi
