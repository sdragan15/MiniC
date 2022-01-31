
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$0,-8(%14)
		MOV 	$2,-4(%14)
		MOV 	$0,-12(%14)
		ADDS	-4(%14), $1, %0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),-8(%14)
		MOV 	-4(%14),-12(%14)
		ADDS	-12(%14),-8(%14),%0
		MOV 	%0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET