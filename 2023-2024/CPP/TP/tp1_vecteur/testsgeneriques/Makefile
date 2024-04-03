# root of Google Test
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

all : test_vecteur test_valgrind

# tests unitaires
test_vecteur : test_vecteur.o test_common.hh
	$(CXX) $(LDFLAGS) $< $(LIBS) -lpthread -o $@
	./test_vecteur | tee test.sor

test : test_vecteur
	./test_vecteur | tee test.sor

# tester le programme *et* vérifier les fuites mémoires
test_valgrind.o : test_vecteur.cc test_common.hh
	$(CXX) $(CPPFLAGS) -DVALGRIND $(CXXFLAGS) -c $< -o $*.o

test_valgrind : test_valgrind.o
	$(CXX) $(LDFLAGS) $^ $(LIBS) -lpthread -o $@
	valgrind ./test_valgrind | tee valgrind.sor

raz clean :
	-rm *.o *~ test_vecteur test_valgrind
