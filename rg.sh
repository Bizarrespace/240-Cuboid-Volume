#!/bin/bash

# Author information
# Author name: Long Vu
# Author email: Longvu2000@csu.fullerton.edu
# Section number: 5
#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Compiling files..."

nasm -f elf64 -o volume.o volume.asm -g -gdwarf

g++ -g -c -m64 -std=c++17 -fno-pie -no-pie -o cube.o cube.cpp -g

g++ -g -m64 -std=c++17 -fno-pie -no-pie -o application.out volume.o cube.o -g

if test -f "application.out"; then
    echo "Compilation successful. Running program."
gdb    ./application.out
else
    echo "Can't find compiled program. Build failed?"
fi

echo "Script file terminated."