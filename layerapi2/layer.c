#include <glib.h>
#include <glib/gprintf.h>
#include <string.h>
#include <stdlib.h>

#include "util.h"
#include "log.h"
#include "layer.h"

static GSList *__layers_cache = NULL;

/**
 * Get a list of declared and existing layers paths.
 *
 * @return the list of layers paths as a GSList (free with g_slist_free_full(gfree))
 */
GSList *get_layers_paths()
{
    GSList *res = NULL;
    const gchar *env = g_getenv(LAYER_LAYERS_PATH_ENV_VAR);
    if (env == NULL) {
        return res;
    }
    gchar **tmp = g_strsplit(env, ":", 0);
    for (guint i = 0 ; i < g_strv_length(tmp) ; i++) {
        if (!g_path_is_absolute(tmp[i])) {
            g_warning("not absolute path (%s) found in %s => skip it",
                    tmp[i], LAYER_LAYERS_PATH_ENV_VAR);
        } else {
            if (g_file_test(tmp[i], G_FILE_TEST_IS_DIR)) {
                res = g_slist_append(res, g_strdup(tmp[i]));
            }
        }
    }
    g_strfreev(tmp);
    return res;
}

gchar *get_layer_env_var(const gchar *layer_home)
{
    gchar *res = NULL;
    gchar *tmp2 = g_compute_checksum_for_string(G_CHECKSUM_MD5, layer_home, -1);
    res = g_strdup_printf("METWORK_LAYER_%s_LOADED", tmp2);
    g_free(tmp2);
    return res;
}

gboolean is_layer_installed(const gchar *layer_home)
{
    if (g_file_test(layer_home, G_FILE_TEST_IS_DIR)) {
        if (test_file_presence_in_directory(layer_home, LAYER_LABEL_FILENAME)) {
            return TRUE;
        }
    }
    return FALSE;
}

gboolean is_layer_loaded(const gchar *layer_home)
{
    gboolean res = FALSE;
    gchar *env_var = get_layer_env_var(layer_home);
    if (env_var == NULL) {
        return FALSE;
    }
    gchar *tmp = g_strdup(g_getenv(env_var));
    g_free(env_var);
    if (tmp != NULL) {
        gchar *stripped_tmp = g_strstrip(tmp);
        if (g_strcmp0(stripped_tmp, "1") == 0) {
            res = TRUE;
        }
    }
    g_free(tmp);
    return res;
}

void set_layer_loaded(const gchar *layer_home, GString **bash_cmds)
{
    gchar *env_var = get_layer_env_var(layer_home);
    g_setenv(env_var, "1", TRUE);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "export %s=1;\n", env_var);
    }
    g_free(env_var);
    flush_layers_cache();
}

void set_layer_unloaded(const gchar *layer_home, GString **bash_cmds)
{
    gchar *env_var = get_layer_env_var(layer_home);
    g_unsetenv(env_var);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "unset %s;\n", env_var);
    }
    g_free(env_var);
    flush_layers_cache();
}

/**
 * Initialize a new Layer object.
 *
 * Free the returned object with layer_free.
 *
 * @return Layer new allocated Layer object.
 */
Layer *layer_new()
{
    Layer *out = g_malloc(sizeof(Layer));
    g_assert(out != NULL);
    out->loaded = FALSE;
    out->home = NULL;
    out->label = NULL;
    out->dependencies = NULL;
    out->conflicts = NULL;
    return out;
}

Layer *layer_copy(Layer *layer)
{
    Layer *out = NULL;
    if (layer != NULL) {
        out = layer_new();
        out->loaded = layer->loaded;
        out->home = g_strdup(layer->home);
        out->label = g_strdup(layer->label);
        out->dependencies = g_slist_copy_deep(layer->dependencies, (GCopyFunc) g_strdup, NULL);
        out->conflicts = g_slist_copy_deep(layer->conflicts, (GCopyFunc) g_strdup, NULL);
    }
    return out;
}

Layer *layer_new_from_home(const gchar *layer_home)
{
    Layer *out = NULL;
    if (!is_layer_installed(layer_home)) {
        return NULL;
    }
    out = layer_new();
    out->home = g_strdup(layer_home);
    out->loaded = is_layer_loaded(layer_home);
    out->label = read_file_in_directory(layer_home, LAYER_LABEL_FILENAME);
    out->dependencies = file_in_directory_to_gslist(layer_home, LAYER_DEPENDENCIES_FILENAME);
    out->conflicts = file_in_directory_to_gslist(layer_home, LAYER_CONFLICTS_FILENAME);
    return out;
}

