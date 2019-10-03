import bash
import sys
import logging

# FIXME: to delete


def __get_logger():
    return logging.getLogger("mfutil.deprecated")


class DeprecatedBashWrapper(object):

    __bash_cmd = None
    __bash_result_object = None

    def __init__(self, bash_cmd):
        self.__bash_cmd = bash_cmd
        self.__bash_result_object = bash.bash(bash_cmd)

    def __bool__(self):
        return (self.__bash_result_object.code == 0)

    def __nonzero__(self):
        # python2 compatibility
        return self.__bool__()

    @property
    def code(self):
        return self.__bash_result_object.code

    @property
    def stdout(self):
        return self.__bash_result_object.stdout.strip().decode('UTF-8')

    @property
    def stderr(self):
        return self.__bash_result_object.stderr.strip().decode('UTF-8')

    def __repr__(self):
        result = []
        result.append("")
        result.append("***** BASH COMMAND ***********************")
        result.append(self.__bash_cmd)
        result.append("***** BASH RETURN CODE *******************")
        result.append(str(self.code))
        stdout = self.stdout
        if stdout and len(stdout) > 0:
            result.append("***** BASH STDOUT ************************")
            result.append(self.stdout)
        stderr = self.stderr
        if stderr and len(stderr) > 0:
            result.append("***** BASH STDERR ************************")
            result.append(self.stderr)
        return "\n".join(result)


def get_bash_output_or_die(bash_cmd):
    x = DeprecatedBashWrapper(bash_cmd)
    if not x:
        __get_logger().warning("error during command: [%s], error_code=%i => "
                               "exiting " % (bash_cmd, x.code))
        __get_logger().debug("full output: %s" % x)
        sys.exit(1)
    return x.stdout


def get_bash_output_or_warning(bash_cmd, error_value=None):
    x = DeprecatedBashWrapper(bash_cmd)
    if not x:
        __get_logger().warning("error during command: [%s], error_code=%i" %
                               (bash_cmd, x.code))
        __get_logger().debug("full output: %s" % x)
        return error_value
    return x.stdout
