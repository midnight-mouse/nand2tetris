// Program: rectangle.asm
// Draws a rectangle of width 16 and custom height to the screen.
// Usage: set R0 to rectangle height.

    @SCREEN
    D=A
    @addr
    M=D     // addr = SCREEN
    
    @R0
    D=M
    @n
    M=D     // n = RAM[0]

    @i
    M=0     // i = 0

(LOOP)
    @i
    D=M
    @n
    D=D-M
    @END
    D;JGT   // if i > n goto END

    @addr
    A=M
    M=-1    // RAM[addr] = -1

    @32
    D=A
    @addr
    M=D+M   // addr = addr + 32

    @i
    M=M+1   // i = i + 1

    @LOOP
    0;JMP   // goto LOOP

(END)
    @END    // Program's end
    0;JMP   // infinite loop
    