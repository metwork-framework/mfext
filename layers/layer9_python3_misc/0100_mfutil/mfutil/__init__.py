"""Generic utility classes and functions."""

import uuid
import errno
import os
import logging
import tempfile
import socket
import bash
import psutil
import pickle
import hashlib
import datetime
import time
import fnmatch

# FIXME: deprecated
from mfutil.deprecated import get_bash_output_or_die  # noqa: F401
from mfutil.deprecated import get_bash_output_or_warning  # noqa: F401

from inotify_simple import flags


class MFUtilException(Exception):
    """Just a custom exception object dedicated for mfutil package."""


def __get_logger():
    return logging.getLogger("mfutil")


def get_unique_hexa_identifier():
    """Return an unique hexa identifier on 32 bytes.

    The idenfier is made only with 0123456789abcdef
    characters.

    Returns:
        (string) unique hexa identifier.

    """
    return str(uuid.uuid4()).replace('-', '')


def get_utc_unix_timestamp():
    """Return the current unix UTC timestamp on all platforms.

    It works even if the machine is configured in local time.

    Returns:
        (int) a int corresponding to the current unix utc timestamp.

    """
    dts = datetime.datetime.utcnow()
    return int(time.mktime(dts.timetuple()))


def mkdir_p(path, nodebug=False, nowarning=False):
    """Make a directory recursively (clone of mkdir -p).

    Thanks to http://stackoverflow.com/questions/600268/
        mkdir-p-functionality-in-python .

    Any exceptions are catched and a warning message
    is logged in case of problems.

    If the directory already exists, True is returned
    with no debug or warning.

    Args:
        path (string): complete path to create.
        nodebug (boolean): if True, no debug messages are logged.
        nowarning (boolean): if True, no message are logged in
            case of problems.

    Returns:
        boolean: True if the directory exists at the end.

    """
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            return True
        else:
            if not nowarning:
                __get_logger().warning("can't create %s directory", path)
            return False
    if not nodebug:
        __get_logger().debug("%s directory created", path)
    return True


def mkdir_p_or_die(path, nodebug=False, exit_code=2):
    """Make a directory recursively (clone of mkdir -p).

    If the directory already exists, True is returned
    with no debug or warning.

    Any exceptions are catched.

    In case of problems, the program dies here with corresponding
    exit_code.

    Args:
        path (string): complete path to create.
        nodebug (boolean): if True, no debug messages are logged.
        exit_code (int): os._exit() exit code.

    """
    res = mkdir_p(path, nodebug=nodebug, nowarning=True)
    if not res:
        __get_logger().error("can't create %s directory", path)
        os._exit(exit_code)


def _get_temp_dir(tmp_dir=None):
    """Return system temp dir or used choosen temp dir.

    If the user provides a tmp_dir argument, the
    directory is created (if necessary).

    If the user don't provide a tmp_dir argument,
    the function returns a system temp dir.

    If the directory is not good or can be created,
    an exception is raised.

    Args:
        tmp_dir (string): user provided tmp directory (None
            to use the system temp dir).

    Returns:
        (string) temp directory

    Raises:
        MFUtilException if the temp directory is not good or can't
            be created.

    """
    if tmp_dir is None:
        tmp_dir = tempfile.gettempdir()
    res = mkdir_p(tmp_dir)
    if not res:
        raise MFUtilException("can't create temp_dir: %s", tmp_dir)
    return tmp_dir


def get_tmp_filepath(tmp_dir=None, prefix=""):
    """Return a tmp (complete) filepath.

    The filename is made with get_unique_hexa_identifier() identifier
    so 32 hexa characters.

    The dirname can be provided by the user (or be a system one).
    He will be created if necessary. An exception can be raised if any
    problems at this side.

    Note: the file is not created or open at all. The function just
    returns a filename.

    Args:
        tmp_dir (string): user provided tmp directory (None
            to use the system temp dir).
        prefix (string): you can add here a prefix for filenames
            (will be preprended before the 32 hexa characters).

    Returns:
        (string) tmp (complete) filepath.

    Raises:
        MFUtilException if the temp directory is not good or can't
            be created.

    """
    temp_dir = _get_temp_dir(tmp_dir)
    return os.path.join(temp_dir, prefix + get_unique_hexa_identifier())


def create_tmp_dirpath(tmp_dir=None, prefix=""):
    """Create and return a temporary directory inside a father tempory directory.

    The dirname is made with get_unique_hexa_identifier() identifier
    so 32 hexa characters.

    The father dirname can be provided by the user (or be a system one).
    He will be created if necessary. An exception can be raised if any
    problems at this side.

    Note: the temporary directory is created.

    Args:
        tmp_dir (string): user provided tmp directory (None
            to use the system temp dir).
        prefix (string): you can add here a prefix for dirnames
            (will be preprended before the 32 hexa characters).

    Returns:
        (string) complete path of a newly created temporary directory.

    Raises:
        MFUtilException if the temp directory can't be created.

    """
    temp_dir = _get_temp_dir(tmp_dir)
    new_temp_dir = os.path.join(temp_dir,
                                prefix + get_unique_hexa_identifier())
    res = mkdir_p(new_temp_dir, nowarning=True)
    if not res:
        raise MFUtilException("can't create temp_dir: %s", new_temp_dir)
    return new_temp_dir


def get_ipv4_for_hostname(hostname, static_mappings={}):
    """Translate a host name to IPv4 address format.

    The IPv4 address is returned as a string, such as '100.50.200.5'.
    If the host name is an IPv4 address itself it is returned unchanged.

    You can provide a dictionnary with static mappings.
    Following mappings are added by default:
    '127.0.0.1' => '127.0.0.1'
    'localhost' => '127.0.0.1'
    'localhost.localdomain' => '127.0.0.1'

    Args:
        hostname (string): hostname.
        static_mappings (dict): dictionnary of static mappings
            ((hostname) string: (ip) string).

    Returns:
        (string) IPv4 address for the given hostname (None if any problem)

    """
    hostname = hostname.lower()
    static_mappings.update({'127.0.0.1': '127.0.0.1', 'localhost': '127.0.0.1',
                            'localhost.localdomain': '127.0.0.1'})
    if hostname in static_mappings:
        return static_mappings[hostname]
    try:
        return socket.gethostbyname(hostname)
    except Exception:
        return None


def get_recursive_mtime(directory, ignores=[]):
    """Get the latest mtime recursivly on a directory.

    Args:
        directory (string): complete path of a directory to scan.
        ignores (list of strings): list of shell-style wildcards
            to define which filenames/dirnames to ignores (see fnmatch).

    Returns:
        (int) timestamp of the latest mtime on the directory.

    """
    result = 0
    for name in os.listdir(directory):
        ignored = False
        for ssw in ignores:
            if fnmatch.fnmatch(name, ssw):
                ignored = True
                break
        if ignored:
            continue
        fullpath = os.path.join(directory, name)
        if os.path.isdir(fullpath):
            mtime = get_recursive_mtime(fullpath, ignores=ignores)
        else:
            mtime = 0
            try:
                mtime = int(os.path.getmtime(fullpath))
            except Exception:
                pass
        if mtime > result:
            result = mtime
    return result


def add_inotify_watch(inotify, directory, ignores=[]):
    """Register recursively directories to watch.

    Args:
        inotify (inotify object): object that owns the file descriptors
        directory (string): complete path of a directory to scan.
        ignores (list of strings): list of shell-style wildcards
        to define which filenames/dirnames to ignores (see fnmatch).

    """
    watch_flags = flags.MODIFY | flags.CREATE |\
        flags.DELETE | flags.DELETE_SELF
    try:
        __get_logger().info("watch %s" % directory)
        inotify.add_watch(directory, watch_flags)
    except Exception as e:
        __get_logger().warning("cannot watch %s: %s" % (directory, e))

    if not os.access(directory, os.R_OK):
        __get_logger().warning("cannot enter into %s" % directory)
        return

    for name in os.listdir(directory):
        ignored = False
        for ssw in ignores:
            if fnmatch.fnmatch(name, ssw):
                ignored = True
                break
        if ignored:
            continue
        fullpath = os.path.join(directory, name)
        if os.path.isdir(fullpath):
            add_inotify_watch(inotify, fullpath, ignores=ignores)


class BashWrapperException(Exception):
    """Specific exception class for BashWrapper objects."""

    __message = None
    __bash_wrapper = None

    def __init__(self, message, bash_wrapper=None):
        """Constructor.

        Args:
            message (string): exception message
            bash_wrapper (BashWrapper): bash wrapper object

        """
        super(BashWrapperException, self).__init__(message)
        self.__message = message
        self.__bash_wrapper = bash_wrapper

    def __repr__(self):
        if self.__bash_wrapper is not None:
            return "BashWrapperException with message: %s and debug: %s" % \
                (self.__message, self.__bash_wrapper)
        else:
            return "BashWrapperException with message: %s" % self.__message

    def __str__(self):
        return self.__repr__()


