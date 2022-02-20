
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@main_body:
		MOV 	$12,-4(%14)
@while_1:
		CMPS	-4(%14), $0
		JEQ	@while_1_exit
@while_1_continue:
		SUBS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP	@while_1
@while_1_exit:
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET