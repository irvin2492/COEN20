// Irvin Samuel
// April 30, 2020
// functions.s
// This is my starter code for Lab4c of COEN 20.


.syntax		unified
.cpu		cortex-m4
.text
// int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b) ;
  .global		MxPlusB ;
  .thumb_func
MxPlusB:
    PUSH {R4,R5,R6}    //storing the variable registers for use outside the function

    MUL   R1,R0,R1 //multiplying mtop by x

    //following steps are for calculating rounding = (((( (dvnd*dvsr) >> 31) * dvsr) << 1) + dvsr) / 2 ;

    MUL   R5,R1,R2  //R5 <- (dvnd/dvsr)
    ASR   R5,R5,31  //R5 <- R5>> 31
    MUL   R5,R5,R2  //R5 <- R5*dvsr
    LSL   R5,R5,1   //R5 << 1
    ADD   R5,R5,R2  // R5 + dvsr
    LDR   R4,=2
    SDIV  R5,R5,R4  //R5/2

    ADD   R6,R5,R1  //(rounding + dividend) for quotient calculation
    SDIV  R6,R6,R2  //(dvnd+rounding) / dvsr
    ADD   R0,R6,R3  // adding the 'b' constant and placing it in the return value


    POP   {R4,R5,R6}

    BX  LR

.end
