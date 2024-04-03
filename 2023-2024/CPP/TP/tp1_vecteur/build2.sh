clear
echo building
cd vecteur_generique
g++ ./memory.cxx ./main.cpp -o ./out -fno-elide-constructors
echo launching
./out