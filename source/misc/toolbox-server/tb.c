#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  if (argc < 2)
    return 0;

  int fd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (fd < 0) {
    perror("socket");
    return 1;
  }

  struct sockaddr_un addr = {.sun_family = AF_UNIX};
  snprintf(addr.sun_path, sizeof(addr.sun_path), "%s/tbx.sock",
           getenv("XDG_RUNTIME_DIR"));

  if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("connect");
    return 1;
  }

  for (int i = 1; i < argc; i++) {
    if (write(fd, argv[i], strlen(argv[i]) + 1) < 0) {
      perror("write");
      return 1;
    }
  }

  if (write(fd, "", 1) < 0) {
    perror("write");
    return 1;
  }

  close(fd);
  return 0;
}