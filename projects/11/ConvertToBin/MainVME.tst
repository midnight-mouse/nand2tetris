// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/11/Seven/MainVME.tst

load Main.vm,
output-file Main.out,
//compare-to Main.cmp,
output-list RAM[8000]%D1.6.1 RAM[8016]%D1.6.1;

set sp 256,
set local 300,
set argument 400,
set RAM[8000] 171,

repeat 200 {
  vmstep;
}

output;
