
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$56,%15
@main_body:
		SUBS	%14, $8, %0
		MOV 	$1,(%0)
		SUBS	%14, $12, %0
		MOV 	$4,(%0)
		SUBS	%14, $8, %0
		SUBS	%14, $12, %1
		ADDS	(%0),(%1),%0
		MOV 	%0,-4(%14)
		SUBS	%14, $16, %0
		MOV 	$5,(%0)
		SUBS	%14, $8, %0
		MOV 	$2,(%0)
		SUBS	%14, $8, %0
		ADDS	-4(%14),(%0),%0
		SUBS	%14, $16, %1
		ADDS	%0,(%1),%0
		MOV 	%0,-4(%14)
		SUBS	%14, $36, %0
		MOV 	$10,(%0)
		SUBS	%14, $36, %0
		ADDS	-4(%14),(%0),%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET