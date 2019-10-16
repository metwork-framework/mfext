"""Utility functions around layerapi2."""

import six
from mfutil.glib2 import Glib2Wrapper, GSListPointer
from ctypes import cdll, c_char_p, POINTER, c_char, cast, c_int, c_bool, \
    Structure


class _CLayer(Structure):

    _fields_ = [("loaded", c_int), ("home", c_char_p), ("label", c_char_p),
                ("dependencies", GSListPointer),
                ("conflicts", GSListPointer)]


def _utf8_decode(b):
    if b is None:
        return None
    if six.PY2:
        return b
    else:
        return b.decode('utf8')


class Layer(object):

    home = None
    label = None
    loaded = None
    dependencies = None
    conflicts = None

    @staticmethod
    def _make_layer_from_pointer(ptr):
        res = Layer()
        clayer = cast(ptr, POINTER(_CLayer))
        res.home = _utf8_decode(clayer.contents.home)
        res.label = _utf8_decode(clayer.contents.label)
        res.loaded = (clayer.contents.loaded == 1)
        deps = clayer.contents.dependencies
        res.dependencies = \
            Layer._gslist_of_c_char_p_to_python_list(deps)
        res.conflicts = \
            Layer._gslist_of_c_char_p_to_python_list(clayer.contents.conflicts)
        return res

    @staticmethod
    def _make_layers_from_pointer(ptr):
        if not ptr:
            return []
        layers = []
        iptr = ptr
        while True:
            data = iptr.contents.data
            if not data:
                break
            layer = Layer._make_layer_from_pointer(data)
            layers.append(layer)
            if not iptr.contents.next:
                break
            iptr = iptr.contents.next
        return layers

    @staticmethod
    def _gslist_of_c_char_p_to_python_list(ptr):
        if not ptr:
            return []
        res = []
        while True:
            data = ptr.contents.data
            if not data:
                break
            res.append(_utf8_decode(cast(data, c_char_p).value))
            if not ptr.contents.next:
                break
            ptr = ptr.contents.next
        return res


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
            LayerApi2Wrapper.__lib.layerapi2_destroy.restype = c_bool
            LayerApi2Wrapper.__lib.layerapi2_is_layer_installed.argtypes = \
                [c_char_p]
            LayerApi2Wrapper.__lib.layerapi2_is_layer_installed.restype = \
                c_int
            LayerApi2Wrapper.__lib.layerapi2_is_layer_loaded.argtypes = \
                [c_char_p]
            LayerApi2Wrapper.__lib.layerapi2_is_layer_loaded.restype = \
                c_int
            LayerApi2Wrapper.__lib.layerapi2_get_installed_layers.argtypes = []
            LayerApi2Wrapper.__lib.layerapi2_get_installed_layers.restype = \
                GSListPointer
            LayerApi2Wrapper.__lib.layerapi2_layers_free.argtypes = \
                [GSListPointer]
            LayerApi2Wrapper.__lib.layerapi2_layers_free.restype = None
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
        return _utf8_decode(res)

    @staticmethod
    def is_layer_installed(label_or_home):
        LayerApi2Wrapper.__make_instance()
        loh = six.b(label_or_home)
        return (LayerApi2Wrapper.__lib.layerapi2_is_layer_installed(loh) == 1)

    @staticmethod
    def is_layer_loaded(label_or_home):
        LayerApi2Wrapper.__make_instance()
        loh = six.b(label_or_home)
        return (LayerApi2Wrapper.__lib.layerapi2_is_layer_loaded(loh) == 1)

    @staticmethod
    def get_installed_layers():
        LayerApi2Wrapper.__make_instance()
        ogslp = LayerApi2Wrapper.__lib.layerapi2_get_installed_layers()
        layers = Layer._make_layers_from_pointer(ogslp)
        LayerApi2Wrapper.__lib.layerapi2_layers_free(ogslp)
        return layers

    @staticmethod
    def layers_free(cvp):
        LayerApi2Wrapper.__make_instance()
        LayerApi2Wrapper.__lib.layerapi2_layers_free(cvp)
