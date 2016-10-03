#include <mips/regdef.h>
	.text
	.align	2
	.globl 	vecinos
	.ent	vecinos
vecinos:
	.frame	$fp,40,ra
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp,40
	.cprestore 0

	sw 		$fp,36(sp)
	sw		gp,32(sp)
	move    $fp,sp

	sw      a0,40($fp) # *a
    sw      a1,44($fp) # i
    sw      a2,48($fp) # j
    sw      a3,52($fp) # M
    # N esta en la posicion 56 por default

    sw      zero,24($fp) # vivos = 0

    lw      v0,52($fp) # M

    addiu   v1,v0,-1 # M-1
    lw      v0,44($fp) # i
    
    bne     v0,v1,$contorno_ixd  #i!= M-1

    sw		zero,8($fp) # ixd = 0

    b       $contorno_ixd_else 
$contorno_ixd:
    lw      v0,44($fp) #i
    addiu   v0,v0,1 # i+1
    sw      v0,8($fp) # ixd=i+1
$contorno_ixd_else:
	lw      v0,56($fp) # N
    addiu   v1,v0,-1 # N-1
    lw      v0,48($fp) # j
    
    bne    v0,v1,$contorno_iyi #j!=N-1

    sw      zero,20($fp) # iyi = 0

    b       $contorno_iyi_else

$contorno_iyi:
    lw      v0,48($fp) # j
    addiu   v0,v0,1 # j+1
    sw      v0,20($fp) # iyi=j+1
$contorno_iyi_else:
	lw      v0,44($fp) # i
    
    bnez    v0,$contorno_iye # i!=0
   
    lw      v0,52($fp) # M
    addiu   v0,v0,-1 # M-1
    sw      v0,12($fp) # ixe=M-1;

    b       $contorno_iye_else

$contorno_iye:
	lw      v0,44($fp) # i
    addiu   v0,v0,-1 # i-1
    sw      v0,12($fp) # ixe=i-1;
$contorno_iye_else:
    lw      v0,48($fp) #j
    
    bnez    v0,$contorno_iys # j!=0
    
    lw      v0,56($fp) # N
    addiu   v0,v0,-1 # N-1
    sw      v0,16($fp) # iys=N-1

    b       $contorno_iys_else

$contorno_iys:
	lw      v0,48($fp) # j
    addiu   v0,v0,-1 # j-1
    sw      v0,16($fp) # iys=j-1

$contorno_iys_else:
    lw      v1,56($fp) # N
    lw      v0,8($fp) # ixd
    mult    v1,v0 # N*ixd 
    mflo    v1 
	lw      v0,48($fp) # j
   	addu    v1,v1,v0  # N*ixd+j
    lw      v0,40($fp) # a
    addu    v0,v1,v0 
    lbu     v1,0(v0) # a[N*ixd+j]
    li      v0,88 # ascii 'X'
	
$caso1:
	bne     v1,v0,$caso2 # a[N*ixd+j]!='X')
    
    lw      v0,24($fp) # vivos
    addiu   v0,v0,1 # vivos++
    sw      v0,24($fp)

$caso2: #se repite el proceso para los demas casos
    lw      v1,56($fp) # N
    lw      v0,12($fp) # ixe
    mult    v1,v0 # N*ixe
    mflo    v1
    lw      v0,48($fp) # j
	addu    v1,v1,v0 # N*ixe+j
    lw      v0,40($fp)
    addu    v0,v1,v0
    lbu     v1,0(v0) # a[N*ixe+j]
    li      v0,88

	bne     v1,v0,$caso3

    lw      v0,24($fp)
    addiu   v0,v0,1
    sw      v0,24($fp)

$caso3:
    lw      v1,56($fp) # N
	lw      v0,44($fp) # i
	mult    v1,v0 # N*i
	mflo    v1
	lw      v0,16($fp) # iys
	addu    v1,v1,v0 # N*i+iys
	lw      v0,40($fp)
	addu    v0,v1,v0
	lbu     v1,0(v0) # a[N*i+iys]
	li      v0,88

	bne     v1,v0,$caso4

	lw      v0,24($fp)
	addiu	v0,v0,1
	sw      v0,24($fp)

$caso4:
    lw      v1,56($fp) # N
	lw      v0,44($fp) # i
	mult    v1,v0 # N*i
	mflo    v1
	lw      v0,20($fp) # iyi
	addu    v1,v1,v0 # N*i+iyi
	lw      v0,40($fp)
	addu    v0,v1,v0
	lbu     v1,0(v0) # a[N*i+iyi]
	li      v0,88

	bne     v1,v0,$caso5

	lw      v0,24($fp)
	addiu   v0,v0,1
	sw      v0,24($fp)

$caso5:
    lw      v1,56($fp) # N
	lw      v0,8($fp) # ixd
	mult    v1,v0 # N*ixd
	mflo    v1
	lw      v0,16($fp) # iys
	addu    v1,v1,v0 # N*ixd+iys
	lw      v0,40($fp)
	addu    v0,v1,v0
	lbu     v1,0(v0) # a[N*ixd+iys]
	li      v0,88
	
	bne     v1,v0,$caso6

	lw      v0,24($fp)
	addiu   v0,v0,1
	sw      v0,24($fp)

$caso6:
    lw      v1,56($fp) # N
	lw      v0,12($fp) # ixe
	mult    v1,v0 # N*ixe
	mflo    v1
	lw      v0,16($fp) # iye
	addu    v1,v1,v0 # N*ixd+iys
	lw      v0,40($fp)
	addu    v0,v1,v0
	lbu     v1,0(v0) # a[N*ixd+iys]
	li      v0,88

	bne     v1,v0,$caso7

	lw      v0,24($fp)
	addiu   v0,v0,1
    sw      v0,24($fp)

$caso7:
    lw      v1,8($fp) # ixd
   	lw      v0,56($fp) # N
	mult    v1,v0 # N*ixd
	mflo    v1
	lw      v0,20($fp) # iyi
	addu    v1,v1,v0 # N*ixd+iyi
	lw      v0,40($fp)
	addu    v0,v1,v0
	lbu 	v1,0(v0) # a[N*ixd+iyi]
	li      v0,88

	bne     v1,v0,$caso8

	lw      v0,24($fp)
	addiu   v0,v0,1
	sw      v0,24($fp)

$caso8:       
    lw      v1,12($fp) # ixe
    lw      v0,56($fp) # N
	mult    v1,v0 # N*ixe
	mflo    v1
	lw      v0,20($fp) # iyi
	addu    v1,v1,v0 # N*ixe+iyi
	lw      v0,40($fp)
	addu    v0,v1,v0 # a[N*ixe+iyi]
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,$fin

	lw      v0,24($fp)
	addiu   v0,v0,1	
	sw      v0,24($fp)

$fin:
	lw      v0,24($fp) #cargi vivos a v0 para el return
    move    sp,$fp
   	lw      $fp,36(sp)
   	addiu   sp,sp,40
	jr      ra #return vivos
	.end vecinos
