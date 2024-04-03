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

int main(){
    return 0;
}