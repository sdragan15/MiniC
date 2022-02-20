
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@main_body:
		MOV 	$1,-24(%14)
		MOV 	$2,-28(%14)
		MULS	$4, -24(%14), %0
		ADDS	$8, %0, %0
		SUBS	%14, %0, %0
		MOV 	$4,(%0)
		SUBS	%14, $8, %0
		MOV 	$2,(%0)
		MULS	$4, -28(%14), %0
		ADDS	$8, %0, %0
		SUBS	%14, %0, %0
		MOV 	$6,(%0)
		MULS	$4, -24(%14), %0
		ADDS	$8, %0, %0
		SUBS	%14, %0, %0
		SUBS	%14, $8, %1
		ADDS	(%0),(%1),%0
		ADDS	%0,$1,%0
		MULS	$4, -28(%14), %1
		ADDS	$8, %1, %1
		SUBS	%14, %1, %1
		ADDS	%0,(%1),%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET