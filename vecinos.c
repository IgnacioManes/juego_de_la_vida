#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>

unsigned int vecinos(unsigned char *a, unsigned int i, unsigned int j,
											unsigned int M, unsigned int N){
	int ixd, ixe, iys, iyi, vivos;
	vivos=0;
	if(i==M-1)
	 	ixd=0;
	else
	  ixd=i+1;
	if(j==N-1)
	  iyi=0;
	else
	 	iyi=j+1;
	if(i==0)
	  ixe=M-1;
	else
	  ixe=i-1;
	if(j==0)
	  iys=N-1;
	else
	  iys=j-1;
	//comprobación para saber si los vecinos están vivos o muertos
	if(a[N*ixd+j]=='X')    vivos++;
	if(a[N*ixe+j]=='X')    vivos++;
	if(a[N*i+iys]=='X')    vivos++;
	if(a[N*i+iyi]=='X')    vivos++;
	if(a[N*ixd+iys]=='X')   vivos++;
	if(a[N*ixe+iys]=='X')   vivos++;
	if(a[ixd*N+iyi]=='X')   vivos++;
	if(a[ixe*N+iyi]=='X')   vivos++;
	return vivos;
}
