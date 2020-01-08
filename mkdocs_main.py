from jinja2_shell_extension import shell
from jinja2_getenv_extension import getenv
from jinja2_fnmatch_extension import _fnmatch
from jinja2_from_json_extension import from_json


def define_env(env):
    env.variables['components'] = "../850-components"
    env.variables['installation_guide'] = "../100-installation_guide"
    env.filters["shell"] = shell
    env.filters["getenv"] = getenv
    env.filters["fnmatch"] = _fnmatch
    env.filters["from_json"] = from_json
