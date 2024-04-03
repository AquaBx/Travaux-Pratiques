#include <string>
#include <iostream>
#include <cassert>

class Pile {

    std::string * elements;
    std::string * index;
    int size; 

    private:
        void copy(const Pile& p_o);

    public :
        Pile(int size=10);
        void push(const std::string &valeur);
        void pop();
        const std::string& top() const ;
        bool empty() const;
        bool full() const;
        ~Pile();
        Pile(const Pile& p_o);
        Pile & operator=(const Pile& p_o);
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

Pile::Pile(int size) : size(size),elements(new std::string[size]),index(elements) {}

void Pile::push( const std::string &valeur){
    assert(!full());
    *(index) = valeur;
    index++;
}

void Pile::pop(){
    assert(!empty());
    index--;
}

const std::string& Pile::top() const {
    assert(!empty());

    return *(index-1);
}

bool Pile::empty() const {
    return index-elements == 0;
}

bool Pile::full() const {
    return index-elements == size;
}

Pile::~Pile(){
    delete[] elements;
}

void Pile::copy(const Pile& p_o){
    elements = new std::string[p_o.size];
    index = elements;

    int s = p_o.index - p_o.elements;

    for ( int i = 0 ; i < s ; i++ ){
        this->elements[i] = p_o.elements[i];
    }

    this->index += s;
}

Pile::Pile(const Pile& p_o) {
    copy(p_o);    
}

Pile &Pile::operator=(const Pile& p_o) {

    if (this == &p_o) { 
        delete[] elements;
        copy(p_o);        
    }

    return *this;
}

int main(){
    test("Hello","World");
    return 0;
}