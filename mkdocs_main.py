from jinja2_shell_extension import shell


def define_env(env):
    env.variables['fabien'] = "test"
    env.filters["shell"] = shell
