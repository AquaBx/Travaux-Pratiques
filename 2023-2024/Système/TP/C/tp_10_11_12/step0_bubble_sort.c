#include <string.h>
#include <stdio.h>
#include <stdbool.h>

void main(){
    int array_to_be_sorted[] = {9,2,1,15,25,27,20,0,14,9,2,12,21,40,23,5,17,29,22,30};

    bool permut;

    do {
        permut = false;
        for (int i = 1; i < sizeof(array_to_be_sorted)/sizeof(int) ; i++){

            if ( array_to_be_sorted[i-1] > array_to_be_sorted[i] ){
                permut = true;
                int temp = array_to_be_sorted[i];
                array_to_be_sorted[i] = array_to_be_sorted[i-1];
                array_to_be_sorted[i-1] = temp;
            }

        }

    } while (permut);

    for (int i = 0; i < sizeof(array_to_be_sorted)/sizeof(int) ; i++){
        printf("%d, ",array_to_be_sorted[i]);
    } 
}