#include <glib.h>
#include <stdio.h>
#include <stdlib.h>

#include "util.h"
#include "log.h"

static gboolean __debug_mode = FALSE;

void log_handler(const gchar *UNUSED(log_d), GLogLevelFlags level,
        const gchar *msg, gpointer UNUSED(user_data))
{
    switch (level) {
        case G_LOG_LEVEL_ERROR:
            fprintf(stderr, "[ERROR]: %s\n", msg);
            exit(1);
            break;
        case G_LOG_LEVEL_CRITICAL:
            fprintf(stderr, "[CRITICAL]: %s\n", msg);
            break;
        case G_LOG_LEVEL_WARNING:
            fprintf(stderr, "[WARNING]: %s\n", msg);
            break;
        case G_LOG_LEVEL_MESSAGE:
        case G_LOG_LEVEL_INFO:
            fprintf(stderr, "[INFO]: %s\n", msg);
            break;
        case G_LOG_LEVEL_DEBUG:
            if (__debug_mode) {
                fprintf(stderr, "[DEBUG]: %s\n", msg);
            }
            break;
        default:
            fprintf(stderr, "[UNKNOWN]: %s\n", msg);
            break;
    }
}

void set_default_log_handler(gboolean debug_mode)
{
    __debug_mode = debug_mode;
    g_log_set_default_handler(log_handler, NULL);
}
