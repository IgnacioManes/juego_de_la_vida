#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
//#include "funciones.h"

void parsear_datos(const char* nombre_arch, unsigned int* nfil
				, unsigned int* ncol, unsigned int* niter){
	FILE* archp = fopen(nombre_arch, "r");
	unsigned int i;
	char buffer[5];
	char char_actual;
	while(fgetc(archp) != ' '){
		i = 0;
		char_actual = fgetc(archp);
		buffer[i] = char_actual;
		i++;
	}
	while(i<6){
		buffer[i]=' ';
		i++;
	}
	*nfil = atoi(buffer);
	while(fgetc(archp) != ' '){
		i = 0;
		char_actual = fgetc(archp);
		buffer[i] = char_actual;
		i++;
	}
	while(i<6){
		buffer[i]=' ';
		i++;
	}
	*ncol = atoi(buffer);
	while(fgetc(archp) != ' '){
		i = 0;
		char_actual = fgetc(archp);
		buffer[i] = char_actual;
		i++;
	}
	while(i<6){
		buffer[i]=' ';
		i++;
	}
	*niter = atoi(buffer);
}

int main(int args, const char* argv[]){
	if(args == 2){
	unsigned int nfilas;
	unsigned int ncolumnas;
	unsigned int niterac;
	parsear_datos(argv[0], &nfilas, &ncolumnas ,&niterac);
	unsigned int matriz [nfilas][ncolumnas];
	//parsear_posiciones(argv[1], *matriz);

	}else if(args == 4){
	unsigned int niterac = atoi(argv[0]);
	unsigned int nfilas = atoi(argv[1]);
	unsigned int ncolumnas = atoi(argv[2]);
	unsigned int matriz [nfilas][ncolumnas];
	//parsear_posiciones(argv[1], *matriz);
	}else{
		fprintf(stderr, "Error de argumentos\n");
		return 1;
	}
}
