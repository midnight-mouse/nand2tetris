// branch.asm - tests branching

    @R0
    D=M     // D = RAM[0]

    @POSITIVE
    D;JGT   // if R0>0 goto 8

    @1
    M=0     // RAM[1] = 0
    @END
    0;JMP   // end of program

(POSITIVE)
    @1
    M=1     // R1 = 1

(END)
    @END
    0;JMP