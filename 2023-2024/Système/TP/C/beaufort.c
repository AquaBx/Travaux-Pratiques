#include <string.h>
#include <stdio.h>

char message[] = "HELLO WORLD!";
char key[] = "DIANA" ;

void main(){
    int y = 0;
    for (int i=0;i<strlen(message);i++){
        if( 'A' <= message[i] && message[i] <= 'Z' ){
            y=y%strlen(key);
            message[i] = (26 + key[y] - message[i])%26 + 'A';
            y++;
        }

    }
    printf("%s\n",message);

    // WEPCM HUJCX! 

}