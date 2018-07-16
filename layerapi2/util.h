#ifndef UTILS_H_
#define UTILS_H_

#include <glib.h>

#ifdef __GNUC__
#  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
#else
#  define UNUSED(x) UNUSED_ ## x
#endif

#ifdef __GNUC__
#  define UNUSED_FUNCTION(x) __attribute__((__unused__)) UNUSED_ ## x
#else
#  define UNUSED_FUNCTION(x) UNUSED_ ## x
#endif

GSList *lines_to_gslist(const gchar *lines);
gboolean test_file_presence_in_directory(const gchar *directory,
        const gchar *filename_to_read);
gchar *read_file_in_directory(const gchar *directory,
        const gchar *filename_to_read);
const gchar *get_python2_relative_site_packages();
const gchar *get_python3_relative_site_packages();
void field_remove_env(const gchar *env_variable, const gchar *value, gboolean use_wildcards, GString **bash_cmds);
void field_prepend_env(const gchar *env_variable, const gchar *value, GString **bash_cmds);
void conditional_add_extra_env(const gchar *directory, const gchar *filename, GString **bash_cmds);
void conditional_remove_extra_env(const gchar *directory, const gchar *filename, GString **bash_cmds);
void conditional_prepend_env(const gchar *directory, const gchar *directory_name,
        gboolean force_prepend, const gchar *env_variable, GString **bash_cmds);
void conditional_source(const gchar *directory, const gchar *filename_to_source, GString **bash_cmds);
gchar *field_prepend(const gchar *list_of_values, const gchar *value,
        const gchar *separator);
gchar *field_remove(const gchar *list_of_values, const gchar *value,
        const gchar *separator, gboolean use_wildcards);
GSList *file_in_directory_to_gslist(const gchar *directory,
        const gchar *filename_to_read);
gchar *replace_env_var_pattern(const gchar *string);

#endif /* UTILS_H_ */
