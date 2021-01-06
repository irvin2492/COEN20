// Irvin Samuel
// May 21, 2020
// lab7functions.s
// This is my starter code for Lab7a of COEN 20.

.syntax		unified
.cpu		cortex-m4
.text

//uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
  .global   Zeller1
  .thumb_func
Zeller1:
  PUSH  {R4,R5} //temp
  LDR   R4,=4
  UDIV   R4,R2,R4 //(D/4)
  ADD    R2,R2,R4 //R2<-(D+(D/4))
  LDR    R5,=4
  UDIV   R5,R3,R5 //(C/4)
  LDR    R4,=2
  MLS    R3,R4,R3,R5  //R3<-(C/4)-2C
  LDR    R4,=13
  MUL    R1,R4,R1 //13m
  SUB    R1,R1,1  //13m-1
  LDR    R4,=5
  UDIV   R1,R1,R4 //(13m-1)/5
  ADD    R0,R0,R1 //k+(13m-1)/5
  ADD    R0,R0,R2 //R0+(D+(D/4))
  ADD    R0,R0,R3 //R0+((C/4)-2C)

  LDR    R1,=7
  SDIV   R3,R0,R1  //(f/7) quotient
  MLS    R2,R3,R1,R0  //remainder=dividend-(quotient*divisor)
  AND    R3,R1,R2,ASR 31
  ADDS.N  R0,R2,R3  //adds divisor if remainder is negative

  POP    {R4,R5}
  BX    LR

//uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
//function with no divide instruction

.global   Zeller2
.thumb_func
Zeller2:
  PUSH  {R4,R5}   //temp
  LSR   R4,R2,2   //D/4
  ADD   R2,R2,R4  //D+(D/4)

  LSR   R4,R3,2//(c/4)
  LDR   R5,=2
  MLS   R3,R3,R5,R4 //2C-(C/4)

  LDR   R4,=13
  MUL   R1,R1,R4  //13m
  SUB   R1,R1,1 //13m-1
  LDR   R4,=3435973837  //(2^32)/5
  UMULL  R5,R4,R4,R1    //(A*(2^n/5))
  LSR    R1,R4,2

  ADD    R0,R0,R1 //k+(13m-1)/5
  ADD    R0,R0,R2 //R0+(D+(D/4))
  ADD    R0,R0,R3 //R0+((C/4)-2C)

  LDR    R1,=613566757  //(A*(2^n/7))
  UMULL  R2,R1,R1,R0
  ADDS   R1,R1,R0
  RRX    R1,R1
  LSR    R3,R1,2//quotient

  LDR    R1,=7
  MLS    R2,R3,R1,R0  //remainder=dividend-(quotient*divisor)
  AND    R3,R1,R2,ASR 31  R3= (remainder<0)? 7:0
  ADDS.N  R0,R2,R3  //adds divisor if remainder is negative

  POP    {R4,R5}
  BX    LR

//uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
//function with no multiply instruction

.global   Zeller3
.thumb_func

Zeller3:
  PUSH    {R4}  //temp
  LDR   R4,=4
  UDIV   R4,R2,R4 //(D/4)
  ADD    R2,R4,R2 //R2<-(D+(D/4))
  LDR   R4,=4

  UDIV   R4,R3,R4 //(C/4)
  LSL    R3,R3,1  //2C
  RSB    R3,R3,R4 //(C/4)-2C

  ADD   R4,R1,R1,LSL 4  //17xR1
  SUB   R1,R4,R1,LSL 2  //17xR1-4xR1=13R1=13m
  SUB   R1,R1,1 //13m-1
  LDR   R4,=5
  UDIV  R1,R1,R4  //(13m-1)/5

  ADD    R0,R0,R1 //k+(13m-1)/5
  ADD    R0,R0,R2 //R0+(D+(D/4))
  ADD    R0,R0,R3 //R0+((C/4)-2C)

  LDR    R1,=7
  SDIV   R3,R0,R1  //(f/7) quotient
  ADD    R2,R3,R3,LSL 2 //R3+4xR3=5R3
  ADD    R2,R2,R3,LSL 1//5R3+2R3=7R3
  SUB    R2,R0,R2  //R2<-dividend-(7R3)

  AND    R3,R1,R2,ASR 31
  ADDS.N  R0,R2,R3  //adds divisor if remainder is negative

  POP    {R4}
  BX    LR
