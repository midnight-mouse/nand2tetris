@256
D=A
@SP
M=D
@FibonacciElement$$ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@5
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(FibonacciElement$$ret.1)
(Main.fibonacci)
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
@SP
AM=M-1
D=M-D
@Main.fibonacci$TRUE.2
D;JLT
@SP
A=M
M=0
@Main.fibonacci$CONT.2
0;JMP
(Main.fibonacci$TRUE.2)
@SP
A=M
M=-1
(Main.fibonacci$CONT.2)
@SP
M=M+1
@SP
AM=M-1
D=M
@Main.fibonacci$IF_TRUE
D;JNE
@Main.fibonacci$IF_FALSE
0;JMP
(Main.fibonacci$IF_TRUE)
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@R14
M=D
@5
D=A
@R14
A=M-D
D=M
@R15
M=D
@SP
AM=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R14
A=M-1
D=M
@THAT
M=D
@2
D=A
@R14
A=M-D
D=M
@THIS
M=D
@3
D=A
@R14
A=M-D
D=M
@ARG
M=D
@4
D=A
@R14
A=M-D
D=M
@LCL
M=D
@R15
A=M
0;JMP
(Main.fibonacci$IF_FALSE)
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
@2
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
@SP
AM=M-1
M=M-D
@SP
M=M+1
@Main.fibonacci$ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@6
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Main.fibonacci$ret.3)
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
@SP
AM=M-1
D=M
@SP
AM=M-1
M=M-D
@SP
M=M+1
@Main.fibonacci$ret.4
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@6
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Main.fibonacci$ret.4)
@SP
AM=M-1
D=M
@SP
AM=M-1
M=M+D
@SP
M=M+1
@LCL
D=M
@R14
M=D
@5
D=A
@R14
A=M-D
D=M
@R15
M=D
@SP
AM=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R14
A=M-1
D=M
@THAT
M=D
@2
D=A
@R14
A=M-D
D=M
@THIS
M=D
@3
D=A
@R14
A=M-D
D=M
@ARG
M=D
@4
D=A
@R14
A=M-D
D=M
@LCL
M=D
@R15
A=M
0;JMP
(Sys.init)
@4
D=A
@SP
A=M
M=D
@SP
M=M+1
@Sys.init$ret.5
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@6
D=A
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Sys.init$ret.5)
(Sys.init$WHILE)
@Sys.init$WHILE
0;JMP
@_6
(_6)
0;JMP