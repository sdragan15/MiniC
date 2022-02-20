
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$44,%15
@main_body:
		MOV 	$0,-4(%14)
		MOV 	$0,-40(%14)
@for_1:
		CMPS 	-40(%14),$4
		JGES	@for_1_exit
		JMP	for_1_continue
@for_1_promena:
		ADDS	$1, -40(%14), %0
		MOV 	%0,-40(%14)
		JMP	@for_1
for_1_continue:
		ADDS	-40(%14),$1,%0
		MULS	$4, -40(%14), %1
		ADDS	$8, %1, %1
		SUBS	%14, %1, %1
		MOV 	%0,(%1)
		MULS	$4, -40(%14), %0
		ADDS	$8, %0, %0
		SUBS	%14, %0, %0
		ADDS	-4(%14),(%0),%0
		MOV 	%0,-4(%14)
		JMP	@for_1_promena
@for_1_exit:
		MOV 	$0,-44(%14)
@while_1:
		CMPS 	-44(%14),$4
		JGES	@while_1_exit
@while_1_continue:
		ADDS	-44(%14),$2,%0
		MULS	$4, -44(%14), %1
		ADDS	$24, %1, %1
		SUBS	%14, %1, %1
		MOV 	%0,(%1)
		ADDS	-44(%14),$1,%0
		MOV 	%0,-44(%14)
		JMP	@while_1
@while_1_exit:
		MOV 	$0,-40(%14)
@for_2:
		CMPS 	-40(%14),$4
		JGES	@for_2_exit
		JMP	for_2_continue
@for_2_promena:
		ADDS	$1, -40(%14), %0
		MOV 	%0,-40(%14)
		JMP	@for_2
for_2_continue:
		ADDS	-4(%14),$1,%0
		MULS	$4, -40(%14), %1
		ADDS	$24, %1, %1
		SUBS	%14, %1, %1
		ADDS	%0,(%1),%0
		MOV 	%0,-4(%14)
		JMP	@for_2_promena
@for_2_exit:
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET