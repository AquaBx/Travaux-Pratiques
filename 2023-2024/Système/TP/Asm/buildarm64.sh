file=$1

export BOX64_NOBANNER=1
export BOX64_ROLLING_LOG=0
export BOX64_LOG=0

nasm -felf64 $file.asm && x86_64-linux-gnu-ld $file.o -o $file && box64 ./$file