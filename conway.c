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
	fclose(archp);
}

void inicializar_valores(unsigned int nfil, unsigned int ncol, char* matriz){
	for(int i=0; i<nfil-1; i++){
		for(int j=0; j<ncol-1; j++){
			matriz[i*nfil+j]='-';
		}
	}
}


void parsear_posiciones (const char* nombre_arch, unsigned int nfil
				, unsigned int ncol, char* matriz){
	FILE* archp = fopen(nombre_arch, "r");
	unsigned int i;
	char buffer[5];
	char char_actual;
	int x;
	int y;
	inicializar_valores(nfil, ncol, matriz);
	while (!feof(archp)){
		while(fgetc(archp) != ','){
			i = 0;
			char_actual = fgetc(archp);
			buffer[i] = char_actual;
			i++;
		}
		while(i<6){
			buffer[i]=' ';
			i++;
		}
		x=atoi(buffer);
		if (x<nfil && x>0){
			while(fgetc(archp) != '\n'){
				i = 0;
				char_actual = fgetc(archp);
				buffer[i] = char_actual;
				i++;
			}
			while(i<6){
				buffer[i]=' ';
				i++;
			}
			y=atoi(buffer);
			if (y<ncol && y>0){			
				matriz[(y-1)*nfil+(x-1)]='X';
			}
			else{
				fprintf(stderr, "Posicion invalida\n");
			}
		}else{
			fprintf(stderr, "Posicion invalida\n");
		}
	}
	fclose(archp);
}


int main(int args, const char* argv[]){

	if(args == 2){
		unsigned int nfilas;
		unsigned int ncolumnas;
		unsigned int niterac;
		parsear_datos(argv[0], &nfilas, &ncolumnas, &niterac);
		char* matriz = malloc(ncolumnas * nfilas * sizeof(char));
		parsear_posiciones(argv[1], nfilas, ncolumnas, matriz);

  	free(matriz);

	}else if(args == 4){
		unsigned int niterac = atoi(argv[0]);
		unsigned int nfilas = atoi(argv[1]);
		unsigned int ncolumnas = atoi(argv[2]);
		char* matriz = malloc(ncolumnas * nfilas * sizeof(char));
		parsear_posiciones(argv[3], nfilas, ncolumnas, matriz);

  	free(matriz);
	}else{
		fprintf(stderr, "Error de argumentos\n");
		return 1;
	}
}
