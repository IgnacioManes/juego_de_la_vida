#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
//#include "funciones.h"

#define PIXEL_WIDTH 40
#define PIXEL_HEIGHT 40

int parsear_datos(const char* nombre_arch, unsigned int* nfil
				, unsigned int* ncol, unsigned int* niter){
	FILE* archp = fopen(nombre_arch, "r");
	unsigned int i;
	char buffer[5];
	char char_actual;
	if(archp!=NULL){
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
		return 0;
	}else{
		return 1;
	}
}

void inicializar_valores(unsigned int nfil, unsigned int ncol, char* matriz){
	int i = 0, j = 0;
	for(; i<nfil; i++){
		j = 0;
		for(; j<ncol; j++){
			matriz[i*nfil+j]='-';
		}
	}
}

int parsear_posiciones (const char* nombre_arch, unsigned int nfil
				, unsigned int ncol, char* matriz){
	FILE* archp = fopen(nombre_arch, "r");
	if(archp!=NULL){
		unsigned int i;
		char buffer[5];
		char char_actual;
		int x;
		int y;
		inicializar_valores(nfil, ncol, matriz);
		char_actual = fgetc(archp);
		while (!(feof(archp))){
			i = 0;
			while(char_actual != ' '){
				buffer[i] = char_actual;
				char_actual = fgetc(archp);
				i++;
			}
			while(i<5){
				buffer[i]=' ';
				i++;
			}
			x=atoi(buffer);
			char_actual = fgetc(archp);
			i = 0;
			while(char_actual != '\n'){
				buffer[i] = char_actual;
				char_actual = fgetc(archp);
				i++;
			}
			while(i<5){
				buffer[i]=' ';
				i++;
			}
			y=atoi(buffer);
			if (y<ncol && x<nfil){
				matriz[(y-1)*nfil+(x-1)]='X';
			}else{
				fprintf(stderr, "Posicion invalida\n");
			}
			char_actual = fgetc(archp);
		}
		fclose(archp);
		return 0;
	}else{
		return 1;
	}
}

int obtener_valor_numerico(unsigned int fil, unsigned int col, unsigned int nfil, char* matriz) {
    unsigned char value = matriz[fil*nfil+col];
    if (value == '-') {
        return 0;
    } else {
        return 1;
    }
}

void escribir_pbm(int nfil,int ncol,char* matriz) {
    int width = PIXEL_WIDTH;
    int height = PIXEL_HEIGHT;
    FILE *bit_map = fopen("matriz.pbm", "w");
    fprintf(bit_map, "%s\n", "P1"); // Header
    fprintf(bit_map, "%d %d\n", nfil*PIXEL_HEIGHT, ncol * PIXEL_WIDTH); // Width and Height

    for (int i = 0; i < nfil; ++i) { // Writing the image
        for (int pixY = 0; pixY < height; ++pixY) {
            for (int j = 0; j < ncol; ++j) {
                for (int pixX = 0; pixX < width; ++pixX) {
                    unsigned char valor = obtener_valor_numerico(i, j, nfil, matriz);
                    fprintf(bit_map, "%d ", valor);
                }
            }
            putc('\n', bit_map);
        }
    }
    fclose( bit_map );
}

void mostrar_matriz(int nfil,int ncol,char* matriz){
	int i = 0, j= 0 ;
	for(;i<nfil;i++){
		j = 0;
		for(;j<ncol;j++){
			printf("%c",matriz[i*nfil+j]);
		}
		printf("\n");
	}
	printf("\n");
}

