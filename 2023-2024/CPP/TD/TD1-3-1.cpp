#include <string>
#include <iostream>
#include <cassert>

class Pile {

    static constexpr int size = 10;

    std::string elements[size];
    int index;

    public :
        Pile();
        void push(std::string valeur);
        void pop();
        std::string top() const ;
        bool empty() const;
        bool full() const;
        ~Pile();
};




// Question 1 et 2

// avec des deletes
// void test(std::string ch1, std::string ch2){
//     Pile * pile = new Pile;
//     pile -> push(ch1);
//     pile -> push(ch2);

//     if(pile -> top() == "" ) { 
//         delete pile;
//         return ;
//     }

//     std::cout << pile -> top() << std::endl;
    
//     (*pile).pop();

//     std::cout << pile -> top() << std::endl;

//     delete pile;

// }


// variable locale
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

Pile::Pile() : elements(),index(-1) {}



std::string Pile::top() const {
    assert(!empty());

    return elements[index];
}

bool Pile::empty() const {
    return index == -1;
}

bool Pile::full() const {
    return index == size-1;
}

void Pile::push(std::string valeur){

    assert(!full());

    index++;
    elements[index] = valeur;
}

void Pile::pop(){

    assert(!empty());

    index--;
}

Pile::~Pile(){}


int main(){
    test("Hello","World");
    return 0;
}