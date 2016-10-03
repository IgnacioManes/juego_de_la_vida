CC = gcc
CFLAGS = -c
PROG = conway
DEFAULT = generic

c_vecinos: vecinos.c
	$(CC) $(CFLAGS) vecinos.c

asm_vecinos: vecinos.S
	$(CC) $(CFLAGS) vecinos.S

conway: conway.c
	$(CC) $(CFLAGS) conway.c

mips: asm_vecinos conway
	$(CC) vecinos.o conway.o -o $(PROG)

generic: c_vecinos conway
	$(CC) vecinos.o conway.o -o $(PROG)

	
clean:
	rm -rf *.o $(PROG)
