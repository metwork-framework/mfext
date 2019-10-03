import fastentrypoints  # noqa: F401
from setuptools import setup
from setuptools import find_packages

setup(
    name='mfutil',
    packages=find_packages(),
    entry_points={
        "console_scripts": [
            "get_ip_for_hostname = mfutil.cli_tools.get_ip_for_hostname:main",
            "get_simple_hostname = mfutil.cli_tools.get_simple_hostname:main",
            "get_full_hostname = mfutil.cli_tools.get_full_hostname:main",
            "get_domainname = mfutil.cli_tools.get_domainname:main",
            "get_real_ip = mfutil.cli_tools.get_real_ip:main",
            "plugins.list = mfutil.cli_tools.plugins_list:main",
            "plugins.validate_name = "
            "mfutil.cli_tools.plugins_validate_name:main",
            "plugins.info = mfutil.cli_tools.plugins_info:main",
            "plugins.hash = mfutil.cli_tools.plugins_hash:main",
            "_plugins.init = mfutil.cli_tools.plugins_init:main",
            "_plugins.make = mfutil.cli_tools.plugins_make:main",
            "_plugins.develop = mfutil.cli_tools.plugins_develop:main",
            "plugins.install = mfutil.cli_tools.plugins_install:main",
            "plugins.uninstall = mfutil.cli_tools.plugins_uninstall:main",
            "ping_tcp_port = mfutil.cli_tools.ping_tcp_port:main",
            "recursive_kill.py = mfutil.cli_tools.recursive_kill:main",
        ]
    }
)