void iterar_matriz(int niterac, int nfil,int ncol,char* matriz){
	char matriz_aux[nfil][ncol];
	int ix, iy, ixd, ixe, iys, iyi, vivos;
	for(ix=0;ix<nfil;ix++){
		for(iy=0;iy<ncol;iy++){
			matriz_aux[ix][iy]=matriz[ix*nfil+iy];
		}
	}
	for(int i=0; i<niterac; i++){
		//recorrido total para comprobar si ha llegado al limite de la tabla
		printf("Iteracion numero: %d \n",i+1);
		for(ix=0; ix<nfil; ix++)
		{
		  for(iy=0; iy<ncol; iy++)
	  	{//Vecinos inicio
	    	vivos=0;
	    	if(ix==nfil-1)
		    	ixd=0;
		    else
		      ixd=ix+1;
		    if(iy>=ncol-1)
		      iyi=0;
		    else
		    	iyi=iy+1;
		    if(ix<=0)
		      ixe=nfil-1;
		    else
		      ixe=ix-1;
		    if(iy<=0)
		      iys=ncol-1;
		    else
		      iys=iy-1;
		    //comprobación para saber si los vecinos están vivos o muertos
		    if(matriz[nfil*ixd+iy]=='X')    vivos++;
		    if(matriz[nfil*ixe+iy]=='X')    vivos++;
		    if(matriz[nfil*ix+iys]=='X')    vivos++;  
		    if(matriz[nfil*ix+iyi]=='X')    vivos++;
		    if(matriz[nfil*ixd+iys]=='X')   vivos++;
		    if(matriz[nfil*ixe+iys]=='X')   vivos++;
		    if(matriz[ixd*nfil+iyi]=='X')   vivos++;
		    if(matriz[ixe*nfil+iyi]=='X')   vivos++;
		    //Vecinos fin
		    //condicional para determinar si la casilla vive o muere
			  if(matriz[ix*nfil+iy]=='X')
		  		{
		    	// esta vivo
		      if(vivos<=1 || vivos>3)
		      {
		       	matriz_aux[ix][iy]='-';
		      }else{
		        matriz_aux[ix][iy]='X';
		      }
		    }else{
		     	// esta muerto
		     	if(vivos==3)
		     	{
		       	matriz_aux[ix][iy]='X';
		     	}else{
						matriz_aux[ix][iy]='-';
		     	}
		    }
		  }// final del for iy
		} // final del for ix
	for(int ix=0;ix<nfil;ix++){
		for(int iy=0;iy<ncol;iy++){
			matriz[ix*nfil+iy]=matriz_aux[ix][iy];
		}
	}
	mostrar_matriz(nfil, ncol, matriz);
	}
	escribir_pbm(nfil, ncol, matriz);
}

int main(int argc, char** argv){
	if(argc == 3){
		unsigned int nfilas;
		unsigned int ncolumnas;
		unsigned int niterac;
		int estado = parsear_datos(argv[1], &nfilas, &ncolumnas, &niterac);
		if(estado==0){
			char* matriz = malloc(ncolumnas * nfilas * sizeof(char));
			estado = parsear_posiciones(argv[2], nfilas, ncolumnas, matriz);
			if (estado == 0){
				printf("Estado inicial\n");
				mostrar_matriz(nfilas, ncolumnas, matriz);
				escribir_pbm(nfilas, ncolumnas, matriz);
				iterar_matriz(niterac, nfilas, ncolumnas, matriz);
				free(matriz);
				return 0;
			}else{
			fprintf(stderr,"Error al abrir el archivo %s\n",argv[1]);
				return 1;
			}
		}else{
			fprintf(stderr,"Error al abrir el archivo %s\n",argv[2]);
			return 1;
		}
	}else if(argc == 5){
		unsigned int niterac = atoi(argv[1]);
		unsigned int nfilas = atoi(argv[2]);
		unsigned int ncolumnas = atoi(argv[3]);
		char* matriz = malloc(ncolumnas * nfilas * sizeof(char));
		int estado = parsear_posiciones(argv[4], nfilas, ncolumnas, matriz);
		if(estado==0){
			printf("Estado inicial\n");
			mostrar_matriz(nfilas, ncolumnas, matriz);
			escribir_pbm(nfilas, ncolumnas, matriz);
			iterar_matriz(niterac, nfilas, ncolumnas, matriz);
  		free(matriz);
  		return 0;
  	}else{
			fprintf(stderr,"Error al abrir el archivo %s\n",argv[4]);
			return 1;
		}
	}else{
		fprintf(stderr, "Error de argumentos\n");
		return 1;
	}
}
