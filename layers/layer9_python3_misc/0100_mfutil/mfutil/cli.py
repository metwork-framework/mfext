"""Utility functions to build CLI."""

from __future__ import print_function
import six
import sys
import ctypes

MFUTIL_INSTANCE = None


def _get_mfutil():
    global MFUTIL_INSTANCE
    if MFUTIL_INSTANCE is None:
        i = ctypes.cdll.LoadLibrary("libmfutil.so")
        i.mfutil_echo_ok.restype = None
        i.mfutil_echo_ok.argtypes = [ctypes.c_char_p]
        i.mfutil_is_interactive_execution.restype = ctypes.c_int
        i.mfutil_is_interactive_execution.argtypes = []
        i.mfutil_echo_nok.restype = None
        i.mfutil_echo_nok.argtypes = [ctypes.c_char_p]
        i.mfutil_echo_warning.restype = None
        i.mfutil_echo_warning.argtypes = [ctypes.c_char_p]
        i.mfutil_echo_bold.restype = None
        i.mfutil_echo_bold.argtypes = [ctypes.c_char_p]
        i.mfutil_echo_running.restype = None
        i.mfutil_echo_running.argtypes = []
        i.mfutil_echo_clean.restype = None
        i.mfutil_echo_clean.argtypes = []
        MFUTIL_INSTANCE = i
    return MFUTIL_INSTANCE


def is_interactive():
    """Return True if we are in an interactive terminal."""
    tmp = _get_mfutil().mfutil_is_interactive_execution()
    return (tmp == 1)


def echo_ok(message=""):
    """Write [OK] with colors if supported a little optional message.

    Args:
        message (string): little optional message.

    """
    _get_mfutil().mfutil_echo_ok(message.encode('utf8'))


def echo_nok(message=""):
    """Write [ERROR] with colors if supported a little optional message.

    Args:
        message (string): little optional message.

    """
    _get_mfutil().mfutil_echo_nok(message.encode('utf8'))


def echo_warning(message=""):
    """Write [WARNING] with colors if supported a little optional message.

    Args:
        message (string): little optional message.

    """
    _get_mfutil().mfutil_echo_warning(message.encode('utf8'))


def echo_bold(message):
    """Write a message in bold (if supported).

    Args:
        message (string): message to write in bold.

    """
    _get_mfutil().mfutil_echo_bold(message.encode('utf8'))


def echo_running(message=None):
    """Write [RUNNING] with colors if supported.

    You can pass an optional message which will be rendered before [RUNNING]
    on the same line.

    Args:
        message (string): little optional message.

    """
    if message is None:
        _get_mfutil().mfutil_echo_running()
    else:
        if six.PY2:
            print(message, end="")
            sys.stdout.flush()
        else:
            print(message, end="", flush=True)
        _get_mfutil().mfutil_echo_running()


def echo_clean():
    """Clean waiting status."""
    _get_mfutil().mfutil_echo_clean()
