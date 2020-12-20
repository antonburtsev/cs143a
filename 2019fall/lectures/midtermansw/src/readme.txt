To build: 

  gcc -m32 hello-int.c

To look at secitons and disassembly (-s sections, -d disas):
  
  objdump -sd a.out

To compile a simple object file that fits on one screen 
(-c -- compile but don't link)
  
  gcc -m32 -fno-pic -c hello-int.c -o hello-int.o

Another useful tool is readelf, to list all sections: 

  readelf -a test



