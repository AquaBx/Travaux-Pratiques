file=$1
file2=$2

export BOX64_NOBANNER=1
export BOX64_ROLLING_LOG=0
export BOX64_LOG=0

chaine=""

for a in "$@"; do

nasm -felf64 $a.asm -o $a.o
chaine="$chaine $a.o"

done;

x86_64-linux-gnu-ld $chaine -o $file
box64 ./$file