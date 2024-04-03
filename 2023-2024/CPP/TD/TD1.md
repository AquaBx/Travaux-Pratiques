# CPP TD 1

## Question 1

On crée un objet dynamique qui n'est pas supprimé à la fin, ce qui peut entraîner des bugs par la suite.

## Question 2

En ajoutant des deletes
```cpp
void test(std::string ch1, std::string ch2){
    Pile * pile = new Pile;
    pile -> push(ch1);
    pile -> push(ch2);

    if(pile -> top() == "" ) { 
        delete pile;
        return ;
    }

    std::cout << pile -> top() << std::endl;
    (*pile).pop();
    std::cout << pile -> top() << std::endl;

    delete pile;
}
```

En passant par une variable locale
```cpp
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
```


## Question 3

```cpp
#include <string>
#include <iostream>
#include <cassert>
```

### 3.1 : Par valeur

```cpp
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
```

### 3.2 : Par pointeur

```cpp

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
```

## Question 4

![](<null (3).png>)

## Question 5

```cpp
class Pile {

    std::string * elements;
    std::string * index;
    int size; 

    private:
        void copy(const Pile& p_o);

    public :
        Pile(int size=10);
        void push(std::string valeur);
        void pop();
        std::string top() const ;
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

/*

for (std::string * it = other.elements; it != other.index ; ++it){
    *index = *it;
    index++;

    // ou push(*it)
}

*/

Pile &Pile::operator=(const Pile& p_o) {

    if (this == &p_o) { 
        delete[] elements;
        copy(p_o);        
    }

    return *this;
}

```

⚠️ delete[] pour les tableaux

## Question 6

![alt text](<null (4).png>)

## Question 7

```cpp
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

void Pile::push( const std::string &valeur){
    assert(!full());
    *(index) = valeur;
    index++;
}

const std::string& Pile::top() const {
    assert(!empty());

    return *(index-1);
}
```

## Question 8

```cpp
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
```
## Question 9

```cpp
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
```

## Question 10