GSList *_layers_list()
{
    GSList *out = NULL;
    GSList *layers_paths = get_layers_paths();
    GSList *layers_paths_iterator = layers_paths;
    while (layers_paths_iterator != NULL) {
        gchar *layers_path = (gchar*) layers_paths_iterator->data;
        if (is_layer_installed(layers_path)) {
            // the path is directory a layer home
            Layer *layer = layer_new_from_home(layers_path);
            g_assert(layer != NULL);
            out = g_slist_append(out, layer);
        } else {
            GDir *dir = g_dir_open(layers_path, 0, NULL);
            if (dir != NULL) {
                while (TRUE) {
                    const gchar *name = g_dir_read_name(dir);
                    if (name == NULL) {
                        break;
                    }
                    gchar *layer_home = g_strdup_printf("%s/%s", layers_path, name);
                    if (is_layer_installed(layer_home)) {
                        Layer *layer = layer_new_from_home(layer_home);
                        g_assert(layer != NULL);
                        out = g_slist_append(out, layer);
                    }
                    g_free(layer_home);
                }
                g_dir_close(dir);
            }
        }
        layers_paths_iterator = layers_paths_iterator->next;
    }
    g_slist_free_full(layers_paths, (GDestroyNotify) g_free);
    return out;
}

GSList *layers_list()
{
    if (__layers_cache == NULL) {
        __layers_cache = _layers_list();
    }
    return g_slist_copy_deep(__layers_cache, (GCopyFunc) layer_copy, NULL);
}

void flush_layers_cache()
{
    if (__layers_cache != NULL) {
        layers_free(__layers_cache);
        __layers_cache = NULL;
    }

}

Layer *layer_new_from_label(const gchar *label)
{
    Layer *out = NULL;
    GSList *layers = layers_list();
    GSList *layers_iterator = layers;
    while (layers_iterator != NULL) {
        Layer *layer = (Layer*) layers_iterator->data;
        if (g_strcmp0(layer->label, label) == 0) {
            out = layer_copy(layer);
            break;
        }
        layers_iterator = layers_iterator->next;
    }
    layers_free(layers);
    return out;
}

/**
 * Return a newly allocated Layer object from a label.
 *
 * @param string label_or_home label to find or layer home.
 * @return newly allocated Layer object (free with layer_free)
 */
Layer *layer_new_from_label_or_home(const gchar *label_or_home)
{
    if (label_or_home == NULL) {
        return NULL;
    }
    if (label_or_home[0] == '/') {
        return layer_new_from_home(label_or_home);
    } else {
        return layer_new_from_label(label_or_home);
    }
}

/**
 * Free a layer object.
 *
 * @param layer Layer object (or NULL).
 */
void layer_free(Layer *layer)
{
    if (layer == NULL) {
        return;
    }
    g_free(layer->label);
    g_free(layer->home);
    g_slist_free_full(layer->dependencies, (GDestroyNotify) g_free);
    g_slist_free_full(layer->conflicts, (GDestroyNotify) g_free);
    g_free(layer);
    layer = NULL;
}

/**
 * Free a GSList of Layer objects.
 *
 * @param layers GSList of Layer objects.
 */
void layers_free(GSList *layers)
{
    g_slist_free_full(layers, (GDestroyNotify) layer_free);
    layers = NULL;
}

