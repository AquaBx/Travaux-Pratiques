# root of Google Test
# remplacer par le chemin vers le répertoire où est isntallé google_test
GTEST_DIR = ../google_test

# Flags passed to the preprocessor.
CPPFLAGS += -I$(GTEST_DIR)/include

# Flags passed to the C++ compiler.
CXXFLAGS += -ggdb -Wall -Wextra -fno-elide-constructors

# libs to link statically
LIBS  =  $(GTEST_DIR)/lib/libgtest.a

%.o : %.cc %.hh
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $*.o

%.o : %.cpp %.hpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $*.o

all : test1 test2

# test de la partie 1
test1 : test_main.o test_common.o test_vecteur_p1.o vecteur.o 
	$(CXX) $(LDFLAGS) $^ $(LIBS) -lpthread -o $@
	./test1

# test de la partie 2
test2 : test_main.o test_common.o test_vecteur_p2.o vecteur.o 
	$(CXX) $(LDFLAGS) $^ $(LIBS) -lpthread -o $@
	./test2

raz clean :
	-rm *.o *~ test1 test2
