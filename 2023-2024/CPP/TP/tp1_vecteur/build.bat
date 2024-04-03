cls
echo building
g++ .\vecteur\vecteur.cpp .\vecteur\memory.cxx .\vecteur\main.cpp -o .\vecteur\out.exe -fno-elide-constructors
echo launching
.\vecteur\out.exe < cin.txt
