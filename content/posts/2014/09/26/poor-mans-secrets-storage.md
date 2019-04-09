---
title: Poor man's secrets storage
date: 2014-09-26 10:33:31
tags: [security]
---

I'm a bit cautious when it comes to storing my passwords and other
secrets. I do not use any web or desktop applications to do this for me.
How do I remember those passphrases then ? I have a central file server,
accessible via a tunnel. I store there a gpg-encrypted file containing a
tar archive of a directory with various files containing secrets.
Syncing these files across computers became a bit cumbersome lately. I'm
using git to version them, but because I do not want to have the sync
server to contain unencrypted secrets I needed to bake some custom
solution. [Bash](https://access.redhat.com/articles/1200223) to the
rescue ! There are still some assumptions made here about permissions,
directories layout and some stuff not failing, but I'm sure you'll be
able to figure this out and tweak to your needs.

```
    #!/bin/bash

    TUNNEL_CREDS="user@tunnelhost"
    TUNNEL_PORT=123
    STORAGE_CREDS="storage_user@localhost"
    STORAGE_ADDRESS="storagehost.example.org"
    SOCKET="/tmp/black_socket"
    REMOTE_VAULT_PATH="/somepath/.vault.tar.gpg"
    TMP_VAULT="/tmp/.vault.tar.gpg"
    TMP_VAULT_TAR="/tmp/.vault.tar"
    TMP_VAULT_DIR="/tmp/.vault"

    TMP_LOCAL_PORT=10022
    LOCAL_VAULT_DIR="$HOME/.vault"
    LOCAL_VAULT_BACKUP_DIR="$LOCAL_VAULT_DIR.bak"

    pushd `pwd`

    echo "removing old vault backup at $LOCAL_VAULT_BACKUP_DIR"
    rm -rI "$LOCAL_VAULT_BACKUP_DIR"

    set -e

    echo "backing up local vault..."
    cp -r "$LOCAL_VAULT_DIR" "$LOCAL_VAULT_BACKUP_DIR"

    echo "establishing tunnel ..."
    ssh -L $TMP_LOCAL_PORT:$STORAGE_ADDRESS:22 $TUNNEL_CREDS -p $TUNNEL_PORT -N -f -M -S "$SOCKET"

    echo "tunnel ready, copying remote version of the vault..."
    rsync --progress -avz -e "ssh -p $TMP_LOCAL_PORT" "$STORAGE_CREDS:$REMOTE_VAULT_PATH" "$TMP_VAULT"

    echo "decrypting new vault..."
    gpg -d "$TMP_VAULT" > "$TMP_VAULT_TAR"

    echo "unpacking new vault..."
    mkdir -p "$TMP_VAULT_DIR"
    tar xf "$TMP_VAULT_TAR" -C "$TMP_VAULT_DIR"

    echo "pulling from remote vault..."
    cd "$LOCAL_VAULT_DIR"
    git pull "$TMP_VAULT_DIR"

    echo "pulling to remote vault..."
    cd "$TMP_VAULT_DIR"
    git pull "$LOCAL_VAULT_DIR"

    echo "cleaning up a bit..."
    rm -fr "$TMP_VAULT_TAR"
    rm -fr "$TMP_VAULT"

    echo "packing refreshed remote vault..."
    tar pcf "$TMP_VAULT_TAR" -C "$TMP_VAULT_DIR" .

    echo "encrypting refreshed remote vault..."
    gpg -c "$TMP_VAULT_TAR"

    echo "sending out updated vault"
    rsync --progress -avz "$TMP_VAULT" -e "ssh -p $TMP_LOCAL_PORT" "$STORAGE_CREDS:$REMOTE_VAULT_PATH"

    echo "cleaning up.. "
    rm -fr "$TMP_VAULT_DIR"
    rm -fr "$TMP_VAULT_TAR"
    rm -fr "$TMP_VAULT"

    echo "closing tunnel.."
    ssh -S "$SOCKET" -O exit $TUNNEL_CREDS

    popd
```
