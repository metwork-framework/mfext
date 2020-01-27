import os
import envtpl
from opinionated_configparser import OpinionatedConfigParser

MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
MFEXT_HOME = os.environ["MFEXT_HOME"]
MFMODULE = os.environ['MFMODULE']
if MFMODULE == "MFSERV":
    DEPRECATED_IGNORED_GENERAL_OPTIONS = ["extra_nginx_conf_filename", "name"]
    DEPRECATED_IGNORED_APP_OPTIONS = ["proxy_timeout", "graceful_timeout"]
    DEPRECATED_GENERAL_OPTIONS = ["redis_service"]
    DEPRECATED_APP_OPTIONS = []
else:
    DEPRECATED_IGNORED_GENERAL_OPTIONS = ["name"]
    DEPRECATED_IGNORED_APP_OPTIONS = ["max_age_variance", "graceful_timeout"]
    DEPRECATED_GENERAL_OPTIONS = ["redis_service"]
    DEPRECATED_APP_OPTIONS = []


def get_unix_socket_name(plugin_name, app_name, worker, hot_swap_prefix=''):
    return (
        f"{MFMODULE_RUNTIME_HOME}/var/"
        f"app_{hot_swap_prefix}{plugin_name}_{app_name}_{worker}.socket"
    )


def get_current_step_queue(plugin_name, step_name):
    return "step.%s.%s" % (plugin_name, step_name)


def get_cmd_and_args(cmd_and_args, plugin_conf, app_conf,
                     use_signal_wrapper=True):
    tmp = cmd_and_args
    for modifier in (lambda x: ("{%s}" % x).lower(),
                     lambda x: ("{%s}" % x).upper(),
                     lambda x: x.lower(), lambda x: x.upper()):
        tmp = tmp.replace(modifier("{timeout}"),
                          str(app_conf.get("timeout", 300)))
        tmp = tmp.replace(modifier("{%s_CURRENT_PLUGIN_NAME}" % MFMODULE),
                          plugin_conf["name"])
        tmp = tmp.replace(modifier("{%s_CURRENT_PLUGIN_DIR}" % MFMODULE),
                          plugin_conf["dir"])
        tmp = tmp.replace(modifier("{%s_CURRENT_STEP_NAME}" % MFMODULE),
                          app_conf["name"])
        tmp = tmp.replace(modifier("{%s_CURRENT_APP_NAME}" % MFMODULE),
                          app_conf["name"])
        tmp = tmp.replace(modifier("{%s_CURRENT_STEP_QUEUE}" % MFMODULE),
                          get_current_step_queue(plugin_conf["name"],
                                                 app_conf["name"]))
        tmp = tmp.replace(modifier("{%s_CURRENT_CONFIG_INI_PATH}" % MFMODULE),
                          "%s/config.ini" % plugin_conf["dir"])
        tmp = tmp.replace(modifier("{plugin_name}"), plugin_conf["name"])
        tmp = tmp.replace(modifier("{app_name}"), app_conf["name"])
        tmp = tmp.replace(modifier("{step_name}"), app_conf["name"])
        tmp = tmp.replace(modifier("{plugin_dir}"), plugin_conf["dir"])
        tmp = tmp.replace(modifier("{debug_extra_options}"),
                          app_conf.get("debug_extra_options", ""))
        hsp = plugin_conf.get("hot_swap_prefix", "")
        unix_socket = get_unix_socket_name(plugin_conf["name"],
                                           app_conf["name"],
                                           "$(circus.wid)", hsp)
        tmp = tmp.replace(modifier("{unix_socket_path}"), unix_socket)
    log_proxy_args = \
        get_log_proxy_args("app", plugin_conf['name'], app_conf['name'],
                           app_conf.get("split_multiple_workers", False),
                           app_conf.get("split_stdout_stderr", False),
                           app_conf.get("numprocesses", "1"))
    layer_wrapper_extra_args = get_layer_wrapper_extra_args(
        plugin_conf['name'], plugin_conf['dir'], app_conf['name'],
        apdtpp=app_conf.get('add_plugin_dir_to_python_path', True),
        aadtpp=app_conf.get('add_app_dir_to_python_path', False))
    if use_signal_wrapper:
        tmp = "signal_wrapper.py --timeout=%i --signal=%i " \
            "--timeout-after-signal=%i --socket-up-after=%i %s -- %s" % (
                app_conf.get("timeout", 300),
                app_conf.get("smart_stop_signal", 15),
                app_conf.get("smart_stop_delay", 10),
                app_conf.get("smart_start_delay", 3),
                unix_socket, tmp)
    return (
        f"{log_proxy_args} -- plugin_wrapper "
        f"{layer_wrapper_extra_args} -- {tmp}"
    )


