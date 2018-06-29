#include <glib.h>
#include <glib/gprintf.h>
#include <locale.h>
#include <stdlib.h>

#include "layerapi2.h"

static GOptionEntry entries[] = {
    {0, 0, 0, 0, 0, 0, 0}
};

int main(int argc, char *argv[])
{
    GOptionContext *context;
    setlocale(LC_ALL, "");
    layerapi2_init(FALSE);
    context = g_option_context_new("LAYER LABEL - output 1 is the given layer is installed");
    g_option_context_add_main_entries(context, entries, NULL);
    if (!g_option_context_parse(context, &argc, &argv, NULL)) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    if (argc != 2) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    const gchar *label = argv[1];
    gboolean installed = layerapi2_is_layer_installed(label);
    if (installed) {
        g_print("1\n");
    } else {
        g_print("0\n");
    }
    layerapi2_destroy();
    return 0;
}
