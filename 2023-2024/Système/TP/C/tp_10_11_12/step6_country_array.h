#include <string.h>
#include <stdio.h>
#include <stdbool.h>

typedef struct {
    char iso_code[10];
    char country[50];
    int year;
    float co2;
    float consumption_co2;
    float cumulative_co2;
    int population;
    float co2perhbts;
} country_t ;

void sort(country_t * tab,int len );
void analyse_line(country_t * tableau, char * line, int i);