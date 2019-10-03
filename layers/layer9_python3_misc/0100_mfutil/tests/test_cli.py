import sys
import os
from contextlib import contextmanager
from unittest import TestCase
from mfutil.cli import echo_ok, echo_nok, echo_warning, echo_bold, \
    echo_running, echo_clean


# see https://stackoverflow.com/questions/5081657/
# how-do-i-prevent-a-c-shared-library-to-print-on-stdout-in-python
@contextmanager
def stdout_redirected(to=os.devnull):
    try:
        fd = sys.stdout.fileno()
    except Exception:
        raise Exception("you must run nosetests with -s flag")

    def _redirect_stdout(to):
        sys.stdout.close()  # + implicit flush()
        os.dup2(to.fileno(), fd)  # fd writes to 'to' file
        sys.stdout = os.fdopen(fd, 'w')  # Python writes to fd

    with os.fdopen(os.dup(fd), 'w') as old_stdout:
        with open(to, 'w') as file:
            _redirect_stdout(to=file)
        try:
            yield  # allow code to be run with the redirected stdout
        finally:
            _redirect_stdout(to=old_stdout)
            # restore stdout.
            # buffering and flags such as
            # CLOEXEC may be different


class TestCaseCli(TestCase):

    def test_echo_ok(self):
        with stdout_redirected(to="/dev/null"):
            echo_ok("foo ok")

    def test_echo_nok(self):
        with stdout_redirected(to="/dev/null"):
            echo_nok("foo nok")

    def test_echo_warning(self):
        with stdout_redirected(to="/dev/null"):
            echo_warning("foo warning")

    def test_echo_bold(self):
        with stdout_redirected(to="/dev/null"):
            echo_bold("foo bold")

    def test_echo_running_clean(self):
        with stdout_redirected(to="/dev/null"):
            echo_running()
            echo_clean()
