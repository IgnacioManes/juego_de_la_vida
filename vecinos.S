#include <mips/regdef.h>

.text
	.align 2
	.globl vecinos
	.ent vecinos
	.ent 9a4
	.ent 9b4
	.ent 9dc
	.ent 9ec
	.ent a20
	.ent a40
	.ent a54
	.ent aec
	.ent b38
	.ent b84
	.ent bd0 
	.ent c1c
	.ent c68
	.ent fin

vecinos:
    lui     gp,0x0
    addiu   gp,gp,0
    addu    gp,gp,t9
    addiu   sp,sp,-40
    sw      gp,0(sp)
    sw      s8,36(sp)
    sw      gp,32(sp)
    move    s8,sp
    sw      a0,40(s8) # *a
    sw      a1,44(s8) # i
    sw      a2,48(s8) # j
    sw      a3,52(s8) # M
    sw      zero,24(s8)
    lw      v0,52(s8)
    nop
    addiu   v1,v0,-1
    lw      v0,44(s8)
    nop
    
    bne     v0,v1,9a4 
    
    nop
    
    b       9b4 
    
    sw      zero,8(s8)
9a4:
    lw      v0,44(s8)
    nop
    addiu   v0,v0,1
    sw      v0,8(s8)
9b4:
	lw      v0,56(s8)
    nop
    addiu   v1,v0,-1
    lw      v0,48(s8)
    nop
    sltu    v0,v0,v1
    
    bnez    v0,9dc
    
    nop
    b       9ec

    sw      zero,20(s8)
9dc:
    lw      v0,48(s8)
    nop
    addiu   v0,v0,1
    sw      v0,20(s8)
9ec:
	lw      v0,44(s8)
    nop
    
    bnez    v0,a10 
    
    nop
    lw      v0,52(s8)
    nop
    addiu   v0,v0,-1
    
    b       a20

    sw      v0,12(s8)
    lw      v0,44(s8)
    nop
    addiu   v0,v0,-1
    sw      v0,12(s8)
a20:
    lw      v0,48(s8)
    nop
    
    bnez    v0,a44
    
    nop
    lw      v0,56(s8)
    nop
    addiu   v0,v0,-1
    
    b       a54

a40:
	sw      v0,16(s8)
    lw      v0,48(s8)
    nop
    addiu   v0,v0,-1
    sw      v0,16(s8)
a54:
    lw      v1,56(s8)
    lw      v0,8(s8)
    nop
    mult    v1,v0
    mflo    v1
	lw      v0,48(s8)
    nop
   	addu    v1,v1,v0
    lw      v0,40(s8)
    nop
    addu    v0,v1,v0
    lbu     v1,0(v0)
    li      v0,88
	
	bne     v1,v0,aa0 
    
    nop
    lw      v0,24(s8)
    nop
    addiu   v0,v0,1
    sw      v0,24(s8)
aa0:
    lw      v1,56(s8)
    lw      v0,12(s8)
    nop
    mult    v1,v0
    mflo    v1
    lw      v0,48(s8)
    nop
	addu    v1,v1,v0
    lw      v0,40(s8)
    nop
    addu    v0,v1,v0
    lbu     v1,0(v0)
    li      v0,88

	bne     v1,v0,aec <vecinos+0x1a0>

    nop
    lw      v0,24(s8)
    nop
    addiu   v0,v0,1
    sw      v0,24(s8)
aec:
    lw      v1,56(s8)
	lw      v0,44(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,16(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,b38 

	nop
	lw      v0,24(s8)
	nop
	v0,v0,1
	sw      v0,24(s8)
b38:
    lw      v1,56(s8)
	lw      v0,44(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,20(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,b84

	nop
	lw      v0,24(s8)
	nop
	addiu   v0,v0,1
	sw      v0,24(s8)
b84:
    lw      v1,56(s8)
	lw      v0,8(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,16(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88
	
	bne     v1,v0,bd0

	nop
	lw      v0,24(s8)
	nop
	addiu   v0,v0,1
	sw      v0,24(s8)
bd0:
    lw      v1,56(s8)
	lw      v0,12(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,16(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,c1c

	nop
	lw      v0,24(s8)
	nop
	addiu   v0,v0,1
    sw      v0,24(s8)
c1c:
    lw      v1,8(s8)
   	lw      v0,56(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,20(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	v1,0(v0)
	li      v0,88

	bne     v1,v0,c68

	nop
	lw      v0,24(s8)
	nop
	addiu   v0,v0,1
	sw      v0,24(s8)
c68:       
    lw      v1,12(s8)
    lw      v0,56(s8)
	nop
	mult    v1,v0
	mflo    v1
	lw      v0,20(s8)
	nop
	addu    v1,v1,v0
	lw      v0,40(s8)
	nop
	addu    v0,v1,v0
	lbu     v1,0(v0)
	li      v0,88

	bne     v1,v0,fin

	nop
	lw      v0,24(s8)
	nop
	addiu   v0,v0,1
fin:	
	sw      v0,24(s8)
	lw      v0,24(s8)
    move    sp,s8
   	lw      s8,36(sp)
	jr      ra
    addiu   sp,sp,40

.end vecinos