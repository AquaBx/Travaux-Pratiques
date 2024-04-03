#include <string.h>
#include <stdio.h>
#include <stdlib.h>

void chiffrement(char * message, char * key){
    printf("\nChiffrement de %s \n",message);

    int y = 0;

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

int main(){

    char * msg1 = "HELLO WORLD!";
    char * key1 = "DIANA";

    char * msg2 = "WEPCM HUJCX!";
    char * key2 = "HELLO";

    char * msg3 = "XOXGQ, QUEYBIYKHIYWEV DR QUFPHEYWFC YXKQ GER IZMKCEAGEEL! NUALU PVQ KQ YXO IEMWEA.";
    char * key3 = "HELL";

    chiffrement(msg1,key1);
    dechiffrement(msg2,key2);
    dechiffrement(msg3,key3);

    return 0;
}