CC = gcc
CFLAGS = -c
PROG = conway
DEFAULT = generic

c_vecinos: vecinos.c
	$(CC) $(CFLAGS) vecinos.c

c_version: version_c.c
	$(CC) $(CFLAGS) version_c.c

asm_version: version_asm.c
	$(CC) $(CFLAGS) version_asm.c

asm_vecinos: vecinos.S
	$(CC) $(CFLAGS) vecinos.S

conway: conway.c
	$(CC) $(CFLAGS) conway.c

mips: asm_vecinos asm_version conway
	$(CC) vecinos.o version_asm.o conway.o -o $(PROG)

generic: c_vecinos c_version conway
	$(CC) vecinos.o version_c.o conway.o -o $(PROG)

	
clean:
	rm -rf *.o $(PROG)
