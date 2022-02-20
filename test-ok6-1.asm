
f:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@f_body:
		MOV 	$-10,-4(%14)
		CMPS	-4(%14), $0
		MOV 	-4(%14),%0
		JGES	@abs_1_end
		MULS	$-1, %0, %0
@abs_1_end:
		MOV 	%0,%13
		JMP 	@f_exit
@f_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$32,%15
@main_body:
		MOV 	$-1,-8(%14)
		CMPS	-8(%14), $0
		MOV 	-8(%14),%0
		JGES	@abs_2_end
		MULS	$-1, %0, %0
@abs_2_end:
		MOV 	%0,-4(%14)
		MOV 	$-2,-32(%14)
		MOV 	$0,-28(%14)
@for_1:
		CMPS 	-28(%14),$4
		JGES	@for_1_exit
		JMP	for_1_continue
@for_1_promena:
		ADDS	$1, -28(%14), %0
		MOV 	%0,-28(%14)
		JMP	@for_1
for_1_continue:
		MULS	$4, -28(%14), %0
		ADDS	$12, %0, %0
		SUBS	%14, %0, %0
		MOV 	-32(%14),(%0)
		ADDS	$1, -32(%14), %0
		MOV 	%0,-32(%14)
		MULS	$4, -28(%14), %0
		ADDS	$12, %0, %0
		SUBS	%14, %0, %0
		CMPS	(%0), $0
		MOV 	(%0),%1
		JGES	@abs_3_end
		MULS	$-1, %1, %1
@abs_3_end:
		ADDS	-4(%14),%1,%0
		MOV 	%0,-4(%14)
		JMP	@for_1_promena
@for_1_exit:
			CALL	f
		MOV 	%13,%0
		ADDS	-4(%14),%0,%0
		MOV 	%0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET