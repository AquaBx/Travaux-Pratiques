clear
echo building
g++ ./vecteur/vecteur.cpp ./vecteur/memory.cxx ./vecteur/main.cpp -o ./vecteur/out -fno-elide-constructors
echo launching
./vecteur/out