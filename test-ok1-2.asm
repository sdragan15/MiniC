
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$0,-8(%14)
		MOV 	$0,-4(%14)
		MOV 	$0,-12(%14)
@while_1:
		CMPS 	-8(%14),$10
		JGES	@while_1_exit
@while_1_continue:
@while_2:
		CMPS 	-4(%14),$2
		JGES	@while_2_exit
@while_2_continue:
		ADDS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP	@while_2
@while_2_exit:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		JMP	@while_1
@while_1_exit:
		ADDS	-8(%14),-4(%14),%0
		MOV 	%0,-12(%14)
		MOV 	-12(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET