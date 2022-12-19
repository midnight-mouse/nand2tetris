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

    @row
    M=0         // row = 0

    @col
    M=0         // col = 0

(FILL)
    @KBD
    D=M
    @ERASE
    D;JEQ       // if no key pressed; goto ERASE

    @row
    D=M
    @256
    D=A-D
    @FILL
    D;JEQ       // if row == 256 (end of screen); goto FILL

    @FILL_LOOP
    0;JMP       // goto FILL_LOOP

(FILL_RESET)
    @col
    M=0         // col = 0
    @row
    M=M+1       // row = row + 1
    @FILL
    0;JMP       // goto FILL

(FILL_LOOP)
    @32
    D=A
    @col
    D=D-M
    @FILL_RESET
    D;JEQ       // if col == 32; goto FILL_RESET

    @addr
    A=M
    M=-1        // fill RAM[addr] black

    @addr
    M=M+1       // addr = addr + 1

    @col
    M=M+1       // col = col + 1

    @FILL_LOOP
    0;JMP       // goto FILL

(ERASE)
    @KBD
    D=M
    @FILL
    D;JGT       // if key pressed; goto FILL

    @i
    D=M
    @ERASE
    D;JLT       // if i < 0; goto ERASE

    @ERASE_LOOP
    0;JMP       // goto ERASE_LOOP

(ERASE_RESET)
    @col
    M=0         // col = 0
    @row
    M=M-1       // row = row - 1
    @ERASE
    0;JMP       // goto ERASE

(ERASE_LOOP)
    @32
    D=A
    @col
    D=D-M
    @ERASE_RESET
    D;JEQ       // if col == 32; goto FILL_RESET

    @addr
    A=M
    M=0        // fill RAM[addr] white

    @addr
    M=M-1       // addr = addr - 1

    @col
    M=M+1       // col = col + 1

    @ERASE_LOOP
    0;JMP       // goto FILL

(END)
    @END
    0;JMP