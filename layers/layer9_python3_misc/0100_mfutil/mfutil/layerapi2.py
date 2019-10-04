"""Utility functions around layerapi2."""

import six
from mfutil.glib2 import Glib2Wrapper
from ctypes import cdll, c_char_p, POINTER, c_char, cast, c_int


class LayerApi2Wrapper(object):

    __lib = None

    @staticmethod
    def __make_instance():
        if LayerApi2Wrapper.__lib is None:
            LayerApi2Wrapper.__lib = cdll.LoadLibrary("liblayerapi2.so")
            LayerApi2Wrapper.__lib.layerapi2_get_layer_home.argtypes = \
                [c_char_p]
            LayerApi2Wrapper.__lib.layerapi2_get_layer_home.restype = \
                POINTER(c_char)
            LayerApi2Wrapper.__lib.layerapi2_init.argtypes = [c_int]
            LayerApi2Wrapper.__lib.layerapi2_init.restype = None
            LayerApi2Wrapper.__lib.layerapi2_destroy.argtypes = []
            LayerApi2Wrapper.__lib.layerapi2_destroy.restype = None
            LayerApi2Wrapper.__lib.layerapi2_init(0)
        # We do this each time to avoid cache issues when creating layers
        LayerApi2Wrapper.__lib.layerapi2_destroy()
        LayerApi2Wrapper.__lib.layerapi2_init(0)

    @staticmethod
    def get_layer_home(label):
        LayerApi2Wrapper.__make_instance()
        tmp = LayerApi2Wrapper.__lib.layerapi2_get_layer_home(six.b(label))
        if tmp is None:
            return None
        res = cast(tmp, c_char_p).value
        Glib2Wrapper.g_free(tmp)
        if res is None:
            return None
        if six.PY2:
            return res
        else:
            return res.decode()
