#include <string>
#include <iostream>
#include <cassert>

class Chainon {

    private:
        std::string data;
        Chainon * pre;

    public :
        const std::string& valeur() const;
        Chainon * precedent() const;
        Chainon(const std::string & data, Chainon * pre = nullptr);

        Chainon(const Chainon &) = delete; 
        Chainon & operator = (const Chainon &) = delete; 

};

Chainon::Chainon(const std::string & data, Chainon * pre) : data(data) , pre(pre) {};

const std::string& Chainon::valeur() const {
    return data;
}

Chainon * Chainon::precedent() const {
    return pre;
}

class Pile {
    
    Chainon * topel; 

    private:
        void copy(const Pile& p_o);

    public :
        Pile();
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

void afficherPile(Pile pile){
    while (!pile.empty()){
        std::cout << pile.top() << std::endl;
        pile.pop();
    }

}

void test2(){
    Pile pile;
    pile.push("bonjour");
    afficherPile(pile);
}

Pile::Pile() : topel(nullptr) {}

void Pile::push( const std::string &valeur){
    assert(!full());
    topel = new Chainon(valeur,topel);
}

void Pile::pop(){
    assert(!empty());

    Chainon * temp = topel;
    topel = temp->precedent();
    delete temp;
}

const std::string& Pile::top() const {
    assert(!empty());

    return topel -> valeur();
}

bool Pile::empty() const {
    return topel == nullptr;
}

bool Pile::full() const {
    return false;
}

Pile::~Pile(){

    while (!empty()){
        pop();
    }

}

Chainon * recurse(const Chainon * el) {
    if ( el == nullptr ) return nullptr;
    else return new Chainon(el->valeur(),recurse(el->precedent()));
}

void Pile::copy(const Pile& p_o){

    this->topel = recurse(p_o.topel);

}

Pile::Pile(const Pile& p_o) {
    copy(p_o);    
}

Pile &Pile::operator=(const Pile& p_o) {

    while (!empty()){
        pop();
    }

    this->topel = recurse(p_o.topel);

    return *this;
}

int main(){
    test("Hello","World");
    test2();
    return 0;
}