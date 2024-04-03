#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void chiffrement(char * message, char * key){
    printf("\nChiffrement de %s \n",message);

    int y = 0;

    if ( key[strlen(key)-1] == '\n'){
        key[strlen(key)-1] = '\0';
    }

    char * message2 = malloc(strlen(message)*sizeof(char));

    for (unsigned int i=0;i<strlen(message);i++){
        if( 'A' <= message[i] && message[i] <= 'Z' ){
            y=y%strlen(key);
            message2[i] = ( 26 + key[y] - message[i])%26 + 'A';
            y++;
        }
        else{
            message2[i] = message[i];
        }
    }

    message2[strlen(message)] = '\0';

    printf("Message : %s\n",message2);
}

void dechiffrement(char * message, char * key){

    printf("\nDechiffrement de %s \n",message);

    if ( key[strlen(key)-1] == '\n'){
        key[strlen(key)-1] = '\0';
    }

    int y = 0;

    char * key2 = malloc(strlen(key)*sizeof(char));

    for (unsigned int i=0;i<strlen(key);i++){
        if( 'A' <= message[i] && message[i] <= 'Z' ){
            y=y%strlen(key);
            key2[i] = ( key[y] + message[i] )%26 + 'A';
            y++;
        }
    }

    key2[strlen(key)] = '\0';

    printf("Clef : %s\n",key2);
    chiffrement(message,key2);
}

#define MAX 100*sizeof(char)
int main(){

    // char * msg1 = "HELLO WORLD!";
    // char * key1 = "DIANA";



    char key1[MAX]; 
    char msg1[MAX];  
    

    printf("Key     : ");
    fgets(key1,MAX,stdin);
    printf(key1);
    printf("Message : ");
    fgets(msg1,MAX,stdin);
    printf(msg1);


    dechiffrement(msg1,key1);

    return 0;
}