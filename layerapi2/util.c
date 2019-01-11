#include <glib.h>
#include <glib/gprintf.h>
#include <string.h>
#include "util.h"

static gchar *__python2_relative_site_packages = NULL;
static gchar *__python3_relative_site_packages = NULL;
static GRegex *__env_var_pattern = NULL;

/**
 * Tests the presence of a filename in a directory.
 *
 * @param directory directory fullpath.
 * @param filename_to_test filename (without path) to test.
 * @return TRUE if the filename exists in this directory.
 */
gboolean test_file_presence_in_directory(const gchar *directory,
        const gchar *filename_to_test)
{
    gboolean res = FALSE;
    gchar *custom_file = g_strdup_printf("%s/%s", directory, filename_to_test);
    if (g_file_test(custom_file, G_FILE_TEST_EXISTS) == TRUE) {
        res = TRUE;
    }
    g_free(custom_file);
    return res;
}

/**
 * Read a file in a directory and return the content (stripped).
 *
 * If the file contains {ENV_VAR_NAME} patterns, they will be
 * replaced by corresponding environnement variable values.
 *
 * @param directory directory fullpath.
 * @param filename_to_test filename (without path) to read.
 * @return file content (stripped), free it with g_free.
 */
gchar *read_file_in_directory(const gchar *directory,
        const gchar *filename_to_read)
{
    gchar *res = NULL;
    gchar *custom_file = g_strdup_printf("%s/%s", directory, filename_to_read);
    if (g_file_test(custom_file, G_FILE_TEST_EXISTS)) {
        gchar *contents = NULL;
        gboolean tmp = g_file_get_contents(custom_file, &contents, NULL, NULL);
        if (tmp == TRUE) {
            res = replace_env_var_pattern(g_strstrip(contents));
            g_free(contents);
        }
    }
    g_free(custom_file);
    return res;
}

/**
 * Convert some lines (read from a file) into an allocated GSList of gchar*.
 *
 * Note: each line is stripped, empty lines are ignored, lines beginning with #
 *       are ignored.
 *
 * @param lines text lines (read from a file).
 * @return allocated GSList (free with g_slist_free_full(list, g_free))
 */
GSList *lines_to_gslist(const gchar *lines)
{
    GSList *out = NULL;
    if (lines == NULL) {
        return out;
    }
    gchar **tmp = g_strsplit(lines, "\n", 0);
    for (guint i = 0 ; i < g_strv_length(tmp) ; i++) {
        gchar *tmp2 = g_strstrip(g_strdup(tmp[i]));
        if (strlen(tmp2) > 0) {
            if (tmp2[0] == '#') {
                g_free(tmp2);
            } else {
                out = g_slist_append(out, tmp2);
            }
        } else {
            g_free(tmp2);
        }
    }
    g_strfreev(tmp);
    return out;
}

/**
 * Convert the content of a file into an allocated GSList of gchar*.
 *
 * Note: this function combines read_file_in_directory and lines_to_gslist.
 *
 * @param directory directory fullpath
 * @param filename_to_read filename to read (without path)
 * @return allocated GSList (free with g_slist_free_full(list, g_free))
 */
GSList *file_in_directory_to_gslist(const gchar *directory,
        const gchar *filename_to_read)
{
    GSList *res = NULL;
    gchar *tmp = read_file_in_directory(directory, filename_to_read);
    if (tmp != NULL) {
        res = lines_to_gslist(tmp);
        g_free(tmp);
    }
    return res;
}

/**
 * Get the relative python2 site-packages path.
 *
 * The environnement is not read each time (a cache is used).
 *
 * @return the relative python2 site-packages path (from layer home).
 */
const gchar *get_python2_relative_site_packages()
{
    if (__python2_relative_site_packages == NULL) {
        __python2_relative_site_packages =
            g_strdup_printf("lib/python%s/site-packages",
                    g_getenv("PYTHON2_SHORT_VERSION"));
    }
    return __python2_relative_site_packages;
}

