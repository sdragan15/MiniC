
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$5,-8(%14)
		MOV 	$6,-4(%14)
		MOV 	$0,-12(%14)
@while_1:
		CMPS	-8(%14), $0
		JEQ	@while_1_exit
		SUBS	-8(%14), $1, %0
		MOV 	%0,-8(%14)
@while_1_continue:
@while_2:
		CMPS	-4(%14), $0
		JEQ	@while_2_exit
		SUBS	-4(%14), $1, %0
		MOV 	%0,-4(%14)
@while_2_continue:
		ADDS	-12(%14),$1,%0
		MOV 	%0,-12(%14)
		JMP	@while_2
@while_2_exit:
		MOV 	$6,-4(%14)
		JMP	@while_1
@while_1_exit:
		MOV 	-12(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET