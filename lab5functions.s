// Irvin Samuel
// May 6, 2020
// functions.s
// This is my starter code for Lab5a of COEN 20.


.syntax		unified
.cpu		cortex-m4
.text
// void MatrixMultiply(int32_t A[3][3], int32_t B[3][3], int32_t C[3][3])  ;
  .global		MatrixMultiply ;
  .thumb_func
MatrixMultiply:
    PUSH    {R4-R11,LR}
    LDR   R4,=0 //Row #

    MOV   R9,R0  //copy of A pointer
    MOV   R10,R1 //copy of B pointer
    MOV   R11,R2  //copy of C pointer



RowLoop:CMP   R4,3  //check if row # exceeds 2
        BGE   EndIf
        LDR   R5,=0 //Col #

ColLoop:CMP   R5,3 //check if looping is possible
        BGE   ColLoopDone //exit loop
        LDR   R6,=0;//k iterator
        LDR   R0,=3 //constant placeholder for arithmetic

        //Address of A[row][col] = (Starting address of A) + 4 * (3*row + col)
        MUL   R7,R4,R0
        ADD   R7,R7,R5 //adding row+col
        LDR   R0,=4
        MLA   R7,R7,R0,R9 // holds the address for A[r][c]
        LDR   R0,=0
        STR   R0,[R7] //A[r][c]<-0

KLoop:  CMP   R6,3
        BGE   KLoopDone

        //B(row,k)address
        LDR   R0,=3
        MUL   R0,R4,R0 //3*row
        ADD   R0,R0,R6 //R0+k
        LDR   R8,=4  //constant placeholder
        MLA   R1,R8,R0,R10  //ptrB+4*()
        LDR   R1,[R1]


        //C(k,col)address
        LDR   R0,=3
        MUL   R0,R0,R6//k*3
        ADD   R0,R0,R5//R0+col
        MLA   R2,R8,R0,R11//ptrC+4*()
        LDR   R2,[R2]

        MOV   R0,R7   //places A[r][c] as parameter
        LDR   R0,[R0]

        BL    MultAndAdd
        STR   R0,[R7]   //stores contents of MultAndAdd into A[r][c]

        ADD   R6,R6,1 //increments k number
        B    KLoop

KLoopDone:ADD   R5,R5,1 //increments column number
          B     ColLoop


ColLoopDone:ADD R4,R4,1 //increments row number
            B  RowLoop

EndIf:POP   {R4-R11,PC}

.end