def get_rlimit_conf(parser, section):
    conf = {}
    if parser.has_option(section, "rlimit_as"):
        conf["as"] = parser.getint(section, "rlimit_as")
    if parser.has_option(section, "rlimit_nofile"):
        conf["nofile"] = parser.getint(section, "rlimit_nofile")
    if parser.has_option(section, "rlimit_nproc"):
        conf["nproc"] = parser.getint(section, "rlimit_nproc")
    if parser.has_option(section, "rlimit_stack"):
        conf["stack"] = parser.getint(section, "rlimit_stack")
    if parser.has_option(section, "rlimit_core"):
        conf["core"] = parser.getint(section, "rlimit_core")
    if parser.has_option(section, "rlimit_fsize"):
        conf["fsize"] = parser.getint(section, "rlimit_fsize")
    return conf


def get_split_conf(logger, parser, section):
    split_stdout_stderr = False
    if parser.has_option(section, "log_split_stdout_stderr"):
        tmp = parser.get(section, "log_split_stdout_stderr")
        if tmp == "AUTO":
            global_conf = \
                os.environ["%s_LOG_TRY_TO_SPLIT_STDOUT_STDERR" % MFMODULE]
            split_stdout_stderr = (global_conf == "1")
        elif tmp == "1":
            split_stdout_stderr = True
        elif tmp == "0":
            split_stdout_stderr = False
        else:
            logger.warning("invalid value for log_split_stdout_stderr: "
                           "%s => ignoring" % tmp)
    split_multiple_workers = False
    if parser.has_option(section, "log_split_multiple_workers"):
        tmp = parser.get(section, "log_split_multiple_workers")
        if tmp == "AUTO":
            global_conf = \
                os.environ["%s_LOG_TRY_TO_SPLIT_MULTIPLE_WORKERS" % MFMODULE]
            split_multiple_workers = (global_conf == "1")
        elif tmp == "1":
            split_multiple_workers = True
        elif tmp == "0":
            split_multiple_workers = False
        else:
            logger.warning("invalid value for log_split_multiple_workers: "
                           "%s => ignoring" % tmp)
    return {
        "split_stdout_stderr": split_stdout_stderr,
        "split_multiple_workers": split_multiple_workers
    }


def get_plugin_format_version(logger, parser):
    if not parser.has_option("general", "__version"):
        if logger is not None:
            logger.warning("Deprecated config.ini format => "
                           "it's still ok for this release but it won't work "
                           "anymore with mfserv 0.11 release")
        return 0
    else:
        return int(parser.get("general", "__version"))


def get_workers(logger, parser, section):
    workers = 0
    if parser.has_option(section, "numprocesses"):
        workers = \
            int(envtpl.render_string(parser.get(section, "numprocesses"),
                                     keep_multi_blank_lines=False))
    if workers == 0 and parser.has_option(section, "workers"):
        logger.warning("the workers option is deprecated => "
                       "use numprocesses instead")
        workers = int(envtpl.render_string(parser.get(section, "workers"),
                                           keep_multi_blank_lines=False))
    return workers


def get_layer_wrapper_extra_args(plugin_name, plugin_dir, app=None,
                                 apdtpp=False, aadtpp=False):
    layer_wrapper_extra_args = plugin_name
    if not apdtpp:
        layer_wrapper_extra_args = layer_wrapper_extra_args + \
            " --do-not-add-plugin-dir-to-python-path"
    if aadtpp and app:
        app_dir = os.path.join(plugin_dir, app)
        layer_wrapper_extra_args = layer_wrapper_extra_args + \
            " --add-extra-dir-to-python-path=%s" % app_dir
    return layer_wrapper_extra_args.strip()


def get_log_proxy_args(prefix, plugin_name, app=None,
                       split_multiple_workers=False,
                       split_stdout_stderr=True,
                       numprocesses=None):
    if split_multiple_workers:
        if app:
            std_prefix = \
                "%s/log/%s_%s_%s_worker$(circus.wid)" % \
                (MFMODULE_RUNTIME_HOME, prefix, plugin_name, app)
        else:
            std_prefix = \
                "%s/log/%s_%s_worker$(circus.wid)" % \
                (MFMODULE_RUNTIME_HOME, prefix, plugin_name)
    else:
        if app:
            std_prefix = "%s/log/%s_%s_%s" % \
                (MFMODULE_RUNTIME_HOME, prefix, plugin_name, app)
        else:
            std_prefix = "%s/log/%s_%s" % \
                (MFMODULE_RUNTIME_HOME, prefix, plugin_name)
    if numprocesses == "1" or numprocesses == 1:
        use_locks = ""
    else:
        use_locks = "--use-locks"
    if split_stdout_stderr:
        res = "%s --stdout %s.stdout " \
            "--stderr %s.stderr" % (use_locks, std_prefix, std_prefix)
    else:
        res = "%s --stdout %s.log " \
            "--stderr STDOUT" % (use_locks, std_prefix)
    return res.strip()


