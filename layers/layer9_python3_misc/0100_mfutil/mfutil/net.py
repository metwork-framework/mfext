"""Utility functions around network."""

import logging
import socket
import netifaces


def __get_logger():
    return logging.getLogger("mfutil.net")


def get_ip_for_hostname(hostname, ignore_hostnames_list=["AUTO"]):
    """Get the IP of a given hostname.

    Args:
        hostname (string): hostname to find.
        ignore_hostnames_list (list of strings): special hostname values which
            won't be lookup ip (if the given hostname is in this list, this
            function will return the given hostname without any modification).
    Returns:
        (string) IP of the given hostname (or None if we can't find it).

    """
    if hostname in ignore_hostnames_list:
        return hostname
    if hostname in ("127.0.0.1", "localhost", "localhost.localdomain"):
        return "127.0.0.1"
    try:
        infos = socket.getaddrinfo(hostname, 80, 0, 0, socket.IPPROTO_TCP)
    except Exception:
        return None
    for (family, sockettype, proto, canonname, sockaddr) in infos:
        if sockaddr is None or len(sockaddr) != 2:
            continue
        tmp = sockaddr[0]
        if '.' not in tmp:
            # we don't want ipv6
            continue
        return tmp
    return None


def get_simple_hostname():
    """Return the "simple" hostname of the server.

    "simple" hostname means "without network domain", so without any dot
    in the hostname.

    Returns:
        string: the "simple" hostname of the server.

    """
    return socket.gethostname().split('.')[0]


def _get_domainname_from_resolv_conf(resolv_conf_file="/etc/resolv.conf"):
    with open(resolv_conf_file, "r") as f:
        lines = f.readlines()
    for line in lines:
        tmp = line.strip()
        if tmp.startswith("domain"):
            cols = tmp.split()
            if len(cols) >= 2:
                return cols[1]
    return None


def get_domainname(use_resolv_conf=True, resolv_conf_file="/etc/resolv.conf"):
    """Get the domain name of the server.

    The domain name does not include the hostname.

    We try first with the getfqdn method then with the resolv.conf file because
    the domain can be found here.

    Args:
        use_resolv_conf (boolean): if set to True, we use the resolv.conf file.
        resolv_conf_file (string): full path of the resolv.conf file (useful
            for unit testing).

    Returns:
        string: the domain name of the server (or None if we can't find it)

    """
    tmp = socket.getfqdn(get_simple_hostname())
    if '.' in tmp:
        return ".".join(tmp.split('.')[1:])
    if use_resolv_conf:
        return _get_domainname_from_resolv_conf(resolv_conf_file)
    return None


def get_full_hostname(use_resolv_conf=True,
                      resolv_conf_file="/etc/resolv.conf"):
    """Return the "full" hostname of the server.

    "full" hostname means "with network domain" appended.

    Args:
        use_resolv_conf (boolean): if set to True, we use the resolv.conf file
            to find the domain name.
        resolv_conf_file (string): full path of the resolv.conf file (useful
            for unit testing).

    Returns:
        string: the "full" hostname of the server.

    """
    tmp = socket.getfqdn(get_simple_hostname())
    if '.' in tmp or not use_resolv_conf:
        return tmp
    domainname = get_domainname(use_resolv_conf, resolv_conf_file)
    if domainname is not None:
        return "%s.%s" % (get_simple_hostname(), domainname)
    return get_simple_hostname()


def _get_real_ip_netifaces():
    # pylint: disable=E1101
    ip = "127.0.0.1"
    try:
        # we try first with the default gateway
        def_gw_device = netifaces.gateways()['default'][netifaces.AF_INET][1]
        infos = netifaces.ifaddresses(def_gw_device)
        ip = str(infos[netifaces.AF_INET][0]['addr'])
    except Exception:
        pass
    if ip != "127.0.0.1":
        return ip
    # we try every interface
    for interface in netifaces.interfaces():
        try:
            infos = netifaces.ifaddresses(interface)
            ip = str(infos[netifaces.AF_INET][0]['addr'])
        except Exception:
            pass
        if ip != "127.0.0.1":
            return ip
    return ip


def get_real_ip():
    """Try to find and return the real IP of the server.

    We try to avoid to return 127.0.0.1 by examining network interfaces.

    Returns:
        string: the real IP of the server.

    """
    hostname = get_simple_hostname()
    ip = get_ip_for_hostname(hostname)
    if ip != "127.0.0.1":
        return ip
    # try to find the real ip (not 127.0.0.1)
    return _get_real_ip_netifaces()


def ping_tcp_port(host, port, timeout=5):
    """Ping a TCP host/port with a configurable timeout.

    It's not really a ping but a little connection attempt to see if the
    port is open and listened. The timeout is useful when there is a kind
    of firewall between.

    No Exception are raised in any case.

    Args:
        host (string): the hostname/ip to ping.
        port (int): the TCP port to ping.
        timeout (int): timeout in seconds.

    Returns:
        boolean: True if the port is open and listened.

    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(timeout)
    try:
        result = sock.connect_ex((host, port))
        if result == 0:
            sock.close()
            return True
    except Exception:
        pass
    return False