void _layer_load(Layer *layer, gboolean force_prepend, GString **bash_cmds)
{
    g_debug("loading %s[%s]", layer->label, layer->home);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "# Loading of %s layer located in %s\n",
                layer->label, layer->home);
    }
    const gchar *p2rsp = get_python2_relative_site_packages();
    const gchar *p3rsp = get_python3_relative_site_packages();
    gchar *lp2rsp = g_strdup_printf("local/%s", p2rsp);
    gchar *lp3rsp = g_strdup_printf("local/%s", p3rsp);
    conditional_prepend_env(layer->home, "lib/node_modules", force_prepend, "NODE_PATH", bash_cmds);
    conditional_prepend_env(layer->home, "lib/node_modules/.bin", force_prepend, "PATH", bash_cmds);
    conditional_prepend_env(layer->home, "local/lib/node_modules", force_prepend, "NODE_PATH", bash_cmds);
    conditional_prepend_env(layer->home, "local/lib/node_modules/.bin", force_prepend, "PATH", bash_cmds);
    conditional_prepend_env(layer->home, lp2rsp, force_prepend, "PYTHONPATH", bash_cmds);
    conditional_prepend_env(layer->home, lp3rsp, force_prepend, "PYTHONPATH", bash_cmds);
    conditional_prepend_env(layer->home, p2rsp, force_prepend, "PYTHONPATH", bash_cmds);
    conditional_prepend_env(layer->home, p3rsp, force_prepend, "PYTHONPATH", bash_cmds);
    conditional_prepend_env(layer->home, "local/bin", force_prepend, "PATH", bash_cmds);
    conditional_prepend_env(layer->home, "bin", force_prepend, "PATH", bash_cmds);
    conditional_prepend_env(layer->home, "local/lib", force_prepend, "LD_LIBRARY_PATH", bash_cmds);
    conditional_prepend_env(layer->home, "lib", force_prepend, "LD_LIBRARY_PATH", bash_cmds);
    conditional_prepend_env(layer->home, "local/lib/pkgconfig", force_prepend, "PKG_CONFIG_PATH", bash_cmds);
    conditional_prepend_env(layer->home, "lib/pkgconfig", force_prepend, "PKG_CONFIG_PATH", bash_cmds);
    conditional_source(layer->home, LAYER_INTERACTIVE_PROFILE_FILENAME, bash_cmds);
    conditional_add_extra_env(layer->home, LAYER_EXTRA_ENV_FILENAME, bash_cmds);
    set_layer_loaded(layer->home, bash_cmds);
    if (bash_cmds != NULL) {
        g_string_append(*bash_cmds, "\n\n");
    }
    g_free(lp2rsp);
    g_free(lp3rsp);
}

void _layer_unload(Layer *layer, GString **bash_cmds)
{
    g_debug("unloading %s[%s]", layer->label, layer->home);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "# Unloading of %s layer located in %s\n",
                layer->label, layer->home);
    }
    gchar *layer_home_wildcards = g_strdup_printf("%s/*", layer->home);
    field_remove_env("PATH", layer_home_wildcards, TRUE, bash_cmds);
    field_remove_env("LD_LIBRARY_PATH", layer_home_wildcards, TRUE, bash_cmds);
    field_remove_env("PKG_CONFIG_PATH", layer_home_wildcards, TRUE, bash_cmds);
    field_remove_env("PYTHONPATH", layer_home_wildcards, TRUE, bash_cmds);
    field_remove_env("NODE_PATH", layer_home_wildcards, TRUE, bash_cmds);
    conditional_source(layer->home, LAYER_INTERACTIVE_UNPROFILE_FILENAME, bash_cmds);
    conditional_remove_extra_env(layer->home, LAYER_EXTRA_ENV_FILENAME, bash_cmds);
    g_free(layer_home_wildcards);
    set_layer_unloaded(layer->home, bash_cmds);
    if (bash_cmds != NULL) {
        g_string_append(*bash_cmds, "\n\n");
    }
}

gboolean _fix_missing_dependencies(GString **bash_cmds, gint recursion_level)
{
    if (recursion_level > LAYER_MAX_RECURSION_LEVEL) {
        // FIXME: shoud be a warning but we have to see what's going on with tests
        g_message("too many recursion level (dependency loop ?)");
        return FALSE;
    }
    gboolean some_layer_unloaded = FALSE;
    GSList *layers = layers_list();
    GSList *layers_iterator = layers;
    while (layers_iterator != NULL) {
        Layer *layer = (Layer*) layers_iterator->data;
        if (is_layer_loaded(layer->home)) {
            GSList *deps_iterator = layer->dependencies;
            while (deps_iterator != NULL) {
                gchar *label = (gchar*) deps_iterator->data;
                Layer *dep_layer = NULL;
                if ((label != NULL) && (label[0] == '-')) {
                    // optional dependency, we do nothing
                } else {
                    dep_layer = layer_new_from_label_or_home(label);
                }
                if (dep_layer != NULL) {
                    if (!is_layer_loaded(dep_layer->home)) {
                        g_debug("layer %s[%s] depends on missing dependency on layer %s[%s] \
                                => unloading %s", layer->label, layer->home,
                                dep_layer->label, dep_layer->home, layer->label);
                        _layer_unload(layer, bash_cmds);
                        some_layer_unloaded = TRUE;
                    }
                    layer_free(dep_layer);
                }
                deps_iterator = deps_iterator->next;
            }
        }
        layers_iterator = layers_iterator->next;
    }
    layers_free(layers);
    if (some_layer_unloaded) {
        _fix_missing_dependencies(bash_cmds, recursion_level + 1);
    }
    return TRUE;
}