def test_deprecated_options(logger, parser, section=None):
    if section is None:
        ignored_options = DEPRECATED_IGNORED_GENERAL_OPTIONS
        options = DEPRECATED_GENERAL_OPTIONS
        section = "general"
    else:
        ignored_options = DEPRECATED_IGNORED_APP_OPTIONS
        options = DEPRECATED_APP_OPTIONS
    for option in ignored_options:
        if parser.has_option(section, option):
            logger.warning(
                "%s option in [%s] section is DEPRECATED => ignoring" %
                (option, section))
    for option in ignored_options:
        if parser.has_option(section, option):
            logger.warning(
                "%s option in [%s] section is DEPRECATED => ignoring" %
                (option, section))
    for option in options:
        if parser.has_option(section, option):
            logger.warning(
                "%s option in [%s] section is DEPRECATED => "
                "it will be removed in next release" %
                (option, section))


def get_extra_daemon_conf(logger, parser, section, extra_daemon, plugin_conf):
    plugin_name = plugin_conf["name"]
    extra_conf = {}
    extra_conf.update(get_split_conf(logger, parser, section))
    workers = get_workers(logger, parser, section)
    extra_conf["numprocesses"] = workers
    cmd_and_args = parser.get(section, "cmd_and_args")
    extra_conf["name"] = \
        "extra_daemon_%s_for_plugin_%s" % (extra_daemon, plugin_name)
    extra_conf["rlimits"] = get_rlimit_conf(parser, section)
    extra_conf["graceful_timeout"] = 30
    extra_conf["max_age"] = 0
    if parser.has_option(section, "graceful_timeout"):
        extra_conf["graceful_timeout"] = \
            parser.getint(section, "graceful_timeout")
    if parser.has_option(section, "max_age"):
        extra_conf["max_age"] = parser.getint(section, "max_age")
    extra_conf["cmd_args"] = get_cmd_and_args(cmd_and_args, plugin_conf,
                                              extra_conf, False)
    return extra_conf


# DEPRECATED
def get_redis_service_extra_conf(logger, parser, plugin_conf):
    extra_conf = {}
    plugin_name = plugin_conf["name"]
    extra_conf["name"] = "redis_service_for_plugin_%s" % plugin_name
    extra_conf["numprocesses"] = 1
    extra_conf["max_age"] = 0
    extra_conf["graceful_timeout"] = 10
    extra_conf["rlimits"] = {}
    extra_conf["debug"] = False
    cmd_and_args = \
        "redis-server %s/tmp/config_auto/redis_plugin_%s.conf" % (
            MFMODULE_RUNTIME_HOME, plugin_name)
    extra_conf["cmd_args"] = get_cmd_and_args(cmd_and_args, plugin_conf,
                                              extra_conf, False)
    with open("%s/tmp/config_auto/redis_plugin_%s.conf" %
              (MFMODULE_RUNTIME_HOME, plugin_name), "w+") as f:
        with open("%s/share/templates/redis_plugin_xxx.conf" % MFEXT_HOME,
                  "r") as f2:
            content = f2.read()
        new_content = envtpl.render_string(content,
                                           {"PLUGIN_NAME": plugin_name},
                                           keep_multi_blank_lines=False)
        f.write(new_content)
    return extra_conf


def get_plugin_parser(plugin_home, plugin_name, **kwargs):
    config_ini = os.path.join(plugin_home, "config.ini")
    metadata_ini = os.path.join(plugin_home, "metadata.ini")
    plugin_ini = os.path.join(plugin_home, plugin_name + ".ini")
    parser = OpinionatedConfigParser(**kwargs)
    if os.path.exists(config_ini):
        parser.read(config_ini)
        return parser
    if not os.path.exists(metadata_ini) or not os.path.exists(plugin_ini):
        raise Exception("can't find %s and %s "
                        "in plugin directory: %s => broken plugin?" %
                        (metadata_ini, plugin_ini, plugin_home))
    parser.read(metadata_ini)
    parser.read(plugin_ini)
    return parser
