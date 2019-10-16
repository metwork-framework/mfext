from unittest import TestCase
from mfutil.layerapi2 import LayerApi2Wrapper


class TestCaseNet(TestCase):

    def test_basic(self):
        x = LayerApi2Wrapper.get_installed_layers()
        self.assertTrue(len(x) > 1)
        for y in x:
            self.assertTrue(len(y.label) > 1)
            self.assertTrue(len(y.home) > 1)
            self.assertTrue(y.home.startswith('/'))
