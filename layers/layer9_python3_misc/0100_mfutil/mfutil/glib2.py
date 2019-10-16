from ctypes import cdll, c_void_p, POINTER, Structure


class GSList(Structure):
    pass


GSList._fields_ = [("data", c_void_p), ("next", POINTER(GSList))]
GSListPointer = POINTER(GSList)


class Glib2Wrapper(object):

    __lib = None

    @staticmethod
    def __make_instance():
        if Glib2Wrapper.__lib is None:
            Glib2Wrapper.__lib = cdll.LoadLibrary("libglib-2.0.so")
            Glib2Wrapper.__lib.g_free.restype = None
            Glib2Wrapper.__lib.g_free.argtypes = [c_void_p]

    @staticmethod
    def g_free(pointer):
        Glib2Wrapper.__make_instance()
        Glib2Wrapper.__lib.g_free(pointer)