/**
 * Get the relative python3 site-packages path.
 *
 * The environnement is not read each time (a cache is used).
 *
 * @return the relative python3 site-packages path (from layer home).
 */
const gchar *get_python3_relative_site_packages()
{
    if (__python3_relative_site_packages == NULL) {
        __python3_relative_site_packages =
            g_strdup_printf("lib/python%s/site-packages",
                    g_getenv("PYTHON3_SHORT_VERSION"));
    }
    return __python3_relative_site_packages;
}

/**
 * Prepend a value in a list of values (as string) separated with a given separator.
 *
 * If the value is already in the list, the value is moved at the
 * beggining but not duplicated.
 *
 * @param list_of_values list of values (as string) separated with a separator.
 * @param value value to prepend.
 * @param separator separator of values.
 * @return allocated new list of values (as string) (free with g_free).
 */
gchar *field_prepend(const gchar *list_of_values, const gchar *value,
        const gchar *separator)
{
    if (value == NULL) {
        return g_strdup(list_of_values);
    }
    gchar **tmp = NULL;
    guint size = 0;
    if (list_of_values != NULL) {
        tmp = g_strsplit(list_of_values, separator, 0);
        size = g_strv_length(tmp);
    }
    GString *out = NULL;
    gboolean first = TRUE;
    if (strlen(value) > 0) {
        out = g_string_new(value);
        first = FALSE;
    } else {
        out = g_string_new(NULL);
    }
    for (guint i = 0 ; i < size ; i++) {
        if (g_strcmp0(tmp[i], value) != 0) {
            if (!first) {
                out = g_string_append(out, separator);
            }
            out = g_string_append(out, tmp[i]);
            first = FALSE;
        }
    }
    g_strfreev(tmp);
    return g_string_free(out, FALSE);
}

/**
 * Remove a value in a list of values (as string) separated with a given separator.
 *
 * You can use wildcards in value if you set use_wilcards=TRUE.
 *
 * @param list_of_values list of values (as string) separated with a separator.
 * @param value value to remove.
 * @param separator separator of values.
 * @param use_wildcards if TRUE, you can use wildcards (see g_pattern) in value.
 * @return allocated new list of values (as string) (free with g_free).
 */
gchar *field_remove(const gchar *list_of_values, const gchar *value,
        const gchar *separator, gboolean use_wildcards)
{
    if ((value == NULL) || (list_of_values == NULL))  {
        return g_strdup(list_of_values);
    }
    gchar **tmp = g_strsplit(list_of_values, separator, 0);
    guint size = g_strv_length(tmp);
    GString *out = g_string_new(NULL);
    GPatternSpec *pattern = NULL;
    gboolean first = TRUE;
    gboolean match = FALSE;
    if (use_wildcards) {
        pattern = g_pattern_spec_new(value);
    }
    for (guint i = 0 ; i < size ; i++) {
        if (!use_wildcards) {
            match = (g_strcmp0(tmp[i], value) == 0);
        } else {
            match = g_pattern_match_string(pattern, tmp[i]);
        }
        if (!match) {
            if (!first) {
                out = g_string_append(out, separator);
            }
            out = g_string_append(out, tmp[i]);
            first = FALSE;
        }
    }
    g_strfreev(tmp);
    if (use_wildcards) {
        g_pattern_spec_free(pattern);
    }
    return g_string_free(out, FALSE);
}

/**
 * Remove a value in an environnement variable containing list of values (as string) separated with a ":" separator.
 *
 * You can use wildcards in value if you set use_wilcards=TRUE.
 *
 * @param env_variable environnement variable containing list of values (as string) separated with a ":" separator.
 * @param value value to remove.
 * @param use_wildcards if TRUE, you can use wildcards (see g_pattern) in value.
 * @param bash_cmds if not NULL, bash commands to do the same operation in bash will be appended.
 */
