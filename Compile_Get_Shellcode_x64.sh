#!/bin/bash

#Script Assemblage / Linkagage / GetShellCode for Asm programm

#Get Programme Name
PROG_NAME=$1

#Significative Name
echo "##############################"
echo "# Comp + Link + GetShellCode #"
echo "# Arg1 : Prog Name           #"
echo "##############################"

echo "INFO - Programme to work : $1"

#Assemble
$(nasm -f elf64 $PROG_NAME.asm)

#Link
$(ld $PROG_NAME.o -o $PROG_NAME -m elf_x86_64)

#GetPayload ShellCode
BULL_SHIT=$(for i in $(objdump -d $PROG_NAME | grep "^ " | cut -f2); do echo -n '\x'$i;done;echo)

#Prepare commande for test
echo "INFO - Payload ShellCode : $BULL_SHIT"
	
