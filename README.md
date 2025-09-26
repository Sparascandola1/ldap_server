# OpenDJ LDAP Docker Setup

## Overview

This document describes how to set up a **portable OpenDJ LDAP server** in a Docker container with an automated dataset loading, and how to connect apps to it using Python.

---

## Prerequisites

* Docker and Docker Compose installed
* Python 3 with `ldap3` library

Install Python library:

```bash
source .venv/bin/active
pip install -r requirements.txt
```

---

## Start the Server

```bash
docker-compose up -d
```

* The `load-ldif.sh` script will run automatically on first startup.
* Verify container logs:

```bash
docker logs opendj
```

* LDAP is available at `ldap://localhost:1389`.

---

## Verify LDIF Import

```bash
./bin/searchuser.sh
```

You should see:

```text 
dn: dc=moria,dc=org
dc: moria
objectClass: domain
objectClass: top

dn: ou=users,dc=moria,dc=org
objectClass: organizationalUnit
objectClass: top
ou: users

dn: ou=groups,dc=moria,dc=org
objectClass: organizationalUnit
objectClass: top
ou: groups

dn: uid=john,ou=users,dc=moria,dc=org
cn: John Doe
givenName: John
mail: john@moria.org
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
objectClass: top
sn: Doe
uid: john
userPassword: {SSHA}pReOmA5l1/sA2eAQfg87BjrLxtnpVJIcwn+vZA==

dn: uid=jane,ou=users,dc=moria,dc=org
cn: Jane Smith
givenName: Jane
mail: jane@moria.org
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: person
objectClass: top
sn: Smith
uid: jane
userPassword: {SSHA}jw3Fyxt5za8WxCic0eSWva5acZCm7e2wFHQF8Q==

dn: cn=developers,ou=groups,dc=moria,dc=org
cn: developers
objectClass: groupOfUniqueNames
objectClass: top
uniqueMember: uid=jane,ou=users,dc=moria,dc=org
uniqueMember: uid=john,ou=users,dc=moria,dc=org
```

---

## Connect with Python (`ldap3`)

```bash
python searchUsers.py
```

You should see:

```text 
DN: uid=john,ou=users,dc=moria,dc=org - STATUS: Read - READ TIME: 2025-09-25T20:56:58.858503
    cn: John Doe
    mail: john@moria.org
    uid: john

DN: uid=jane,ou=users,dc=moria,dc=org - STATUS: Read - READ TIME: 2025-09-25T20:56:58.858706
    cn: Jane Smith
    mail: jane@moria.org
    uid: jane
```

---

## Common Issues

* **“Permission denied” running Docker:**
  Add your user to the `docker` group:

  ```bash
  sudo usermod -aG docker $USER
  newgrp docker
  ```

* **LDIF didn’t import:**

  * Check `bootstrap.ldif` base DN matches `BASE_DN`
  * Ensure container is fully started before importing
  * Use `--offline` flag if bind fails

* **Python script errors (`from: command not found`)**
  Run with Python explicitly:

  ```bash
  python3 example-connection.py
  ```

---
