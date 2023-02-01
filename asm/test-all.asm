.text 
	addi $0,$0,0	# $0=0
	addi $1,$0,1	# $1=1
	addiu $2,$1,2	# $2=3
	add $3,$1,$2	# $3=4
	addu $4,$2,$3	# $4=7
	and $5,$3,$4	# $5=4
	andi $6,$5,1	# $6=0
	beq $3,$5,add1	# jump to add1
	addi $1,$0,1	# shouldn't happen
func:
	addi $7,$0,4095	# $7=fff
	jr $31		# jump back to jal
add1:
	beq $2,$4,add2	# shouldn.t jump
	bne $2,$4,add2	# jump to add2
	addi $1,$0,1	# shouldn't happen
add2:
	div $4,$3		# hi=3,lo=1
	divu $3,$4	# hi=4,lo=0
	j add3		# jump to add3
	addi $1,$0,1	# shouldn't happen
add3:
	jal func		# jump to add4, $31=pc+4
	nor $8,$1,$0	# $8=ffff fffe
	or $9,$1,$8	# $9=ffff ffff
	ori $10,$0,15	# $10=f
	mult $9,$0	# hi=0,lo=0
	multu $9,$9	# hi=ffff fffe,lo=0000 0001
	sll $11,$1,3	# $11=8
	sllv $12,$1,$1	# $12=2
	slti $13,$12,1	# $13=0
	sltiu $13,$12,3	# $13=1
	sra $14,$8,1	# $14=ffff ffff
	srav $14,$8,$0	# $14=ffff fffe
	srl $15,$8,4	# $15=0fff ffff
	srlv $15,$15,$3	# $15=00ff ffff
	sub $16,$11,$12	# $16=6
	subu $16,$9,$15	# $16=ff00 0000
	xor $17,$16,$15	# $17=ffff ffff
	xori $18,$10,1	# $18=e
	lui $19,0x000f	# $19=000f 0000
	sb $10,50($0)	# byte=2, [50]=000f 0000
	sh $9,52($0)	# byte=0, [52]=0000 ffff
	sw $16,54($0)	# [54]=ff00 0000
	lb $20,52($0)	# byte=0, $20=ffff ffff
	lbu $21,52($0)	# byte=0, $21=0000 00ff
	lh $22,54($0)	# byte=1, $22=ffff ff00
	lhu $23,54($0)	# byte=1, $23=0000 ff00
	lw $24,50($0)	# $24=000f 0000
	sw $24,42($18)	# [42+e=56]=000f 0000
	
	
	