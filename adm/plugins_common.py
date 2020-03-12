import os
import envtpl
from opinionated_configparser import OpinionatedConfigParser
from mfext.ini_to_env import make_env_var_dict
from mfutil.plugins import layerapi2_label_to_plugin_name
from mfutil.layerapi2 import LayerApi2Wrapper

MFMODULE_RUNTIME_HOME = os.environ['MFMODULE_RUNTIME_HOME']
MFEXT_HOME = os.environ["MFEXT_HOME"]
MFMODULE = os.environ['MFMODULE']
MFMODULE_LOWERCASE = os.environ['MFMODULE_LOWERCASE']
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


def get_plugin_env_prefix(plugin_name):
    return "%s_PLUGIN_%s" % (MFMODULE, plugin_name.upper())


def get_plugin_env(plugin_name, section, key):
    return "%s_%s_%s" % (get_plugin_env_prefix(plugin_name), section.upper(),
                         key.upper())


def get_plugin_env_value_or_config(parser, section, plugin_name, key,
                                   default=None):
    env = get_plugin_env(plugin_name, section, key)
    if env is os.environ:
        return os.environ[env]
    if parser.has_option(section, key):
        return parser.get(section, key)
    return default


def get_rlimit_conf(parser, section, plugin_name):
    # FIXME: in 0.11, remove reading from configuration file
    conf = {}
    for key1, key2 in [("as", "rlimit_as"), ("nofile", "rlimit_nofile"),
                       ("nproc", "rlimit_nproc"), ("stack", "rlimit_stack"),
                       ("core", "rlimit_core"), ("fsize", "rlimit_fsize")]:
        tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                             key2)
        if tmp is not None:
            conf[key1] = int(tmp)
    return conf


def get_split_conf(logger, parser, section, plugin_name):
    # FIXME: in 0.11, remove reading from configuration file
    split_stdout_stderr = False
    split_multiple_workers = False
    tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                         "log_split_stdout_stderr")
    if tmp is None:
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
    tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                         "log_split_multiple_workers")
    if tmp is None:
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


def get_plugin_format_version(logger, plugin_directory, plugin_name):
    try:
        with open("%s/.plugin_format_version" % plugin_directory, "r") as f:
            c = f.read().strip()
        tmp = c.split('.')
        res = []
        for t in tmp:
            try:
                res.append(int(t))
            except Exception:
                res.append(9999)
        return res
    except Exception:
        if logger:
            logger.warning("Deprecated config.ini format => "
                           "it's still ok for this release but it won't work "
                           "anymore with mfserv 0.11 release")
        return [0, 0, 0]


def get_workers(logger, parser, section, plugin_name):
    # FIXME: in 0.11, remove reading from configuration file
    workers = 0
    tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                         "numprocesses")
    if tmp is not None:
        return int(tmp)
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
    extra_conf.update(get_split_conf(logger, parser, section, plugin_name))
    workers = get_workers(logger, parser, section, plugin_name)
    extra_conf["numprocesses"] = workers
    cmd_and_args = parser.get(section, "cmd_and_args")
    extra_conf["name"] = \
        "extra_daemon_%s_for_plugin_%s" % (extra_daemon, plugin_name)
    extra_conf["rlimits"] = get_rlimit_conf(parser, section, plugin_name)
    extra_conf["graceful_timeout"] = 30
    extra_conf["max_age"] = 0
    # FIXME: in 0.11, remove reading from configuration file
    tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                         "max_age")
    if tmp is not None:
        extra_conf["max_age"] = int(tmp)
    else:
        if parser.has_option(section, "max_age"):
            extra_conf["max_age"] = parser.getint(section, "max_age")
    tmp = get_plugin_env_value_or_config(parser, section, plugin_name,
                                         "graceful_timeout")
    if tmp is not None:
        extra_conf["graceful_timeout"] = int(tmp)
    else:
        if parser.has_option(section, "graceful_timeout"):
            extra_conf["graceful_timeout"] = \
                parser.getint(section, "graceful_timeout")
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


def _get_plugin_env_dict(plugin_home, plugin_name):
    # FIXME: remove external_plugins paths in 0.11
    env_var_dict = {}
    if get_plugin_format_version(None, plugin_home, plugin_name) >= [0, 10, 0]:
        paths = [
            "%s/%s.ini" % (plugin_home, "config"),
            "%s/config/external_plugins/%s.ini" % (MFMODULE_RUNTIME_HOME,
                                                   plugin_name),
            "%s/config/plugins/%s.ini" % (MFMODULE_RUNTIME_HOME, plugin_name),
            "/etc/metwork.config.d/%s/external_plugins/%s.ini" %
            (MFMODULE_LOWERCASE, plugin_name),
            "/etc/metwork.config.d/%s/plugins/%s.ini" %
            (MFMODULE_LOWERCASE, plugin_name)
        ]
        env_var_dict = make_env_var_dict(
            None,
            "%s_PLUGIN_%s" % (MFMODULE, plugin_name.upper()),
            paths,
            legacy_env=False, legacy_file_inclusion=False,
            generation_time=False, resolve=True
        )
    env_var_dict["%s_CURRENT_PLUGIN_NAME" % MFMODULE] = plugin_name
    env_var_dict["%s_CURRENT_PLUGIN_DIR" % MFMODULE] = plugin_home
    env_var_dict["%s_CURRENT_PLUGIN_LABEL" % MFMODULE] = \
        "plugin_%s@%s" % (plugin_name, MFMODULE_LOWERCASE)
    return env_var_dict


def get_plugin_env_dict(plugin_home, plugin_name):
    lines = []
    res = {}
    try:
        with open("%s/.layerapi2_dependencies" % plugin_home, "r") as f:
            lines = f.readlines()
    except Exception:
        pass
    for line in lines:
        tmp = line.strip()
        if tmp.startswith('-'):
            tmp = tmp[1:]
        if tmp.startswith("plugin_"):
            home = LayerApi2Wrapper.get_layer_home(tmp)
            name = get_plugin_name_from_plugin_home(home)
            if home and name:
                res.update(get_plugin_env_dict(home, name))
    res.update(_get_plugin_env_dict(plugin_home, plugin_name))
    return res


def set_plugin_env(plugin_home, plugin_name):
    env_var_dict = get_plugin_env_dict(plugin_home, plugin_name)
    for k, v in env_var_dict.items():
        os.environ[k] = v


def get_plugin_name_from_plugin_home(plugin_home):
    try:
        with open(os.path.join(plugin_home, ".layerapi2_label"), "r") as f:
            label = f.read().strip()
    except Exception:
        return None
    try:
        plugin_name = layerapi2_label_to_plugin_name(label)
    except Exception:
        return None
    return plugin_name


def get_plugin_parser(plugin_home, plugin_name, **kwargs):
    config_ini = os.path.join(plugin_home, "config.ini")
    parser = OpinionatedConfigParser(**kwargs)
    # FIXME: remove __ special handling
    parser.optionxform = lambda x: x[1:].lower() \
        if x.startswith('_') and not x.startswith('__') else x.lower()
    if os.path.exists(config_ini):
        parser.read(config_ini)
        return parser
    raise Exception("can't find config.ini file in plugin directory: %s "
                    "=> broken plugin?" % plugin_home)
