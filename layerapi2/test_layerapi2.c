#include <glib.h>
#include <locale.h>
#include <string.h>

#include "layerapi2.h"
#include "log.h"
#include "layer.h"
#include "util.h"

static gchar *current_dir = NULL;
static gchar *layerpath1 = NULL;
static gchar *layerpath2 = NULL;

gchar * __set_layers_path()
{
    if (current_dir == NULL) {
        current_dir = g_get_current_dir();
        layerpath1 = g_strdup_printf("%s/tests/layerpath1", current_dir);
        layerpath2 = g_strdup_printf("%s/tests/layerpath2", current_dir);
    }
    gchar *old_value = g_strdup(g_getenv(LAYER_LAYERS_PATH_ENV_VAR));
    gchar *env_var_value = g_strdup_printf("%s/not_found:%s:%s/fooooo:%s", current_dir, layerpath1, current_dir, layerpath2);
    g_setenv("METWORK_LAYERS_PATH", env_var_value, TRUE);
    g_free(env_var_value);
    return old_value;
}

void __restore_layers_path(const gchar *old_value)
{
    if (old_value == NULL) {
        g_unsetenv(LAYER_LAYERS_PATH_ENV_VAR);
    } else {
        g_setenv(LAYER_LAYERS_PATH_ENV_VAR, old_value, TRUE);
    }
    g_free(current_dir);
    g_free(layerpath1);
    g_free(layerpath2);
    current_dir = NULL;
}

gboolean __layer_load(const gchar *label_or_home, gboolean force_prepend, GString **bash_cmds)
{
    LayerApi2Layer *tempo = layerapi2_layer_load(label_or_home, force_prepend, bash_cmds);
    if (tempo != NULL) {
        layerapi2_layer_free(tempo);
        return TRUE;
    }
    return FALSE;
}

void test_get_layers_paths()
{
    gchar *old_value = __set_layers_path();
    GSList *paths = get_layers_paths();
    g_assert_cmpint(g_slist_length(paths), ==, 2);
    g_assert_cmpstr(g_slist_nth_data(paths, 0), ==, layerpath1);
    g_assert_cmpstr(g_slist_nth_data(paths, 1), ==, layerpath2);
    g_slist_free_full(paths, (GDestroyNotify) g_free);
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_layer_load()
{
    gchar *old_value = __set_layers_path();
    g_assert_true(layerapi2_is_layer_installed("layer1_label"));
    g_assert_false(layerapi2_is_layer_installed("foobar"));
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    GString *gs = g_string_new(NULL);
    __layer_load("layer1_label", FALSE, &gs);
    gchar *bash_cmds = g_string_free(gs, FALSE);
    g_assert_true(strlen(bash_cmds) > 0);
    g_free(bash_cmds);
    g_assert_true(layerapi2_is_layer_loaded("layer1_label"));
    __layer_load("layer1_label", FALSE, NULL);
    g_assert_true(layerapi2_is_layer_loaded("layer1_label"));
    layerapi2_layer_unload("layer1_label", NULL);
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_layer_load2()
{
    gchar *old_value = __set_layers_path();
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer2_label"));
    __layer_load("layer2_label", FALSE, NULL);
    g_assert_true(layerapi2_is_layer_loaded("layer2_label"));
    g_assert_true(layerapi2_is_layer_loaded("layer1_label"));
    layerapi2_layer_unload("layer1_label", NULL);
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer2_label"));
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_layer_load3()
{
    gchar *old_value = __set_layers_path();
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer2_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer3_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer4_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer5_label"));
    __layer_load("layer4_label", FALSE, NULL);
    g_assert_true(layerapi2_is_layer_loaded("layer4_label"));
    g_assert_true(layerapi2_is_layer_loaded("layer3_label"));
    g_assert_true(layerapi2_is_layer_loaded("layer2_label"));
    g_assert_true(layerapi2_is_layer_loaded("layer1_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer5_label"));
    __layer_load("layer5_label", FALSE, NULL);
    g_assert_false(layerapi2_is_layer_loaded("layer1_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer2_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer3_label"));
    g_assert_false(layerapi2_is_layer_loaded("layer4_label"));
    g_assert_true(layerapi2_is_layer_loaded("layer5_label"));
    layerapi2_layer_unload("layer5_label", NULL);
    g_assert_false(layerapi2_is_layer_loaded("layer5_label"));
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_layer_loaderror()
{
    gchar *old_value = __set_layers_path();
    g_assert_true(layerapi2_is_layer_installed("layererror6_label"));
    g_assert_true(layerapi2_is_layer_installed("layererror7_label"));
    g_assert_false(layerapi2_is_layer_loaded("layererror6_label"));
    g_assert_false(layerapi2_is_layer_loaded("layererror7_label"));
    g_assert_false(__layer_load("layererror6_label", FALSE, NULL));
    g_assert_false(layerapi2_is_layer_loaded("layererror6_label"));
    g_assert_false(__layer_load("layererror7_label", FALSE, NULL));
    g_assert_false(layerapi2_is_layer_loaded("layererror7_label"));
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_layer_new_from_label_or_home()
{
    gchar *old_value = __set_layers_path();
    Layer *layer = layer_new_from_label_or_home("layer1_label");
    g_assert(layer != NULL);
    Layer *layer2 = layer_new_from_label_or_home("foobar");
    g_assert(layer2 == NULL);
    Layer *layer3 = layer_new_from_label_or_home(layer->home);
    g_assert(layer3 != NULL);
    g_assert_cmpstr(layer->label, ==, layer3->label);
    __restore_layers_path(old_value);
    layer_free(layer);
    layer_free(layer2);
    layer_free(layer3);
    g_free(old_value);
}

void test_layers_list()
{
    gchar *old_value = __set_layers_path();
    GSList *list = layerapi2_get_installed_layers();
    layerapi2_layers_free(list);
    __restore_layers_path(old_value);
    g_free(old_value);
}

void test_conditional_prepend_env()
{
    conditional_prepend_env(".", "tests", FALSE, "FOOBAR", FALSE);
    g_assert_cmpstr(g_getenv("FOOBAR"), ==, "./tests");
}

void test_print_conditional_source_bash_cmds()
{
    GString *gs = g_string_new(NULL);
    conditional_source("./tests", "lines", &gs);
    gchar *bash_cmds = g_string_free(gs, FALSE);
    g_assert_true(strlen(bash_cmds) > 0);
    g_free(bash_cmds);
}

void test_lines_to_gslist()
{
    gchar *content = read_file_in_directory("./tests", "lines");
    GSList *list = lines_to_gslist(content);
    GSList *list_iterator;
    g_free(content);
    gchar *data = (gchar*) list->data;
    g_assert_cmpstr(data, ==, "foo");
    list_iterator = list->next;
    data = (gchar*) list_iterator->data;
    g_assert_cmpstr(data, ==, "bar");
    list_iterator = list_iterator->next;
    data = (gchar*) list_iterator->data;
    g_assert_cmpstr(data, ==, "foo2");
    list_iterator = list_iterator->next;
    g_assert_null(list_iterator);
    g_slist_free_full(list, g_free);
}

void test_file_in_directory_to_gslist()
{
    GSList *list = file_in_directory_to_gslist("./tests", "lines");
    GSList *list_iterator;
    gchar *data = (gchar*) list->data;
    g_assert_cmpstr(data, ==, "foo");
    list_iterator = list->next;
    data = (gchar*) list_iterator->data;
    g_assert_cmpstr(data, ==, "bar");
    list_iterator = list_iterator->next;
    data = (gchar*) list_iterator->data;
    g_assert_cmpstr(data, ==, "foo2");
    list_iterator = list_iterator->next;
    g_assert_null(list_iterator);
    g_slist_free_full(list, g_free);
}

void test_test_file_presence_in_directory()
{
    g_assert_true(test_file_presence_in_directory("./tests", "file.extra_env"));
    g_assert_false(test_file_presence_in_directory("./tests", "not_found"));
    g_assert_false(test_file_presence_in_directory("./notfound", "not_found"));
}

void test_read_file_in_directory()
{
    gchar *res = read_file_in_directory("./tests", "file_to_read");
    g_assert_cmpstr(res, ==, "foo");
    g_free(res);
    g_assert_cmpstr(read_file_in_directory("./tests", "not_found"), ==, NULL);
    g_assert_cmpstr(read_file_in_directory("./notfound", "not_found"), ==, NULL);
}

void test_conditional_add_extra_env()
{
    g_unsetenv("LAYERAPI_TEST_VAR1");
    g_unsetenv("LAYERAPI_TEST_VAR2");
    g_unsetenv("LAYERAPI_TEST_VAR3");
    conditional_add_extra_env("./tests", "file.extra_env", FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR1"), ==, "value1");
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR2"), ==, "value2");
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR3"), ==, "value3");
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR4"), ==, "value3");
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR5"), ==, "");
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST_VAR6"), ==, "value1::value3");
}

void test_conditional_remove_extra_env()
{
    test_conditional_add_extra_env();
    conditional_remove_extra_env("./tests", "file.extra_env", FALSE);
    g_assert_null(g_getenv("LAYERAPI_TEST_VAR1"));
    g_assert_null(g_getenv("LAYERAPI_TEST_VAR2"));
    g_assert_null(g_getenv("LAYERAPI_TEST_VAR3"));
}

void test_prepend_env()
{
    g_unsetenv("LAYERAPI_TEST");
    field_prepend_env("LAYERAPI_TEST", "foo", FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "foo");
    field_prepend_env("LAYERAPI_TEST", "bar", FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "bar:foo");
    field_prepend_env("LAYERAPI_TEST", "foo", FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "foo:bar");
}

void test_remove_env()
{
    g_unsetenv("LAYERAPI_TEST");
    g_setenv("LAYERAPI_TEST", "foo:bar:plop", TRUE);
    field_remove_env("LAYERAPI_TEST", "foobar", FALSE, FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "foo:bar:plop");
    field_remove_env("LAYERAPI_TEST", "bar", FALSE, FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "foo:plop");
    field_remove_env("LAYERAPI_TEST", "p*", TRUE, FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "foo");
    field_remove_env("LAYERAPI_TEST", "*", TRUE, FALSE);
    g_assert_cmpstr(g_getenv("LAYERAPI_TEST"), ==, "");
}

void test_get_python_relative_site_packages()
{
    const gchar *p21 = get_python2_relative_site_packages();
    const gchar *p22 = get_python2_relative_site_packages();
    const gchar *p31 = get_python3_relative_site_packages();
    const gchar *p32 = get_python3_relative_site_packages();
    g_assert_true(p21 == p22);
    g_assert_true(p31 == p32);
    g_assert_true(strlen(p21) > 0);
    g_assert_true(strlen(p31) > 0);
}

void test_log()
{
    layerapi2_init(FALSE);
    g_debug("ERROR: you should not see that");
    g_message("you should see that (1/3)");
}

void test_log_debug()
{
    layerapi2_init(TRUE);
    g_debug("you should see that (2/3)");
    g_message("you should see that (3/3)");
}

void test_field_prepend_normal()
{
    gchar *res1 = field_prepend("foo:bar:foo2", "bar2", ":");
    g_assert_cmpstr(res1, ==, "bar2:foo:bar:foo2");
    g_free(res1);
    gchar *res2 = field_prepend("foo:bar:foo2", "bar", ":");
    g_assert_cmpstr(res2, ==, "bar:foo:foo2");
    g_free(res2);
}

void test_field_remove_normal()
{
    gchar *res1 = field_remove("foo:bar:foo2", "bar", ":", FALSE);
    g_assert_cmpstr(res1, ==, "foo:foo2");
    g_free(res1);
    gchar *res2 = field_remove("foo:bar:foo2", "foofoo", ":", FALSE);
    g_assert_cmpstr(res2, ==, "foo:bar:foo2");
    g_free(res2);
    gchar *res3 = field_remove("foo:bar:foo2", "f*", ":", TRUE);
    g_assert_cmpstr(res3, ==, "bar");
    g_free(res3);
    gchar *res4 = field_remove("foo:bar:foo2", "*", ":", TRUE);
    g_assert_cmpstr(res4, ==, "");
    g_free(res4);
}

void test_field_prepend_special()
{
    gchar *res1 = field_prepend("", "foo", ":");
    g_assert_cmpstr(res1, ==, "foo");
    g_free(res1);
    gchar *res2 = field_prepend(NULL, "foo", ":");
    g_assert_cmpstr(res2, ==, "foo");
    g_free(res2);
    gchar *res3 = field_prepend("foo:bar", "", ":");
    g_assert_cmpstr(res3, ==, "foo:bar");
    g_free(res3);
    gchar *res4 = field_prepend("foo:bar", NULL, ":");
    g_assert_cmpstr(res4, ==, "foo:bar");
    g_free(res4);
    gchar *res5 = field_prepend(NULL, NULL, ":");
    g_assert_null(res5);
    g_free(res5);
}

void test_field_remove_special()
{
    gchar *res1 = field_remove("", "foo", ":", FALSE);
    g_assert_cmpstr(res1, ==, "");
    g_free(res1);
    gchar *res2 = field_remove(NULL, "foo", ":", FALSE);
    g_assert_cmpstr(res2, ==, NULL);
    g_free(res2);
    gchar *res3 = field_remove("foo:bar", "", ":", FALSE);
    g_assert_cmpstr(res3, ==, "foo:bar");
    g_free(res3);
    gchar *res4 = field_remove("foo:bar", NULL, ":", FALSE);
    g_assert_cmpstr(res4, ==, "foo:bar");
    g_free(res4);
    gchar *res5 = field_remove(NULL, NULL, ":", FALSE);
    g_assert_null(res5);
    g_free(res5);
}

gboolean log_fatal_func(const gchar *UNUSED(log_domain), GLogLevelFlags UNUSED(log_level),
        const gchar *UNUSED(message), gpointer UNUSED(user_data))
{
    g_print("PLOP\n");
    return FALSE;
}

int main(int argc, char *argv[])
{
    g_test_init (&argc, &argv, NULL);
    setlocale(LC_ALL, "");
    g_test_add_func("/layerapi/test_test_file_presence_in_directory", test_test_file_presence_in_directory);
    g_test_add_func("/layerapi/test_read_file_in_directory", test_read_file_in_directory);
    g_test_add_func("/layerapi/test_lines_to_gslist", test_lines_to_gslist);
    g_test_add_func("/layerapi/test_file_in_directory_to_gslist", test_file_in_directory_to_gslist);
    g_test_add_func("/layerapi/test_get_python_relative_site_packages", test_get_python_relative_site_packages);
    g_test_add_func("/layerapi/test_log/normal", test_log);
    g_test_add_func("/layerapi/test_log/debug", test_log_debug);
    g_test_add_func("/layerapi/test_field_prepend/normal", test_field_prepend_normal);
    g_test_add_func("/layerapi/test_field_prepend/special", test_field_prepend_special);
    g_test_add_func("/layerapi/test_prepend_env", test_prepend_env);
    g_test_add_func("/layerapi/test_remove_env", test_remove_env);
    g_test_add_func("/layerapi/test_field_remove/normal", test_field_remove_normal);
    g_test_add_func("/layerapi/test_field_remove/special", test_field_remove_special);
    g_test_add_func("/layerapi/test_add_extra_env", test_conditional_add_extra_env);
    g_test_add_func("/layerapi/test_remove_extra_env", test_conditional_remove_extra_env);
    g_test_add_func("/layerapi/test_get_layers_paths", test_get_layers_paths);
    g_test_add_func("/layerapi/test_layers_list", test_layers_list);
    g_test_add_func("/layerapi/test_conditional_prepend_env", test_conditional_prepend_env);
    g_test_add_func("/layerapi/test_print_conditional_source_bash_cmds", test_print_conditional_source_bash_cmds);
    g_test_add_func("/layerapi/test_layer_new_from_label_or_home", test_layer_new_from_label_or_home);
    g_test_add_func("/layerapi/test_layer_load", test_layer_load);
    g_test_add_func("/layerapi/test_layer_load2", test_layer_load2);
    g_test_add_func("/layerapi/test_layer_load3", test_layer_load3);
    g_test_add_func("/layerapi/test_layer_loaderror", test_layer_loaderror);
    layerapi2_init(FALSE);
    g_test_log_set_fatal_handler(log_fatal_func, NULL);
    int res = g_test_run();
    layerapi2_destroy();
    return res;
}
