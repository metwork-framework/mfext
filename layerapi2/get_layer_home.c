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
    context = g_option_context_new("LAYER LABEL - print corresponding layer home");
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
    gchar *home = layerapi2_get_layer_home(label);
    if (home == NULL) {
        g_warning("can't find layer label: %s", label);
        return 1;
    } else {
        g_print("%s\n", home);
    }
    g_free(home);
    layerapi2_destroy();
    return 0;
}
