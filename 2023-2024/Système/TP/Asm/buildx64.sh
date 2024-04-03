file=$1

nasm -g -felf64 $file.asm && ld $file.o -o $file && ./$file