gboolean layer_load_recursive(Layer *layer, gboolean force_prepend, GString **bash_cmds, gint recursion_level)
{
    if (recursion_level > LAYER_MAX_RECURSION_LEVEL) {
        // FIXME: shoud be a warning but we have to see what's going on with tests
        g_message("too many recursion level (dependency loop ?)");
        return FALSE;
    }
    gboolean some_layer_unloaded = FALSE;
    if (is_layer_loaded(layer->home)) {
        // already loaded
        g_debug("layer %s[%s] is already loaded", layer->label, layer->home);
        return TRUE;
    }
    GSList *conflicts_iterator = layer->conflicts;
    while (conflicts_iterator != NULL) {
        gchar *label = (gchar*) conflicts_iterator->data;
        Layer *conflict_layer = layer_new_from_label_or_home(label);
        if (conflict_layer != NULL) {
            if (is_layer_loaded(conflict_layer->home)) {
                g_debug("layer %s[%s] conflicts with already loaded layer %s[%s] => \
                        unloading %s", layer->label, layer->home,
                        conflict_layer->label, conflict_layer->home,
                        conflict_layer->label);
                some_layer_unloaded = TRUE;
                _layer_unload(conflict_layer, bash_cmds);
            }
            layer_free(conflict_layer);
        }
        conflicts_iterator = conflicts_iterator->next;
    }
    if (some_layer_unloaded) {
        gboolean fix_res = _fix_missing_dependencies(bash_cmds, 0);
        if (fix_res == FALSE) {
            return FALSE;
        }
    }
    GSList *deps_iterator = layer->dependencies;
    while (deps_iterator != NULL) {
        gchar *label = (gchar*) deps_iterator->data;
        Layer *dep_layer = NULL;
        gboolean optional_dep = FALSE;
        if ((label != NULL) && (label[0] == '-')) {
            // optional dependency
            // we do nothing here, we will try that after
            optional_dep = TRUE;
        } else {
            dep_layer = layer_new_from_label_or_home(label);
        }
        if (!optional_dep) {
            if (dep_layer != NULL) {
                if (!is_layer_loaded(dep_layer->home)) {
                    g_debug("layer %s[%s] depends on not loaded layer %s[%s] => \
                            loading %s", layer->label, layer->home,
                            dep_layer->label, dep_layer->home,
                            dep_layer->label);
                    gboolean load_res = layer_load_recursive(dep_layer, force_prepend, bash_cmds, recursion_level + 1);
                    if (load_res == FALSE) {
                        layer_free(dep_layer);
                        return load_res;
                    }
                }
                layer_free(dep_layer);
            } else {
                // FIXME: shoud be a warning but we have to see what's going on with tests
                //g_warning("layer %s[%s] depends on a not installed layer %s => we can't load it", layer->label, layer->home, label);
                g_message("layer %s[%s] depends on a not installed layer %s => we can't load it", layer->label, layer->home, label);
                return FALSE;
            }
        }
        deps_iterator = deps_iterator->next;
    }
    _layer_load(layer, force_prepend, bash_cmds);
    deps_iterator = layer->dependencies;
    while (deps_iterator != NULL) {
        gchar *label = (gchar*) deps_iterator->data;
        if ((label != NULL) && (label[0] == '-')) {
            // optional dependency
            Layer *dep_layer = layer_new_from_label_or_home(label + sizeof(gchar));
            if (dep_layer != NULL) {
                if (!is_layer_loaded(dep_layer->home)) {
                    g_debug("layer %s[%s] optionally depends on not loaded layer %s[%s] => \
                            trying to load %s", layer->label, layer->home,
                            dep_layer->label, dep_layer->home,
                            dep_layer->label);
                    layer_load_recursive(dep_layer, force_prepend, bash_cmds, recursion_level + 1);
                }
                layer_free(dep_layer);
            } else {
                g_debug("layer %s[%s] optionally depends on a not installed layer %s => we ignore this dependency", layer->label, layer->home, label + sizeof(gchar));
            }
        }
        deps_iterator = deps_iterator->next;
    }
    return TRUE;
}

gboolean layer_load(Layer *layer, gboolean force_prepend, GString **bash_cmds)
{
    return layer_load_recursive(layer, force_prepend, bash_cmds, 0);
}


gboolean layer_unload(Layer *layer, GString **bash_cmds)
{
    _layer_unload(layer, bash_cmds);
    return _fix_missing_dependencies(bash_cmds, 0);
}
