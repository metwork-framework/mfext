#include <glib.h>
#include <glib/gprintf.h>
#include <string.h>
#include <stdlib.h>

#include "util.h"
#include "log.h"
#include "layer.h"
#include "wrapper.h"
#include "layerapi2.h"

void layerapi2_init(gboolean debug_mode)
{
    set_default_log_handler(debug_mode);
}

void layerapi2_destroy()
{
    flush_layers_cache();
}

LayerApi2Layer *layerapi2_layer_load(const gchar *label_or_home, gboolean force_prepend, GString **bash_cmds)
{
    LayerApi2Layer *res = NULL;
    Layer *layer = layer_new_from_label_or_home(label_or_home);
    if (layer != NULL) {
        gboolean tmp = layer_load(layer, force_prepend, bash_cmds);
        if (tmp) {
            res = (LayerApi2Layer*) layer;
        } else {
            layer_free(layer);
        }
    } else {
        g_debug("the layer %s is not installed/found => we do nothing",
                label_or_home);
    }
    return res;
}

gboolean layerapi2_layer_unload(const gchar *label_or_home, GString **bash_cmds)
{
    gboolean res = FALSE;
    Layer *layer = layer_new_from_label_or_home(label_or_home);
    if (layer != NULL) {
        res = layer_unload(layer, bash_cmds);
        layer_free(layer);
    } else {
        g_debug("the layer %s is not installed/found => we do nothing",
                label_or_home);
    }
    return res;
}


GSList *layerapi2_get_installed_layers()
{
    return layers_list();
}


void layerapi2_layers_free(GSList *layers)
{
    layers_free(layers);
}

void layerapi2_layer_free(LayerApi2Layer *layer)
{
    layer_free((Layer*) layer);
}

gboolean layerapi2_is_layer_installed(const gchar *label_or_home)
{
    gboolean res = FALSE;
    Layer *layer = layer_new_from_label_or_home(label_or_home);
    if (layer != NULL) {
        res = is_layer_installed(layer->home);
        layer_free(layer);
    }
    return res;
}

gboolean layerapi2_is_layer_loaded(const gchar *label_or_home)
{
    gboolean res = FALSE;
    Layer *layer = layer_new_from_label_or_home(label_or_home);
    if (layer != NULL) {
        res = is_layer_loaded(layer->home);
        layer_free(layer);
    }
    return res;
}

void layerapi2_empty_env(gchar **keeps)
{
    empty_env(keeps);
}

int layerapi2_wrapper(int argc, char *argv[])
{
    return wrapper(argc, argv);
}

int layerapi2_forced_wrapper(int argc, char *argv[], const gchar *command)
{
    return forced_wrapper(argc, argv, command);
}

void layerapi2_layers_unload_all(GString **bash_cmds)
{
    GSList *layers = layers_list();
    GSList *layers_iterator = layers;
    while (layers_iterator != NULL) {
        Layer *layer = (Layer*) layers_iterator->data;
        if (layer->loaded) {
            layer_unload(layer, bash_cmds);
        }
        layers_iterator = layers_iterator->next;
    }
    layers_free(layers);
}

// FIXME: move elsewhere
gchar *layerapi2_replace_env_var_pattern(const gchar *string)
{
    return replace_env_var_pattern(string);
}

gchar *layerapi2_get_layer_home(const gchar *label) {
    gchar *res = NULL;
    Layer *layer = layer_new_from_label(label);
    if (layer != NULL) {
        res = g_strdup(layer->home);
        layer_free(layer);
    }
    return res;
}
