#!/bin/bash

function usage() {
    echo "usage: _proxy_set.sh"
    echo "    => return 1 if a proxy is set, 0 else"
}

if test "${1:-}" = "--help"; then
    usage
    exit 0
fi

if test "${http_proxy:-}" = "http://127.0.0.1:9999"; then
    # this is a false value used by mfext build process if there is no proxy set
    echo 0
    exit 1
fi

if test "${http_proxy:-}" != ""; then
    echo 1
    exit 0
fi
if test "${https_proxy:-}" != ""; then
    echo 1
    exit 0
fi
if test "${HTTP_PROXY:-}" != ""; then
    echo 1
    exit 0
fi
if test "${HTTPS_PROXY:-}" != ""; then
    echo 1
    exit 0
fi
if test "${ftp_proxy:-}" != ""; then
    echo 1
    exit 0
fi
if test "${FTP_PROXY:-}" != ""; then
    echo 1
    exit 0
fi
echo 0
exit 0
