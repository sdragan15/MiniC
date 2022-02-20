
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$16,%15
@main_body:
		MOV 	$0,-16(%14)
		MOV 	$0,-8(%14)
		MOV 	$0,-4(%14)
@for_1:
		CMPS 	-4(%14),$4
		JGES	@for_1_exit
		JMP	for_1_continue
@for_1_promena:
		ADDS	$1, -4(%14), %0
		MOV 	%0,-4(%14)
		JMP	@for_1
for_1_continue:
		MOV 	$0,-12(%14)
@for_2:
		CMPS 	-12(%14),$2
		JGES	@for_2_exit
		JMP	for_2_continue
@for_2_promena:
		ADDS	$1, -12(%14), %0
		MOV 	%0,-12(%14)
		JMP	@for_2
for_2_continue:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		MOV 	-12(%14),-16(%14)
		ADDS	$1, -12(%14), %0
		MOV 	%0,-12(%14)
		JMP	@for_2_promena
@for_2_exit:
		JMP	@for_1_promena
@for_1_exit:
		MOV 	$0,-4(%14)
@for_3:
		CMPS 	-4(%14),$4
		JGES	@for_3_exit
		JMP	for_3_continue
@for_3_promena:
		ADDS	$1, -4(%14), %0
		MOV 	%0,-4(%14)
		JMP	@for_3
for_3_continue:
		MOV 	$0,-12(%14)
@for_4:
		CMPS 	-12(%14),$2
		JGES	@for_4_exit
		JMP	for_4_continue
@for_4_promena:
		ADDS	$1, -12(%14), %0
		MOV 	%0,-12(%14)
		JMP	@for_4
for_4_continue:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		JMP	@for_4_promena
@for_4_exit:
		JMP	@for_3_promena
@for_3_exit:
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET