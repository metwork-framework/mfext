#include <glib.h>
#include <glib/gprintf.h>
#include <locale.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "layerapi2.h"

static gchar *layers = "{{LAYERS}}";

int main(int argc, char *argv[])
{
    if (argc == 2) {
        if (g_strcmp0(argv[1], "--help") == 0) {
            g_print("usage: %s [ARG1] [ARG2] [...]\n", argv[0]);
            g_print("  => wrapper to execute the command '{{COMMAND}} [ARG1] [ARG2] [...]' in a context with layers '{{LAYERS}}' loaded\n");
            return 0;
        }
    }
    gboolean res = TRUE;
    layerapi2_init(FALSE);
    gchar **tmp = g_strsplit(layerapi2_replace_env_var_pattern(layers), ",", 0);
    guint size = g_strv_length(tmp);
    for (guint i = 0 ; i < size ; i++) {
        if (strlen(tmp[i]) > 0) {
            if (tmp[i][0] == '-') {
                const gchar *label_or_home = tmp[i] + sizeof(gchar);
                LayerApi2Layer *tempo = layerapi2_layer_load(label_or_home, FALSE, NULL);
                if (tempo != NULL) {
                    layerapi2_layer_free(tempo);
                }
            } else {
                LayerApi2Layer *tempo = layerapi2_layer_load(tmp[i], FALSE, NULL);
                if (tempo == NULL) {
                    g_warning("impossible to load the layer: %s", tmp[i]);
                    res = FALSE;
                } else {
                    layerapi2_layer_free(tempo);
                }
            }
        }
    }
    if (res) {
        layerapi2_forced_wrapper(argc, argv, "{{COMMAND}}");
        return 0;
    } else {
        g_warning("don't launch the command {{COMMAND}} because of at least one layer loading fail");
        return 1;
    }
}
