"""
hvmCodeWriter.py -- Code Writer class for Hack VM translator
"""

import os
from hvmCommands import *

debug = False

class CodeWriter(object):
    
    def __init__(self, outputName):
        """
        Open 'outputName' and gets ready to write it.
        """
        self.file = open(outputName, 'w')
        self.SetFileName(outputName)

        self.labelNumber = 0
        self.returnLabel = None
        self.callLabel = None
        self.cmpLabels = {}
        self.needHalt = True


    def Debug(self, value):
        """
        Set debug mode.
        Debug mode writes useful comments in the output stream.
        """
        global debug
        debug = value


    def Close(self):
        """
        Write a jmp $ and close the output file.
        """
        if self.needHalt:
            if debug:
                self.file.write('    // <halt>\n')
            label = self._UniqueLabel()
            self._WriteCode('@%s, (%s), 0;JMP' % (label, label))
        self.file.close()


    def SetFileName(self, fileName):
        """
        Sets the current file name to 'fileName'.
        Restarts the local label counter.

        Strips the path and extension.  The resulting name must be a
        legal Hack Assembler identifier.
        """
        if (debug):
            self.file.write('    // File: %s\n' % (fileName))
        self.fileName = os.path.basename(fileName)
        self.fileName = os.path.splitext(self.fileName)[0]
        self.functionName = None


    def Write(self, line):
        """
        Raw write for debug comments.
        """
        self.file.write(line + '\n')

    def _UniqueLabel(self):
        """
        Make a globally unique label.
        The label will be _sn where sn is an incrementing number.
        """
        self.labelNumber += 1
        return '_' + str(self.labelNumber)


    def _LocalLabel(self, name):
        """
        Make a function/module unique name for the label.
        If no function has been entered, the name will be
        FileName$$name. Otherwise it will be FunctionName$name.
        """
        if self.functionName != None:
            return self.functionName + '$' + name
        else:
            return self.fileName + '$$' + name


    def _StaticLabel(self, index):
        """
        Make a name for static variable 'index'.
        The name will be FileName.index
        """
        return self.fileName + '.' + str(index)    


    def _WriteCode(self, code):
        """
        Write the comma separated commands in 'code'.
        """
        code = code.replace(',', '\n').replace(' ', '')
        self.file.write(code + '\n')
        

 
        

    """"
    The functions to be implemented are found beyond this point 
    """
	
    """
    Parameters: 

    Result: 
    For push: Pushes the content of segment[index] onto the stack. It is a good idea to move the value to be pushed into a register first, then push the content of the register to the stack.
    For pop: Pops the top of the stack into segment[index]. You may need to use a general purpose register (R13-R15) to store some temporary results.
    Returns: 
    Nothing.
    Hint: Recall that there are 8 memory segments in the VM model, but only 5 of these exist in the assembly definition. Also, not all 8 VM segments allow to perform both pop and push on them. Chapter 7.3 of the book explains memory segment mapping.
    Hint: Use pen and paper first. Figure out how to compute the address of segment[index] (except for constant). Then figure out how you move the value of segment[index] into a register (by preference D). Then figure out how to push a value from a register onto the stack. 
    Hint: For pop, you already know how to compute the address of segment[index]. Store it in a temporary register (you can use R13 to R15 freely). Then read the value from the top of the stack, adjust the top of the stack, and then store the value at the location stored in the temporary register.
    """


    def WritePushPop(self, commandType, segment, index):
        """
        Write Hack code for 'commandType' (C_PUSH or C_POP).
        'segment' (string) is the segment name.
        'index' (int) is the offset in the segment.
	To be implemented as part of Project 6
	
	    For push: Pushes the content of segment[index] onto the stack. It is a good idea to move the value to be pushed into a register first, then push the content of the register to the stack.
        For pop: Pops the top of the stack into segment[index]. You may need to use a general purpose register (R13-R15) to store some temporary results.
        Hint: Recall that there are 8 memory segments in the VM model, but only 5 of these exist in the assembly definition. Also, not all 8 VM segments allow to perform both pop and push on them. Chapter 7.3 of the book explains memory segment mapping.
        Hint: Use pen and paper first. Figure out how to compute the address of segment[index] (except for constant). Then figure out how you move the value of segment[index] into a register (by preference D). Then figure out how to push a value from a register onto the stack. 
        Hint: For pop, you already know how to compute the address of segment[index]. Store it in a temporary register (you can use R13 to R15 freely). Then read the value from the top of the stack, adjust the top of the stack, and then store the value at the location stored in the temporary register.

        """

        # Assembler-specific Segment Symbols
        if segment == T_LOCAL:      seg = 'LCL'
        if segment == T_ARGUMENT:   seg = 'ARG'
        if segment == T_THIS:       seg = 'THIS'
        if segment == T_THAT:       seg = 'THAT'

        # Initialize code
        code = None

        # Push value from various segments to stack
        if commandType == C_PUSH:
            self.Write(f'// push {segment} {index}')

            if segment in [T_LOCAL, T_ARGUMENT, T_THIS, T_THAT]:
                code = f'@{index}, D=A, @{seg}, A=D+M, D=M, @SP, A=M, M=D, @SP, M=M+1'
            
            if segment == T_CONSTANT:
                code = f'@{index}, D=A, @SP, A=M, M=D, @SP, M=M+1'

            if segment == T_STATIC:
                code = f'@{self.fileName}.{index}, D=M, @SP, A=M, M=D, @SP, M=M+1'
            
            if segment == T_TEMP:
                code = f'@R{index + 5}, D=M, @SP, A=M, M=D, @SP, M=M+1'

            if segment == T_POINTER:
                addr = 'THIS' if index == 0 else 'THAT'     # choose between this and that
                code = f'@{addr}, D=M, @SP, A=M, M=D, @SP, M=M+1'

        # Pop from stack to various segments
        if commandType == C_POP:
            self.Write(f'// pop {segment} {index}')

            if segment in [T_LOCAL, T_ARGUMENT, T_THIS, T_THAT]:
                code = f'@{index}, D=A, @{seg}, D=D+M, @R13, M=D, @SP, AM=M-1, D=M, @R13, A=M, M=D'

            if segment == T_STATIC:
                code = f'@SP, AM=M-1, D=M, @{self.fileName}.{index}, M=D'

            if segment == T_TEMP:
                code = f'@SP, AM=M-1, D=M, @R{index + 5}, M=D'

            if segment == T_POINTER:
                addr = 'THIS' if index == 0 else 'THAT'     # choose between this and that
                code = f'@SP, AM=M-1, D=M, @{addr}, M=D'

        # Write code to file
        if code: self._WriteCode(code)
        
    def WriteArithmetic(self, command):
        """
        Write Hack code for stack arithmetic 'command' (str).
	To be implemented as part of Project 6
	    
		Compiles the arithmetic VM command into the corresponding ASM code. Recall that the operands (one or two, depending on the command) are on the stack and the result of the operation should be placed on the stack.
        The unary and the logical and arithmetic binary operators are simple to compile. 
         The three comparison operators (EQ, LT and GT) do not exist in the assembly language. The corresponding assembly commands are the conditional jumps JEQ, JLT and JGT. You need to implement the VM operations using these conditional jumps. You need two labels, one for the true condition and one for the false condition and you have to put the correct result on the stack.
        """

        code = None

        if command == T_ADD:
            self.Write(f'// add')
            code = '@SP, AM=M-1, D=M, @SP, AM=M-1, M=M+D, @SP, M=M+1'

        if command == T_SUB:
            self.Write(f'// sub')
            code = '@SP, AM=M-1, D=M, @SP, AM=M-1, M=M-D, @SP, M=M+1'

        if command == T_NEG:
            self.Write(f'// neg')
            code = '@SP, AM=M-1, M=-M, @SP, M=M+1'

        if command == T_AND:
            self.Write(f'// and')
            code = '@SP, AM=M-1, D=M, @SP, AM=M-1, M=M&D, @SP, M=M+1'

        if command == T_OR:
            self.Write(f'// or')
            code = '@SP, AM=M-1, D=M, @SP, AM=M-1, M=M|D, @SP, M=M+1'

        if command == T_NOT:
            self.Write(f'// not')
            code = '@SP, AM=M-1, M=!M, @SP, M=M+1'

        if command in (T_EQ, T_LT, T_GT):
            self.Write(f'// {command}')

            # get jmp condition
            conditions = {T_EQ: 'JEQ', T_LT: 'JLT', T_GT: 'JGT'}
            jmp = conditions[command]

            # generate TRUE and CONTINUE label
            label = self._UniqueLabel()[1:]
            true_label = self._LocalLabel('TRUE.' + label)
            cont_label = self._LocalLabel('CONT.' + label)

            # check jmp condition
            code = f'@SP, AM=M-1, D=M, @SP, AM=M-1, D=M-D, @{true_label}, D;{jmp}, '

            # false block
            code += f'@SP, A=M, M=0, @{cont_label}, 0;JMP, '

            # true and continue blocks
            code += f'({true_label}), @SP, A=M, M=-1, ({cont_label}), @SP, M=M+1'
            
        if code: self._WriteCode(code)


    def WriteInit(self, sysinit = True):
        """
        Initializes stack pointer (SP) to 256 and calls Sys.init.
        """
        if (debug):
            self.file.write('    // Initialization code\n')
        
        if sysinit == True:
            self._WriteCode('@256, D=A, @SP, M=D')
            self.WriteCall('Sys.init', 0)


    def WriteLabel(self, label):
        """
        Creates and inserts a local label of the form "functionName$label"
        """
        self.Write('// label')
        self._WriteCode(f'({self._LocalLabel(label)})')

    def WriteGoto(self, label):
        """
        Creates and inserts the code for an uncodintional jump to "functionName$label"
        """
        self.Write('// goto')
        self._WriteCode(f'@{self._LocalLabel(label)}, 0;JMP')

    def WriteIf(self, label):
        """
        Write Hack code for 'if-goto' VM command.
	To be implemented as part of Project 7
        """
        self.Write('// if-goto')
        self._WriteCode(f'@SP, AM=M-1, D=M, @{self._LocalLabel(label)}, D;JNE')
        

    def WriteFunction(self, functionName, numLocals):
        """
        Write Hack code for 'function' VM command.
	To be implemented as part of Project
        """

        self.functionName = functionName
        self.Write(f'// function {functionName} {numLocals}')

        # declare label for function entry
        self.Write(f'({functionName})')

        # push 0 numLocals times
        for i in range(numLocals):
            self.WritePushPop(C_PUSH, T_CONSTANT, 0)

    def WriteReturn(self):
        """
        Write Hack code for 'return' VM command.
	To be implemented as part of Project 7
        """
        
        # R14 = endFrame
        # R15 = retAddr

        # segment = *(endFrame - n)
        def ResetSegment(segment, n):
            return f'@{n}, D=A, @R14, A=M-D, D=M, @{segment}, M=D, '

        self.Write('// return')
        code = ''

        # endFrame = LCL
        code += '@LCL, D=M, @R14, M=D, '

        # retAddr = *(endFrame - 5)
        code += '@5, D=A, @R14, A=M-D, D=M, @R15, M=D, '

        # *ARG = pop()
        code += '@SP, AM=M-1, D=M, @ARG, A=M, M=D, '

        # SP = ARG + 1
        code += '@ARG, D=M+1, @SP, M=D, '

        # THAT = *(endFrame - 1)
        code += '@R14, A=M-1, D=M, @THAT, M=D, '

        # THIS = *(endFrame - 2)
        code += ResetSegment('THIS', 2)

        # ARG = *(endFrame - 3)
        code += ResetSegment('ARG', 3)

        # LCL = *(endFrame - 4)
        code += ResetSegment('LCL', 4)

        # goto retAddr
        code += f'@R15, A=M, 0;JMP'

        self._WriteCode(code)

    def WriteCall(self, functionName, numArgs):
        """
        Write Hack code for 'call' VM command.
	To be implemented as part of Project 7
        """

        # helper function for push commands
        def Push(segment):
            return f'@{segment}, D=M, @SP, A=M, M=D, @SP, M=M+1, '

        self.Write(f'// call {functionName} {numArgs}')
        code = ''

        # create returnAddr label
        returnAddress = self._LocalLabel('ret.' + self._UniqueLabel()[1:])

        # push returnAddr, LCL, ARG, THIS, THAT
        code += f'@{returnAddress}, D=A, @SP, A=M, M=D, @SP, M=M+1, '
        code += Push('LCL')
        code += Push('ARG')
        code += Push('THIS')
        code += Push('THAT')

        # ARG = SP-5-numArgs
        code += f'@{5 + numArgs}, D=A, @SP, D=M-D, @ARG, M=D, '

        # LCL = SP
        code += '@SP, D=M, @LCL, M=D, '

        # goto functionName
        code += f'@{functionName}, 0;JMP'
        
        # write code
        self._WriteCode(code)

        # declare label
        self.Write(f'({returnAddress})')

       


    
