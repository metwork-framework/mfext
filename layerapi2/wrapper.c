#include <glib.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void empty_env(gchar **keeps)
{
    gchar **names = g_listenv();
    guint size = g_strv_length(names);
    guint keep_size = g_strv_length(keeps);
    for (guint i = 0 ; i < size ; i++) {
        gboolean found = FALSE;
        for (guint j = 0 ; j < keep_size ; j++) {
            if (g_strcmp0(names[i], keeps[j]) == 0) {
                found = TRUE;
                break;
            }
        }
        if (!found) {
            g_unsetenv(names[i]);
        }
    }
    g_strfreev(names);
}

int wrapper(int argc, char *argv[])
{
    int start = 1;
    if (g_strcmp0(argv[1], "--") == 0) {
        start = 2;
    }
    int new_argc = argc - 1 - (start - 1);
    const char *command = argv[start];
    gchar **command_args = g_malloc(sizeof(gchar*) * (new_argc + 1));
    for (int i = start ; i < argc ; i++ ) {
        command_args[i - start] = g_strdup(argv[i]);
    }
    command_args[new_argc] = NULL;
    int res = execvp(command, command_args);
    if (res != 0) {
        g_warning("can't launch command=%s", command);
    }
    return res;
}

int forced_wrapper(int argc, char *argv[], const char *command)
{
    int start = 1;
    if (g_strcmp0(argv[1], "--") == 0) {
        start = 2;
    }
    int new_argc = argc - (start - 1);
    gchar **command_args = g_malloc(sizeof(gchar*) * (new_argc + 1));
    command_args[0] = g_strdup(command);
    for (int i = start ; i < argc ; i++ ) {
        command_args[i - start + 1] = g_strdup(argv[i]);
    }
    command_args[new_argc] = NULL;
    int res = execvp(command, command_args);
    if (res != 0) {
        g_warning("can't launch command=%s", command);
    }
    return res;
}
