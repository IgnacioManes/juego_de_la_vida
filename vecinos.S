#include <mips/regdef.h>

.text
.align 2
.globl vecinos
.ent vecinos

vecinos:
	subu 	sp,sp,40
	#sw 		fp,36(sp)
	sw		gp,32(sp)
	#move    fp,sp
	sw      a0,40(sp) # *a
    sw      a1,44(sp) # i
    sw      a2,48(sp) # j
    sw      a3,52(sp) # M
    sw      s8,56(sp) # N

    sw      zero,24(sp) # vivos = 0

    lw      v0,52(sp) # M

    addiu   v1,v0,-1 # M-1
    lw      v0,44(sp) # i
    
    bne     v0,v1,contorno_ixd 

    sw		zero,8(sp) # ixd = 0

    b       contorno_ixd_else 
contorno_ixd:
    lw      v0,44(sp) #i
    addiu   v0,v0,1 # i+1
    sw      v0,8(sp) # ixd=i+1
contorno_ixd_else:
	lw      v0,56(sp) # N
    addiu   v1,v0,-1 # N-1
    lw      v0,48(sp) # j
    
    bne    v0,v1,contorno_iyi

    sw      zero,20(sp) # iyi = 0

    b       contorno_iyi_else

contorno_iyi:
    lw      v0,48(sp) # j
    addiu   v0,v0,1 # j+1
    sw      v0,20(sp) # iyi=j+1
contorno_iyi_else:
	lw      v0,44(sp)
    
    bnez    v0,contorno_iye 
   
    lw      v0,52(sp) # M
    addiu   v0,v0,-1 # M-1
    sw      v0,12(sp) # ixe=M-1;

    b       contorno_iye_else

contorno_iye:
	lw      v0,44(sp) # i
    addiu   v0,v0,-1 # i-1
    sw      v0,12(sp) # ixe=i-1;
contorno_iye_else:
    lw      v0,48(sp)
    
    bnez    v0,contorno_iys
    
    lw      v0,56(sp) # N
    addiu   v0,v0,-1 # N-1
    sw      v0,16(sp) # iys=N-1

    b       contorno_iys_else

contorno_iys:
	lw      v0,48(sp) # j
    addiu   v0,v0,-1 # j-1
    sw      v0,16(sp) # iys=j-1
contorno_iys_else:
    lw      v1,56(sp) # N
    lw      v0,8(sp) # ixd
    mult    v1,v0 # N*ixd 
    mflo    v1 
	lw      v0,48(sp) # j
   	addu    v1,v1,v0  # N*ixd+j
    lw      v0,40(sp) # a (la direcc a la que apunta el putnero)
    addu    v0,v1,v0
    lbu     v1,0(v0) # *(a)
    li      v0,88 # ascii 'X'
	
caso1:
	bne     v1,v0,caso2 # a[N*ixd+j]!='X')
    
    lw      v0,24(sp) # vivos
    addiu   v0,v0,1 # vivos++
    sw      v0,24(sp)
caso2: #se repite el proceso para los demas casos
    lw      v1,56(sp)
    lw      v0,12(sp)
    mult    v1,v0
    mflo    v1
    lw      v0,48(sp)
	addu    v1,v1,v0
    lw      v0,40(sp)
    addu    v0,v1,v0
    lbu     v1,0(v0)
    li      v0,88

	bne     v1,v0,caso3

    lw      v0,24(sp)
    addiu   v0,v0,1
    sw      v0,24(sp)
caso3:
    lw      v1,56(sp)
	lw      v0,44(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,16(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,caso4

	lw      v0,24(sp)
	addiu	v0,v0,1
	sw      v0,24(sp)
caso4:
    lw      v1,56(sp)
	lw      v0,44(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,20(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,caso5

	lw      v0,24(sp)
	addiu   v0,v0,1
	sw      v0,24(sp)
caso5:
    lw      v1,56(sp)
	lw      v0,8(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,16(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88
	
	bne     v1,v0,caso6

	lw      v0,24(sp)
	addiu   v0,v0,1
	sw      v0,24(sp)
caso6:
    lw      v1,56(sp)
	lw      v0,12(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,16(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,caso7

	lw      v0,24(sp)
	addiu   v0,v0,1
    sw      v0,24(sp)
caso7:
    lw      v1,8(sp)
   	lw      v0,56(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,20(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu 	v1,0(v0)
	li      v0,88

	bne     v1,v0,caso8

	lw      v0,24(sp)
	addiu   v0,v0,1
	sw      v0,24(sp)
caso8:       
    lw      v1,12(sp)
    lw      v0,56(sp)
	mult    v1,v0
	mflo    v1
	lw      v0,20(sp)
	addu    v1,v1,v0
	lw      v0,40(sp)
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,fin

	lw      v0,24(sp)
	addiu   v0,v0,1	
	sw      v0,24(sp)
fin:
	lw      v0,24(sp) #return vivos
    move    sp,sp
   	lw      sp,36(sp)
   	addiu   sp,sp,40
	jr      ra
	.end vecinos
