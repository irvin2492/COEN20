// Irvin Samuel
// May 14, 2020
// lab6functions.s
// This is my starter code for Lab6c of COEN 20.

.syntax		unified
.cpu		cortex-m4
.text

//void PutNibble(void *nibbles, uint32_t which, uint32_t value);
  .global   PutNibble
  .thumb_func
PutNibble:

  ADD   R0,R0,R1,LSR 1 //byte # is at which/2
  LDRB   R3,[R0] //loading contents of byte containing 'which' nibble
  AND  R1,R1,1  //computing R1 % 2
  CMP   R1,0  //checking if R1%2==0 to determine if its odd/even
  ITE   EQ
  BFIEQ   R3,R2,0,4 //if which is even then modify the first 4 bits
  BFINE   R3,R2,4,4 //if which is odd then modify the second 4 bits
  STRB    R3,[R0]//returning modified byte to nibbles array
  BX    LR


//uint32_t GetNibble(void *nibbles, uint32_t which);
  .global   GetNibble
  .thumb_func
GetNibble:
  ADD    R0,R0,R1,LSR 1//byte # is at which/2
  LDR    R0,[R0]//loading contents of byte containing 'which' nibble
  AND  R1,R1,1 //computing R1 % 2
  CMP   R1,0//checking if R1%2==0 to determine if its odd/even
  ITE   EQ
  UBFXEQ   R0,R0,0,4 //if which is even then extract the first 4 bits
  UBFXNE   R0,R0,4,4 //if which is odd then extract the second 4 bits
  BX    LR
