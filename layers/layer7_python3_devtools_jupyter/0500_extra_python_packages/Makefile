include ../../../adm/root.mk
include ../../python3_layer.mk

LAYER_NAME=python3_devtools_jupyter
LOADED_PYTHON_LAYERS=python3_devtools@mfext

after::
	layer_wrapper --layers=python3_devtools_jupyter@mfext -- python -m bash_kernel.install
