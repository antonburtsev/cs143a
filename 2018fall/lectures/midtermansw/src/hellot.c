#include "param.h"
#include "types.h"
#include "user.h"
#include "syscall.h"

int main() {
  char * message = "aaa\n";
  int pid = fork();

  if(pid != 0){

    char *echoargv[] = { "echo", "Hello\n", 0 };
   
    message = "bbb\n";
    exec("echo", echoargv);
  }

  write(1, message, 4);
  exit();
}


