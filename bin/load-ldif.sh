#!/bin/bash
set -e

# Only import if backend is empty
if [ ! -f /opt/opendj/data/userRoot/db/je.lck ]; then
  echo "Importing initial LDIF data..."
  /opt/opendj/bin/import-ldif \
    --backendID userRoot \
    --ldifFile /opt/opendj/bootstrap.ldif \
    --bindDN "cn=Directory Manager" \
    --bindPassword admin \
    --clearBackend
else
  echo "Backend already initialized, skipping import."
fi
