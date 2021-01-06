

// Irvin Samuel
// April 16, 2020
// functions.s
// This is my starter code for Lab2a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text

	// int32_t Add(int32_t a, int32_t b);
		.global		Add
		.thumb_func
	Add:
		ADD			R0,R0,R1		// R0 = a + b
		BX			LR

	// int32_t Less1(int32_t a);
		.global		Less1
		.thumb_func
	Less1:
		SUB     R0,R0,1     //R0 = a-1
		BX      LR

	// int32_t Square2x(int32_t x);
		.global		Square2x
		.thumb_func
	Square2x:
		ADD 	R0,R0,R0
		B			Square	//since the last instruction is to run Square, there is no need to Branch back to Square2x when square is done running


	// int32_t Last(int32_t x);
		.global		Last
		.thumb_func
	Last:
		PUSH 	{R4,LR} //stores the old value of R4 in stack memory
		MOV		R4,R0		//stores x in R0 so it can be reused since the next instruction overwrites R0
		BL 		SquareRoot
		ADD 	R0,R4,R0
		POP 	{R4,PC}
		BX		LR


		.end