void field_remove_env(const gchar *env_variable, const gchar *value,
        gboolean use_wildcards, GString **bash_cmds)
{
    const gchar *variable = g_getenv(env_variable);
    gchar *new_value;
    if (variable != NULL) {
        new_value = field_remove(variable, value, ":", use_wildcards);
    } else {
        new_value = field_remove("", value, ":", use_wildcards);
    }
    g_setenv(env_variable, new_value, TRUE);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "export %s=\"%s\";\n", env_variable, new_value);
    }
    g_free(new_value);
}

/**
 * Prepend a value in an environnement variable containing a list of values (as string) separated with the ":" separator.
 *
 * If the value is already in the list, the value is moved at the
 * beggining but not duplicated.
 *
 * @param env_variable environnement variable containing list of values (as string) separated with a ":" separator.
 * @param value value to prepend.
 * @param bash_cmds if not NULL, bash commands to do the same operation in bash will be appended.
 */
void field_prepend_env(const gchar *env_variable, const gchar *value,
        GString **bash_cmds)
{
    const gchar *variable = g_getenv(env_variable);
    gchar *new_value;
    if (variable != NULL) {
        new_value = field_prepend(variable, value, ":");
    } else {
        new_value = field_prepend("", value, ":");
    }
    g_setenv(env_variable, new_value, TRUE);
    if (bash_cmds != NULL) {
        g_string_append_printf(*bash_cmds, "export %s=\"%s\";\n",
                env_variable, new_value);
    }
    g_free(new_value);
}

/**
 * Prepend the fullpath of a directory in a given environnement variable containing list of values separated with ":" separator.
 *
 * If the directory does not exist and force_prepend is FALSE, the environnement variable is untouched
 *
 * @param directory root directory
 * @param directory_name directory name (will be added to directory variable with a "/" as separator) to get the fullpath of the directory.
 * @param env_variable environnement variable containing list of values (as string) separated with a separator.
 * @param bash_cmds if not NULL, bash commands to do the same operation in bash will be appended.
 * @see field_prepend_env
 */
void conditional_prepend_env(const gchar *directory, const gchar *directory_name,
        gboolean force_prepend, const gchar *env_variable, GString **bash_cmds)
{
    gchar *full_path = g_strdup_printf("%s/%s", directory, directory_name);
    if (force_prepend || g_file_test(full_path, G_FILE_TEST_IS_DIR) == TRUE) {
        field_prepend_env(env_variable, full_path, bash_cmds);
    }
    g_free(full_path);
}

/**
 * Append bash commands to source a file (if exists).
 *
 * @param directory fullpath of a directory.
 * @param filename_to_source filename (in the directory) to source if exists.
 * @param bash_cmds GString object to append commands (if != NULL).
 */
void conditional_source(const gchar *directory, const gchar *filename_to_source, GString **bash_cmds)
{
    if (bash_cmds == NULL) {
        return;
    }
    if (test_file_presence_in_directory(directory, filename_to_source) == TRUE) {
        gchar *custom_file2 = g_strdup_printf("%s/%s", directory, filename_to_source);
        g_string_append_printf(*bash_cmds, "source \"%s\";\n", custom_file2);
        g_free(custom_file2);
    }
}

static gboolean _eval_cb(const GMatchInfo *info, GString *res, gpointer UNUSED(data))
{
    gchar *match = g_match_info_fetch (info, 0);
    gchar *env_var = match + sizeof(gchar);
    env_var[strlen(env_var) - 1] = '\0';
    gchar *env_value = g_strdup(g_getenv(env_var));
    if (env_value != NULL) {
          res = g_string_append(res, env_value);
          g_free(env_value);
    }
    g_free(match);
    return FALSE;
}

