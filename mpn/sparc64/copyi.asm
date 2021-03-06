dnl  SPARC v9 mpn_copyi -- Copy a limb vector, incrementing.

dnl  Copyright 1999, 2000, 2001, 2002 Free Software Foundation, Inc.

dnl  This file is part of the GNU MP Library.

dnl  The GNU MP Library is free software; you can redistribute it and/or modify
dnl  it under the terms of the GNU Lesser General Public License as published
dnl  by the Free Software Foundation; either version 2.1 of the License, or (at
dnl  your option) any later version.

dnl  The GNU MP Library is distributed in the hope that it will be useful, but
dnl  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
dnl  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
dnl  License for more details.

dnl  You should have received a copy of the GNU Lesser General Public License
dnl  along with the GNU MP Library; see the file COPYING.LIB.  If not, write to
dnl  the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
dnl  MA 02111-1307, USA.

include(`../config.m4')

C INPUT PARAMETERS
C rptr	%o0
C sptr	%o1
C n	%o2

C This code runs at 2 cycles/limb on UltraSPARC 1 and 2.

ASM_START()
	.register	%g2,#scratch
	.register	%g3,#scratch
PROLOGUE(mpn_copyi)
	addcc	%o2,-8,%o2
	bl,pt	%icc,L(end01234567)
	nop
L(loop1):
	ldx	[%o1+0],%g1
	ldx	[%o1+8],%g2
	ldx	[%o1+16],%g3
	ldx	[%o1+24],%g4
	ldx	[%o1+32],%g5
	ldx	[%o1+40],%o3
	ldx	[%o1+48],%o4
	ldx	[%o1+56],%o5
	add	%o1,64,%o1
	stx	%g1,[%o0+0]
	stx	%g2,[%o0+8]
	stx	%g3,[%o0+16]
	stx	%g4,[%o0+24]
	stx	%g5,[%o0+32]
	stx	%o3,[%o0+40]
	stx	%o4,[%o0+48]
	stx	%o5,[%o0+56]
	addcc	%o2,-8,%o2
	bge,pt	%icc,L(loop1)
	add	%o0,64,%o0
L(end01234567):
	addcc	%o2,8,%o2
	bz,pn	%icc,L(end)
	nop
L(loop2):
	ldx	[%o1+0],%g1
	add	%o1,8,%o1
	addcc	%o2,-1,%o2
	stx	%g1,[%o0+0]
	bg,pt	%icc,L(loop2)
	add	%o0,8,%o0
L(end):	retl
	nop
EPILOGUE(mpn_copyi)
