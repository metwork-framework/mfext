#ifndef LAYER_H_
#define LAYER_H_

#include <glib.h>

#define LAYER_LABEL_FILENAME ".layerapi2_label"
#define LAYER_CONFLICTS_FILENAME ".layerapi2_conflicts"
#define LAYER_DEPENDENCIES_FILENAME ".layerapi2_dependencies"
#define LAYER_INTERACTIVE_PROFILE_FILENAME ".layerapi2_interactive_profile"
#define LAYER_INTERACTIVE_UNPROFILE_FILENAME ".layerapi2_interactive_unprofile"
#define LAYER_EXTRA_ENV_FILENAME ".layerapi2_extra_env"
#define LAYER_LAYERS_PATH_ENV_VAR "METWORK_LAYERS_PATH"
#define LAYER_MAX_RECURSION_LEVEL 100

struct _Layer {
    gboolean loaded;
    gchar *home;
    gchar *label;
    GSList *dependencies;
    GSList *conflicts;
};
typedef struct _Layer Layer;

GSList *get_layers_paths();
void layers_free(GSList *layers);
void layer_free(Layer *layer);
gboolean is_layer_installed(const gchar *layer_home);
gboolean is_layer_loaded(const gchar *layer_home);
Layer *layer_new_from_label_or_home(const gchar *label_or_home);
Layer *layer_new_from_label(const gchar *label);
GSList *layers_list();
gboolean layer_load(Layer *layer, gboolean force_prend, GString **bash_cmds);
gboolean layer_unload(Layer *layer, GString **bash_cmds);
void flush_layers_cache();

#endif /* LAYER_H_ */