class BashWrapper(object):
    """Bash command/output wrapper."""

    __bash_cmd = None
    __bash_result_object = None

    def __init__(self, bash_cmd):
        """Constructor.

        The constructor executes the given bash command and store result code
        and stdout/stderr inside the object.

        You can use this object like this::

            bash_wrapper = BashWrapper("ls /tmp")
            if bash_wrapper:
                print("execution was ok (status_code == 0)")
            else:
                print("execution was not ok (status_code != 0)")
            status_code = bash_wrapper.code
            stdout_output = bash_wrapper.stdout
            stderr_output = bash_wrapper.stderr
            print("full representation with command/code/stdout/stderr: %s" %
                  bash_wapper)

        Args:
            bash_cmd (string): complete bash command to execute.

        """
        self.__bash_cmd = bash_cmd
        self.__bash_result_object = bash.bash(bash_cmd)

    def __bool__(self):
        return (self.__bash_result_object.code == 0)

    def __nonzero__(self):
        # python2 compatibility
        return self.__bool__()

    @property
    def code(self):
        """Return the status code of the command as int (0 => ok)."""
        return self.__bash_result_object.code

    @property
    def stdout(self):
        """Return the stdout output of the command stripped and utf8 decoded.

        Returns:
            (string) stdout output (stripped and utf8 decoded).

        """
        return self.__bash_result_object.stdout.strip().decode('UTF-8')

    @property
    def stderr(self):
        """Return the stderr output of the command stripped and utf8 decoded.

        Returns:
            (string) stderr output (stripped and utf8 decoded).

        """
        return self.__bash_result_object.stderr.strip().decode('UTF-8')

    def __repr__(self):
        result = []
        result.append("")
        result.append("===== BASH COMMAND =======================")
        result.append(self.__bash_cmd)
        result.append("===== BASH RETURN CODE ===================")
        result.append(str(self.code))
        stdout = self.stdout
        if stdout and len(stdout) > 0:
            result.append("===== BASH STDOUT ========================")
            result.append(self.stdout)
        stderr = self.stderr
        if stderr and len(stderr) > 0:
            result.append("===== BASH STDERR ========================")
            result.append(self.stderr)
        return "\n".join(result)


class BashWrapperOrRaise(BashWrapper):
    """BashWrapper subclass which raise an exception if status_code != 0."""

    def __init__(self, bash_cmd, exception_class=BashWrapperException,
                 exception_msg="bad return code"):
        """Constructor.

        The constructor executes the given bash command and store result code
        and stdout/stderr inside the object.

        If the status_code is != 0, an exception is raised with all
        informations (stdout/stderr/code) inside.

        If the status_code is 0, you can use this object like a BashWrapper
        one.

        Example::

            try:
                x = BashWrapperOrRaise("ls /foo/bar")
            except BashWrapperException as e:
                print("exception with all details: %s" % e)
            else:
                # here, we have x.code == 0
                print("stdout: %s" % x.stdout)

        Args:
            bash_cmd (string): complete bash command to execute.
            exception_class (BashWrapperException): exception class to raise
                in case of status_code !=0 (must be a subclass of
                BashWrapperException).
            exception_msg (string): exception message in case of
                status_code != 0.

        """
        super(BashWrapperOrRaise, self).__init__(bash_cmd)
        if self.code != 0:
            raise exception_class(exception_msg, self)


def _kill_process_and_children(process):
    children = None
    try:
        children = process.children(recursive=False)
    except psutil.NoSuchProcess:
        pass
    try:
        process.kill()
    except psutil.NoSuchProcess:
        pass
    if children is not None:
        for child in children:
            _kill_process_and_children(child)


def kill_process_and_children(pid):
    """Kill recursively a complete tree of processes.

    Given a pid, this method recursively kills the complete tree (children and
    children of each child...) of this process.

    The SIGKILL signal is used.

    Args:
        pid (int): process PID to kill.

    """
    try:
        process = psutil.Process(pid)
    except psutil.NoSuchProcess:
        return
    _kill_process_and_children(process)


def hash_generator(*args):
    """Generate a hash from a variable number of arguments as a safe string.

    Note that pickle is used so arguments have to be serializable.

    Args:
        *args: arguments to hash

    """
    temp = pickle.dumps(args, pickle.HIGHEST_PROTOCOL)
    return hashlib.md5(temp).hexdigest()
