// Program: count.asm
// The program will count from i=1..10 and save the counter value to RAM[i]

    @10
    D=A
    @n
    M=D         // n = 10

    @i
    M=1         // i = 1

(LOOP)
    @i
    D=M
    @n
    D=D-M
    @END
    D;JGT       // if i > n goto END

    @i
    AD=M
    M=D         // RAM[i] = i
    
    @i
    M=M+1       // i = i + 1 

    @LOOP
    0;JMP

(END)
    @END
    0;JMP