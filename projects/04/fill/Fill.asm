// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

    @SCREEN
    D=A
    @addr
    M=D         // addr = SCREEN

    @i
    M=0         // i = 0

(FILL)
    @KBD
    D=M
    @ERASE
    D;JEQ       // if no key pressed; goto ERASE

    @i
    D=M
    @8192
    D=A-D
    @FILL
    D;JEQ       // if i == 8192 (end of screen 256*32=8192); goto FILL

    @addr
    A=M
    M=-1        // fill RAM[addr] black

    @addr
    M=M+1       // addr = addr + 1

    @i
    M=M+1       // i = i + 1

    @FILL
    0;JMP       // goto FILL

(ERASE)
    @KBD
    D=M
    @FILL
    D;JGT       // if key pressed; goto FILL

    @i
    D=M
    @ERASE
    D;JLT       // if i < 0 (top of screen); goto ERASE

    @addr
    A=M
    M=0        // fill RAM[addr] white

    @addr
    M=M-1       // addr = addr - 1

    @i
    M=M-1       // i = i - 1

    @ERASE
    0;JMP       // goto ERASE

(END)
    @END
    0;JMP