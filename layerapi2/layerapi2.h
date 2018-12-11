#ifndef LAYERAPI2_H_
#define LAYERAPI2_H_

#include <glib.h>

struct _LayerApi2Layer {
    gboolean loaded;
    gchar *home;
    gchar *label;
    GSList *dependencies;
    GSList *conflicts;
};
typedef struct _LayerApi2Layer LayerApi2Layer;

void layerapi2_init(gboolean debug_mode);
void layerapi2_destroy();

GSList *layerapi2_get_installed_layers();
gboolean layerapi2_is_layer_installed(const gchar *label_or_home);
gboolean layerapi2_is_layer_loaded(const gchar *label_or_home);

LayerApi2Layer *layerapi2_layer_load(const gchar *label_or_home, gboolean force_prepend, GString **bash_cmds);
gboolean layerapi2_layer_unload(const gchar *label_or_home, GString **bash_cmds);
void layerapi2_layers_unload_all(GString **bash_cmds);

gchar *layerapi2_get_layer_home(const gchar *label);

void layerapi2_layers_free(GSList *layers);
void layerapi2_layer_free(LayerApi2Layer *layer);

void layerapi2_empty_env(gchar **keeps);
int layerapi2_wrapper(int argc, char *argv[]);
int layerapi2_forced_wrapper(int argc, char *argv[], const gchar *command);

gchar *layerapi2_replace_env_var_pattern(const gchar *string);

#endif /* LAYERAPI2_H_ */