gchar *replace_env_var_pattern(const gchar *string)
{
    if (string == NULL) {
        return NULL;
    }
    if (__env_var_pattern == NULL) {
        __env_var_pattern = g_regex_new("{[a-z0-9A-Z_]+}", 0, 0, NULL);
    }
    return g_regex_replace_eval(__env_var_pattern, string, -1, 0, 0, _eval_cb, NULL, NULL);
}

void _conditional_extra_env(const gchar *directory, const gchar *filename,
        GString **bash_cmds, const gchar *action)
{
    if (test_file_presence_in_directory(directory, filename) == TRUE) {
        gchar *content = NULL;
        gchar *file_full_path = g_strdup_printf("%s/%s", directory, filename);
        gboolean res = g_file_get_contents(file_full_path, &content, NULL, NULL);
        if (res == FALSE) {
            g_free(file_full_path);
            return;
        }
        gchar **tmp = g_strsplit(content, "\n", 0);
        guint size = g_strv_length(tmp);
        for (guint i = 0 ; i < size ; i++) {
            gchar *line = g_strstrip(tmp[i]);
            if ((line != NULL) && (strlen(line) > 0) && (line[0] != '#')) {
                gchar **tmp2 = g_strsplit(line, "=", 2);
                if (g_strv_length(tmp2) == 2) {
                    if (g_strcmp0(action, "ADD") == 0) {
                        const gchar *value = g_strstrip(tmp2[1]);
                        const gchar *key = g_strstrip(tmp2[0]);
                        size_t value_length = strlen(value);
                        gchar *new_value = NULL;
                        if (value_length >=3) {
                            new_value = replace_env_var_pattern(value);
                        } else {
                            new_value = g_strdup(value);
                        }
                        if (new_value == NULL) {
                            g_setenv(key, "", TRUE);
                            if (bash_cmds != NULL) {
                                g_string_append_printf(*bash_cmds,
                                        "export %s=\"\";\n", key);
                            }
                        } else {
                            g_setenv(key, new_value, TRUE);
                            if (bash_cmds != NULL) {
                                g_string_append_printf(*bash_cmds,
                                        "export %s=\"%s\";\n", key, new_value);
                            }
                        }
                        g_free(new_value);
                    } else {
                        // REMOVE
                        g_unsetenv(g_strstrip(tmp2[0]));
                        if (bash_cmds != NULL) {
                            g_string_append_printf(*bash_cmds,
                                    "unset %s;\n", g_strstrip(tmp2[0]));
                        }
                    }
                }
                g_strfreev(tmp2);
            }
        }
        g_free(file_full_path);
        g_strfreev(tmp);
        g_free(content);
    }
}

/**
 * Add some environnement variables read in a special file.
 *
 * The file is read line by line (if the line starts with # => it's a comment).
 * Each line must follow the syntaxe ENV_VAR=ENV_VALUE (without spaces).
 * If the ENV_VALUE contains {OTHER_ENV_VAR_NAME} patterns, they will be
 * replaced by corresponding environnement variable values.
 *
 * @param directory directory to search for extraenv file.
 * @param filename name of the file containing environnement variables to set.
 * @param bash_cmds if not NULL, bash commands to do the same operation in bash will be appended.
 */
void conditional_add_extra_env(const gchar *directory, const gchar *filename,
        GString **bash_cmds)
{
    _conditional_extra_env(directory, filename, bash_cmds, "ADD");
}

/**
 * Remove some environnement variables read in a special file.
 *
 * This is the opposite operation if conditional_add_extra_env. The same file
 * should be used even if values are not used in this function.
 *
 * @param directory directory to search for extraenv file.
 * @param filename name of the file containing environnement variables to remove.
 * @param bash_cmds if not NULL, bash commands to do the same operation in bash will be appended.
 */
void conditional_remove_extra_env(const gchar *directory, const gchar *filename,
        GString **bash_cmds)
{
    _conditional_extra_env(directory, filename, bash_cmds, "REMOVE");
}
