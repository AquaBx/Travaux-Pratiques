#include <string>
#include <iostream>
#include <cassert>

class Pile {

    static constexpr int size = 10;

    std::string elements[size];
    std::string * index;

    public :
        Pile();
        void push(std::string valeur);
        void pop();
        std::string top() const ;
        bool empty() const;
        bool full() const;
        ~Pile();
};

void test(std::string ch1, std::string ch2){

    Pile pile;

    pile.push(ch1);
    pile.push(ch2);

    if(pile.top() == "" ) { 
        return ;
    }

    std::cout << pile.top() << std::endl;
    pile.pop();
    std::cout << pile.top() << std::endl;
}

// Question 3

Pile::Pile() : elements(),index(elements) {}

void Pile::push(std::string valeur){

    assert(!full());

    *(index) = valeur;
    index++;
    
}

void Pile::pop(){

    assert(!empty());

    index--;
}

std::string Pile::top() const {
    assert(!empty());

    return *(index-1);
}

bool Pile::empty() const {
    return index-elements == 0;
}

bool Pile::full() const {
    return index-elements == size;
}

Pile::~Pile(){}


int main(){
    test("Hello","World");
    return 0;
}