#include <glib.h>
#include <glib/gprintf.h>
#include <locale.h>
#include <stdlib.h>

#include "layerapi2.h"

static gchar *loaded_filter = NULL;
static gboolean raw = FALSE;
static GOptionEntry entries[] = {
    { "raw", 'r', 0, G_OPTION_ARG_NONE, &raw, "raw output", NULL },
    { "loaded-filter", 'm', 0, G_OPTION_ARG_STRING, &loaded_filter, "Loaded layer filter (default: no filter, possible values: yes, no)", NULL },
    {0, 0, 0, 0, 0, 0, 0}
};

int main(int argc, char *argv[])
{
    GOptionContext *context;
    layerapi2_init(TRUE);
    setlocale(LC_ALL, "");
    context = g_option_context_new("- list installed layers");
    g_option_context_add_main_entries(context, entries, NULL);
    if (!g_option_context_parse(context, &argc, &argv, NULL)) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    GSList *layers = layerapi2_get_installed_layers();
    GSList *layers_iterator = layers;
    while (layers_iterator != NULL) {
        LayerApi2Layer *layer = (LayerApi2Layer*) layers_iterator->data;
        if ((loaded_filter == NULL) || ((g_strcmp0(loaded_filter, "yes") == 0) && layer->loaded) || ((g_strcmp0(loaded_filter, "no") == 0) && !(layer->loaded))) {
            if (raw) {
                g_printf("%s %s\n", layer->label, layer->home);
            } else {
                gchar *loaded = "";
                if (layer->loaded) {
                    loaded = "(*) ";
                }
                g_printf("- %s%s [%s]\n", loaded, layer->label, layer->home);
            }
        }
        layers_iterator = layers_iterator->next;
    }
    layerapi2_layers_free(layers);
    layerapi2_destroy();
    return 0;
}
