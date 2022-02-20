
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$60,%15
@main_body:
		MOV 	$0,-4(%14)
		SUBS	%14, $8, %0
		MOV 	$6,(%0)
		SUBS	%14, $12, %0
		MOV 	$4,(%0)
		SUBS	%14, $20, %0
		MOV 	$10,(%0)
		SUBS	%14, $36, %0
		MOV 	$3,(%0)
@while_1:
		SUBS	%14, $8, %0
		CMPS	(%0), $0
		JEQ	@while_1_exit
@while_1_continue:
		ADDS	-4(%14),$1,%1
		MOV 	%1,-4(%14)
		SUBS	%14, $8, %1
		SUBS	(%1),$1,%1
		SUBS	%14, $8, %2
		MOV 	%1,(%2)
		JMP	@while_1
@while_1_exit:
		MOV 	$1,-60(%14)
@for_1:
		SUBS	%14, $36, %1
		CMPS 	-60(%14),(%1)
		JGTS	@for_1_exit
		JMP	for_1_continue
@for_1_promena:
		ADDS	$1, -60(%14), %1
		MOV 	%1,-60(%14)
		JMP	@for_1
for_1_continue:
		SUBS	%14, $12, %1
		ADDS	-4(%14),(%1),%1
		MOV 	%1,-4(%14)
		JMP	@for_1_promena
@for_1_exit:
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET