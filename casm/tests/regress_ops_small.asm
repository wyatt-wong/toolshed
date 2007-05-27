	lib	casm.inc

*
* Regression test for code generation. The output generated by CASM is
* compared against that of CCASM by Roger Taylor. 
*
	org	$0000
	setdp	$ff

tst_bit	macro	op
	{op}	a,0,1,$80
	{op}	b,7,1,$f0
	{op}	a,1,0,$80
	{op}	b,1,7,$f0
	{op}	a,7,7,$ff
	{op}	cc,3,5,$ff
*	{op}	dp,6,3,$94
	endm
	
tst_idx	macro	op
	{op}	,x
	{op}	,x+
	{op}	,-x
	{op}	,x++
	{op}	,w++
	{op}	,--x
	{op}	,--w
	
	{op}	a,x
	{op}	w,x
	{op}	15,x
	{op}	15,w
	{op}	-15,x
;	{op}	-15,w
	
	{op}	127,x
	{op}	127,w
	{op}	-127,x
	{op}	-127,w
	{op}	32767,x
;	{op}	32767,w
	
	{op}	-32768,x
;	{op}	-32768,w
	
	{op}	[$0000]
	{op}	[$0080]
	{op}	[$4000]
	
	{op}	[,x]
	{op}	[,w]
	
	{op}	[,x++]
	{op}	[,w++]
	{op}	[,--x]
	{op}	[,--w]

	{op}	[15,x]
	{op}	[15,w]
;	{op}	[-15,x]
;	{op}	[-15,w]

	{op}	[127,x]
	{op}	[127,w]
	{op}	[-127,x]
;	{op}	[-127,w]
	
	{op}	[32767,x]
	{op}	[32767,w]
	{op}	[-32767,x]
;	{op}	[-32767,w]
	
* This test does not pass due to descrepencies on CCASM's part
	if	0
	{op}	,pc
	{op}	0,pc
	{op}	15,pc
	{op}	-15,pc
	{op}	127,pc
	{op}	-127,pc
	{op}	32767,pc
	{op}	-32768,pc
	{op}	[0,pc]
	{op}	[,pc]
	{op}	[15,pc]
	{op}	[-16,pc]
	{op}	[127,pc]
	{op}	[-127,pc]
	{op}	[32767,pc]
	{op}	[-32767,pc]
	endif

	endm



tst_mop	macro	op,val
	{op}	{val};$ff
	{op}	{val};$3333
	{op}	{val};,x
	{op}	{val};,x+
	{op}	{val};,x++
	{op}	{val};15,x
	{op}	{val};-16,x
	{op}	{val};127,x
	{op}	{val};-128,x
	{op}	{val};32767,x
	{op}	{val};-32768,x
	{op}	{val};[$0000]
	{op}	{val};[$0080]
	{op}	{val};[$4000]
	{op}	{val};[,x]
	{op}	{val};[,x++]
	{op}	{val};[15,x]
;	{op}	{val};[-15,x]
	{op}	{val};[127,x]
	{op}	{val};[-127,x]
	{op}	{val};[32767,x]
	{op}	{val};[-32767,x]
	{op}	{val};,x
	endm



tst_rr	macro	op
	{op}	a,b
	{op}	x,d
	{op}	v,x
	{op}	s,u
	endm



tst_pp	macro	op,reg
	{op}	cc,a,b,dp,x,y,{reg},pc
	{op}	cc,d,dp,x,y,{reg},pc
	{op}	cc
	{op}	a
	{op}	b
	{op}	d
	{op}	dp
	{op}	x
	{op}	y
	{op}	{reg}
	{op}	pc
	endm



test0	macro	op
	{op}	$ff01	* Test direct mode
	{op}	$3333	* Test extended mode
	endm


test1	macro	op
	{op}	#$01	* Test immediate mode
	test0	{op}
	endm



test3	macro	op
@a	nop
	nop
	{op}	@a
	{op}	@b
	nop
@b	nop

	endm



