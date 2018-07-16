#include <glib.h>
#include <glib/gprintf.h>
#include <locale.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "layerapi2.h"
#include "util.h"

static gboolean debug_mode = FALSE;
static gchar *layers = NULL;
static gboolean empty = FALSE;
static gboolean cwd = FALSE;
static gboolean empty_env = FALSE;
static gchar *empty_env_keeps = "";
static gchar *extra_env_prefix = NULL;
static gchar **prepend_env = NULL;
static gboolean force_prepend = FALSE;
static GOptionEntry entries[] = {
    { "debug", 'd', 0, G_OPTION_ARG_NONE, &debug_mode, "debug mode", NULL },
    { "empty", 'e', 0, G_OPTION_ARG_NONE, &empty, "unload all layers before", NULL },
    { "cwd", 'c', 0, G_OPTION_ARG_NONE, &cwd, "change working directory to the last layer home", NULL },
    { "extra-env-prefix", 'x', 0, G_OPTION_ARG_STRING, &extra_env_prefix, "if set, add three environnement variables {PREFIX}_NAME, {PREFIX}_LABEL and {PREFIX}_DIR containing the last layer name, label and the last layer home ", NULL },
    { "empty-env", 'E', 0, G_OPTION_ARG_NONE, &empty_env, "empty environnement (imply --empty)", NULL },
    { "empty-env-keeps", 'k', 0, G_OPTION_ARG_STRING, &empty_env_keeps, "coma separated list of env var to keep with --empty-env", NULL },
    { "layers", 'l', 0, G_OPTION_ARG_STRING, &layers, "coma separated list of layers labels/homes ('-' before the name of the layer means 'optional dependency')", NULL },
    { "prepend-env", 'p', 0, G_OPTION_ARG_STRING_ARRAY, &prepend_env, "ENV_VAR,VALUE string to prepend VALUE in : separated ENV_VAR (like PATH) (can be used multiple times)", NULL },
    { "force-prepend", 'f', 0, G_OPTION_ARG_NONE, &force_prepend, "do not check existing paths in prepend", NULL },
    {0, 0, 0, 0, 0, 0, 0}
};

int main(int argc, char *argv[])
{
    gboolean res = TRUE;
    GOptionContext *context;
    setlocale(LC_ALL, "");
    context = g_option_context_new("-- COMMAND [COMMAND_ARG1] [COMMAND_ARG2] [...] - wrapper to execute the given command in a process with some specific layers loaded");
    g_option_context_add_main_entries(context, entries, NULL);
    if (!g_option_context_parse(context, &argc, &argv, NULL)) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    if (argc < 2) {
        g_print(g_option_context_get_help(context, TRUE, NULL));
        exit(1);
    }
    layerapi2_init(debug_mode);
    if (empty || empty_env) {
        layerapi2_layers_unload_all(NULL);
    }
    if (empty_env) {
        gchar **env_vars_to_keep = NULL;
        env_vars_to_keep = g_strsplit(empty_env_keeps, ",", 0);
        layerapi2_empty_env(env_vars_to_keep);
    }
    if (layers != NULL) {
        gchar **tmp = g_strsplit(layers, ",", 0);
        guint size = g_strv_length(tmp);
        for (guint i = 0 ; i < size ; i++) {
            if (strlen(tmp[i]) > 0) {
                if (tmp[i][0] == '-') {
                    const gchar *label_or_home = tmp[i] + sizeof(gchar);
                    LayerApi2Layer *tempo = layerapi2_layer_load(label_or_home, force_prepend, NULL);
                    if (tempo != NULL) {
                        layerapi2_layer_free(tempo);
                    }
                } else {
                    LayerApi2Layer *tempo = layerapi2_layer_load(tmp[i], force_prepend, NULL);
                    if (tempo == NULL) {
                        g_warning("impossible to load the layer: %s", tmp[i]);
                        res = FALSE;
                    } else {
                        if ( (i+1) >= size ) {
                            // this is the last layer
                            if (cwd) {
                                g_debug("CHDIR %s", tempo->home);
                                chdir(tempo->home);
                            }
                            if (extra_env_prefix != NULL) {
                                gchar *plugin_name_env = g_strdup_printf("%s_NAME",
                                        extra_env_prefix);
                                gchar *plugin_dir_env = g_strdup_printf("%s_DIR",
                                        extra_env_prefix);
                                gchar *plugin_label_env = g_strdup_printf("%s_LABEL",
                                        extra_env_prefix);
                                g_debug("SETENV %s=%s", plugin_name_env, g_path_get_basename(tempo->home));
                                g_setenv(plugin_name_env,
                                        g_path_get_basename(tempo->home),
                                        TRUE);
                                g_debug("SETENV %s=%s", plugin_dir_env, tempo->home);
                                g_setenv(plugin_dir_env, tempo->home, TRUE);
                                g_debug("SETENV %s=%s", plugin_label_env, tempo->label);
                                g_setenv(plugin_label_env, tempo->label, TRUE);
                            }
                        }
                        layerapi2_layer_free(tempo);
                    }
                }
            }
        }
    }
    if (res) {
        if (prepend_env != NULL) {
            guint prepend_env_size = g_strv_length(prepend_env);
            for (guint i = 0 ; i < prepend_env_size ; i++) {
                gchar *tmp = g_strstrip(g_strdup(prepend_env[i]));
                gchar **tmp2 = g_strsplit(tmp, ",", 0);
                if (g_strv_length(tmp2) != 2) {
                    g_warning("bad prepend_env format: %s", tmp);
                    return 1;
                }
                g_debug("PREPEND_ENV %s with value %s", tmp2[0], tmp2[1]);
                field_prepend_env(tmp2[0], tmp2[1], NULL);
            }
        }
        layerapi2_wrapper(argc, argv);
        return 1;
    } else {
        g_warning("don't launch the command because of at least one layer loading fail");
        return 1;
    }
}
