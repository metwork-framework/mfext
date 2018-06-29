#ifndef WRAPPER_H_
#define WRAPPER_H_

void empty_env(gchar **keeps);
int wrapper(int argc, char *argv[]);
int forced_wrapper(int argc, char *argv[], const char *command);

#endif /* WRAPPER_H_ */
