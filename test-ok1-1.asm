
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@main_body:
		MOV 	$0,-8(%14)
		MOV 	$2,-4(%14)
		MOV 	$5,-12(%14)
		MOV 	$2,-16(%14)
		MOV 	$2,-20(%14)
@while_1:
		CMPS 	-8(%14),$5
		JGES	@while_1_exit
@while_1_continue:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		JMP	@while_1
@while_1_exit:
@while_2:
		CMPS	-4(%14), $0
		JEQ	@while_2_exit
		SUBS	-4(%14), $1, %0
		MOV 	%0,-4(%14)
@while_2_continue:
		MOV 	-8(%14),-8(%14)
		ADDS	$1, -8(%14), %0
		MOV 	%0,-8(%14)
		JMP	@while_2
@while_2_exit:
@while_3:
		CMPS	-12(%14), $0
		JEQ	@while_3_exit
		SUBS	-12(%14), $1, %0
		MOV 	%0,-12(%14)
@while_3_continue:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		JMP	@while_3
@while_3_exit:
@while_4:
		SUBS	-16(%14), $1, %0
		MOV 	%0,-16(%14)
		CMPS	-16(%14), $0
		JEQ	@while_4_exit
@while_4_continue:
		ADDS	-8(%14),$1,%0
		MOV 	%0,-8(%14)
		JMP	@while_4
@while_4_exit:
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET