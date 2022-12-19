// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

    @R2
    M=0         // product = 0

    @R0
    D=M
    @END
    D;JEQ       // if RAM[R1] == 0; goto END
    @a
    M=D         // a = RAM[R0]

    @R1
    D=M
    @END
    D;JEQ       // if RAM[R2] == 0; goto END 
    @b
    M=D         // b = RAM[R1]

    @i
    M=1         // i = 1

    @a
    D=M
    @b
    D=D-M
    @LOOP
    D;JLT       // if a < b; goto LOOP
                // else; FLIP a and b (always run loop as few times as possible)

(FLIP)
    @a
    D=M
    @temp
    M=D         // temp = a

    @b
    D=M
    @a
    M=D         // a = b

    @temp
    D=M
    @b
    M=D         // b = temp

(LOOP)
    @i
    D=M
    @a
    D=D-M
    @END
    D;JGT       // if i > a; goto STOP

    @b
    D=M
    @R2
    M=M+D       // product = product + b

    @i
    M=M+1       // i = i + 1

    @LOOP
    0;JMP

(END)
    @END
    0;JMP