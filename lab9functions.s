// Irvin Samuel
// June 4, 2020
// lab9functions.s
// This is my starter code for Lab8f /Lab9 of COEN 20.

.syntax unified
.cpu cortex-m4
.text

//Q16 Q16Divide(Q16 dividend, Q16 divisor)
  .global Q16Divide
  .thumb_func

Q16Divide:

  EOR  R12,R0,R1//sign bits

  EOR  R2,R0,R0,ASR 31 //flip dividend
  ADD  R0,R2,R0,LSR 31 // add 1 or 0 if negative or positive
  EOR  R2,R1,R1,ASR 31 //flip divisor
  ADD  R1,R2,R1,LSR 31 // add 1 or 0 if negative or positive

  SDIV  R2,R0,R1//quotient

  MLS R3,R1,R2,R0//remainder calculation


  .rept 16

  LSL R2,R2,1 //Left shift quotient
  LSL R3,R3,1 //Left shift remainder
  CMP R3,R1 //check if remainder>=divisor
  ITT  HS
  SUBHS R3,R3,R1
  ADDHS   R2,R2,1 //quotient++

  .endr

  EOR  R2,R2,R12,ASR 31 //flip Quotient
  ADD  R0,R2,R12,LSR 31 // add 1 or 0 if negative or positive

  BX  LR
