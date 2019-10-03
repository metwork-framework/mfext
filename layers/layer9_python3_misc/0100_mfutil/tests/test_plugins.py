import os
import shutil

from unittest import TestCase
from mfutil.plugins import init_plugins_base, is_plugins_base_initialized, \
    get_installed_plugins, get_plugins_base_dir, get_plugin_info, \
    build_plugin, install_plugin, uninstall_plugin, MFUtilPluginNotInstalled, \
    MFUtilPluginAlreadyInstalled, develop_plugin, validate_plugin_name
from mfutil import get_unique_hexa_identifier

TEST_DIRECTORY = os.path.dirname(os.path.realpath(__file__))


class TestCasePlugins(TestCase):

    base_path = None
    original_metwork_layers_path = None

    def setUp(self):
        self.base_path = os.path.join(TEST_DIRECTORY,
                                      get_unique_hexa_identifier())
        init_plugins_base(self.base_path)
        self.original_metwork_layers_path = os.environ["LAYERAPI2_LAYERS_PATH"]
        os.environ["LAYERAPI2_LAYERS_PATH"] = \
            os.environ["LAYERAPI2_LAYERS_PATH"] + ":%s" % self.base_path

    def tearDown(self):
        shutil.rmtree(self.base_path, True)
        os.system("rm -f *.plugin")
        os.environ["LAYERAPI2_LAYERS_PATH"] = self.original_metwork_layers_path

    def test_validate_plugin_name(self):
        (b, msg) = validate_plugin_name("foo-bar_foo-1_2FOO")
        self.assertTrue(b)
        self.assertTrue(msg is None)
        (b, msg) = validate_plugin_name("plugin_foo-bar_foo-1_2FOO")
        self.assertFalse(b)
        self.assertTrue(len(msg) > 0)
        (b, msg) = validate_plugin_name("foo-bar_foo-1.2FOO")
        self.assertFalse(b)
        self.assertTrue(len(msg) > 0)
        (b, msg) = validate_plugin_name("")
        self.assertFalse(b)
        self.assertTrue(len(msg) > 0)

    def test_is_plugins_base_initialized(self):
        self.assertTrue(is_plugins_base_initialized(self.base_path))

    def test_get_plugins_base_dir(self):
        d = get_plugins_base_dir()
        self.assertTrue(d is not None)

    def test_empty_installed_plugins(self):
        tmp = get_installed_plugins(self.base_path)
        self.assertEquals(len(tmp), 0)

    def test_not_installed_plugin_info(self):
        tmp = get_plugin_info("foo", mode="name",
                              plugins_base_dir=self.base_path)
        self.assertTrue(tmp is None)

    def test_build_plugin(self):
        tmp = build_plugin("%s/data/test_build_plugin" % TEST_DIRECTORY,
                           plugins_base_dir=self.base_path)
        self.assertTrue(tmp is not None)
        b = os.path.basename(tmp)
        d = os.path.dirname(tmp)
        self.assertEquals(d, os.getcwd())
        self.assertEquals(b, "bar-1-1.metwork.%s.plugin" %
                          os.environ['MFMODULE_LOWERCASE'])

    def test_install_plugin(self):
        tmp = build_plugin("%s/data/test_build_plugin" % TEST_DIRECTORY,
                           plugins_base_dir=self.base_path)
        self.assertTrue(tmp is not None)
        install_plugin(tmp, plugins_base_dir=self.base_path)
        tmp = get_plugin_info("bar", mode="name",
                              plugins_base_dir=self.base_path)
        self.assertTrue(tmp is not None)
        self.assertEquals(tmp['metadatas']['name'], 'bar')
        uninstall_plugin("bar", plugins_base_dir=self.base_path)

    def test_duplicate_install_plugin(self):
        tmp = build_plugin("%s/data/test_build_plugin" % TEST_DIRECTORY,
                           plugins_base_dir=self.base_path)
        self.assertTrue(tmp is not None)
        install_plugin(tmp, plugins_base_dir=self.base_path)
        try:
            install_plugin(tmp, plugins_base_dir=self.base_path)
            raise Exception("MFUtilPluginAlreadyInstalled not raised")
        except MFUtilPluginAlreadyInstalled:
            pass

    def test_develop_plugin(self):
        develop_plugin("%s/data/test_build_plugin" % TEST_DIRECTORY,
                       "bar", plugins_base_dir=self.base_path)
        tmp = get_plugin_info("bar", mode="name",
                              plugins_base_dir=self.base_path)
        self.assertTrue(tmp is not None)
        self.assertEquals(tmp['metadatas']['name'], 'bar')
        self.assertEquals(tmp['metadatas']['version'], 'dev_link')
        self.assertEquals(tmp['metadatas']['release'], 'dev_link')
        uninstall_plugin("bar", plugins_base_dir=self.base_path)

    def test_uninstall_not_existing_plugin(self):
        try:
            uninstall_plugin("foo", plugins_base_dir=self.base_path)
            raise Exception("MFUtilPluginNotInstalled not raised")
        except MFUtilPluginNotInstalled:
            pass
