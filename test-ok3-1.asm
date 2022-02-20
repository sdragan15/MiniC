
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$0,-8(%14)
		MOV 	$1,-4(%14)
@for_1:
		CMPS 	-4(%14),$4
		JGES	@for_1_exit
		JMP	for_1_continue
@for_1_promena:
		ADDS	$1, -4(%14), %0
		MOV 	%0,-4(%14)
		JMP	@for_1
for_1_continue:
		ADDS	-8(%14),-4(%14),%0
		MOV 	%0,-8(%14)
		JMP	@for_1_promena
@for_1_exit:
		MOV 	$0,-4(%14)
@for_2:
		CMPS 	-4(%14),$10
		JGES	@for_2_exit
		JMP	for_2_continue
@for_2_promena:
		ADDS	-4(%14),$8,%0
		MOV 	%0,-4(%14)
		JMP	@for_2
for_2_continue:
		ADDS	-8(%14),-4(%14),%0
		MOV 	%0,-8(%14)
		JMP	@for_2_promena
@for_2_exit:
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET