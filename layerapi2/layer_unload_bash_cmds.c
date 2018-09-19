#include <glib.h>
#include <glib/gprintf.h>
#include <locale.h>
#include <stdlib.h>

#include "layerapi2.h"

static gboolean debug_mode = FALSE;
static GOptionEntry entries[] = {
    { "debug", 'd', 0, G_OPTION_ARG_NONE, &debug_mode, "debug mode", NULL },
    {0, 0, 0, 0, 0, 0, 0}
};


int main(int argc, char *argv[])
{
    int result = 1;
    GOptionContext *context;
    setlocale(LC_ALL, "");
    context = g_option_context_new("LAYER_LABEL OR LAYER_HOME - output bash commands to eval to unload the given layer");
    g_option_context_add_main_entries(context, entries, NULL);
    if (!g_option_context_parse(context, &argc, &argv, NULL)) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    if (argc != 2) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    layerapi2_init(debug_mode);
    const gchar *label_or_home = argv[1];
    GString *gs = g_string_new(NULL);
    gboolean res = layerapi2_layer_unload(label_or_home, &gs);
    if (res) {
        gchar *bash_cmds = g_string_free(gs, FALSE);
        g_printf(bash_cmds);
        g_free(bash_cmds);
        result = 0;
    } else {
        g_string_free(gs, TRUE);
    }
    layerapi2_destroy();
    return result;
}
