// Program: hilow.asm
// Implements HI-LOW "guess the number" game in assembly. 
// User guesses on a number between 0-10 and programs gives guidance: either HIGHER, LOWER, or CORRECT.
// Usage: Press a NUMBER KEY then ENTER to guess.

    @SCREEN
    D=A
    @addr
    M=D     // addr = SCREEN

    @80
    D=A
    @h
    M=D     // h = 80

    @i
    M=0     // i = 0

(LOOP_SEG1)
    @i
    D=M
    @h
    D=D-M
    @SETUP_SEG2
    D;JGT          // if i>h goto SETUP_SEG2

    @addr
    A=M
    M=-1           // RAM[addr] = -1

    @32
    D=A
    @addr
    M=M+D          // addr = addr + 32

    @i
    M=M+1           // i = i + 1

    @LOOP_SEG1
    0;JMP

(SETUP_SEG2)
    @addr
    M=M+1
    @640
    D=A
    @addr
    M=M-D   // Move one column right, 20 rows up

    @10
    D=A
    @h
    M=D     // h = 10

    @i
    M=0     // i = 0

(LOOP_SEG2) 
    @i
    D=M
    @h
    D=D-M
    @SETUP_SEG3
    D;JGT          // if i>h goto SETUP_SEG3

    @addr
    A=M
    M=-1           // RAM[addr] = -1

    @32
    D=A
    @addr
    M=M-D          // addr = addr - 32

    @i
    M=M+1           // i = i + 1

    @LOOP_SEG2
    0;JMP

(SETUP_SEG3)
    @addr
    M=M+1
    @1600
    D=A
    @addr
    M=M-D   // Move one column right, 50 rows up 32*50=1600 (to top)

    @80
    D=A
    @h
    M=D     // h = 80

    @i
    M=0     // i = 0

(LOOP_SEG3)
    @i
    D=M
    @h
    D=D-M
    @END
    D;JGT          // if i>h goto END

    @addr
    A=M
    M=-1           // RAM[addr] = -1

    @32
    D=A
    @addr
    M=M+D          // addr = addr + 32

    @i
    M=M+1           // i = i + 1

    @LOOP_SEG3
    0;JMP

(END)
    @END
    0;JMP