test4	macro	op
	tst_idx	{op}
	endm
	

	
	test4	adca

	abx
	test1	adca
	test1	adcb
	test1	adcd
	test1	adda
	test1	addb
	test1	addd
	test1	adde
	test1	addf
	test1	addw
	test1	anda
	test1	andb
	andcc	#$ff
	test1	andd
	test0	asl
	asla
	aslb
	asld
	test0	asr
	asra
	asrb
	asrd
	test3	bcc
	test3	bcs
	test3	beq
	test3	bge
	test3	bgt
	test3	bhi
	test3	bhs
	test1	bita
	test1	bitb
	test1	bitd
	bitmd	#$11
	test3	ble
	test3	blo
	test3	bls
	test3	blt
	test3	bmi
	test3	bne
	test3	bpl
	test3	bra
	test3	brn
	test3	bsr
	test3	bvc
	test3	bvs
	test0	clr
	clra
	clrb
	clrd
	clre
	clrf
	clrw
	test1	cmpa
	test1	cmpb
	test1	cmpd
	test1	cmpe
	test1	cmpf
	test1	cmps
	test1	cmpu
	test1	cmpw
	test1	cmpx
	test1	cmpy
	test0	com
	coma
	comb
	comd
	come
	comf
	comw
	cwai	#$44
	daa
	test0	dec
	deca
	decb
	decd
	dece
	decf
	decw
	test1	divd
	test1	divq
	test1	eora
	test1	eorb
	test1	eord
	test0	inc
	inca
	incb
	incd
	ince
	incf
	incw
	test0	jmp
	test0	jsr
	test3	lbcc
	test3	lbcs
	test3	lbeq
	test3	lbge
	test3	lbgt
	test3	lbhi
	test3	lbhs
	test3	lble
	test3	lblo
	test3	lbls
	test3	lblt
	test3	lbmi
	test3	lbne
	test3	lbpl
	test3	lbra
	test3	lbrn
	test3	lbsr
	test3	lbvc
	test3	lbvs
	test1	lda
	test1	ldb
	test1	ldd
	test1	lde
	test1	ldf
	ldmd	#$ff
	test1	ldq
	test1	lds
	test1	ldu
	test1	ldy
	test1	ldx
	tst_idx	leas
	tst_idx	leau
	tst_idx	leay
	tst_idx	leax
	test0	lsl
	lsla
	lslb
	test0	lsr
	lsra
	lsrb
	lsrd
	lsrw
	mul
	test1	muld
	test0	neg
	nega
	negb
	negd
	nop
	test0	ora
	test0	orb
	orcc	#$ff
	test0	ord
	tst_pp	pshs,u
	tst_pp	puls,u
	tst_pp	pshu,s
	tst_pp	pulu,s
	pshsw
	pshuw
	pulsw
	puluw
	test0	rol
	rola
	rolb
	rold
	rolw
	test0	ror
	rora
	rorb
	rord
	rorw
	rti
	rts
	test1	sbca
	test1	sbcb
	test1	sbcd
	sex
	sexw
	test0	sta
	test0	stb
	test0	std
	test0	ste
	test0	stf
	test0	stw
	test0	sts
	test0	stu
	test0	stx
	test0	sty
	test1	suba
	test1	subb
	test1	subd
	test1	sube
	test1	subf
	test1	subw
	swi
	swi2
	swi3
	sync
	test0	tst
	tsta
	tstb
	tstd
	tste
	tstf
	tstw
	tst_rr	tfr
	tst_rr	exg
	tst_rr	adcr
	tst_rr	addr
	tst_rr	andr
	tst_rr	orr
	tst_rr	cmpr
	tst_rr	eorr
	tst_rr	sbcr
	tst_rr	subr
	tst_mop	aim,#$44
	tst_mop	eim,#$55
	tst_mop	oim,#$dd
	tst_mop	tim,#$88
	tst_bit	ldbt
	tst_bit	stbt
	tst_bit	band
	tst_bit	biand
	tst_bit	bor
	tst_bit	bior
	tst_bit	beor
	tst_bit	bieor
*
* Test memory transfers with TFM. CCASM does not appear to support the TFM
* operand so we conditional it out
*
	if	__CASM__=1&CCASM_ONLY=1
	tfm	x+,y+
	tfm	x-,y-
	tfm	x,y+
	tfm	x+,y
	endif
*
	copy	x,y
	copy-	x,y
	imp	x,y
	exp	x,y
	tfrp	x,y
	tfrm	x,y
	tfrs	x,y
	tfrr	x,y

