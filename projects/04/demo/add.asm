// add.asm - adds two numbers together
// performs c = a + b, place a in RAM[0], b in RAM[1] and stores result in RAM[2]

@0
D=M

@1
D=D+M

@2
M=D

@6
0;JMP