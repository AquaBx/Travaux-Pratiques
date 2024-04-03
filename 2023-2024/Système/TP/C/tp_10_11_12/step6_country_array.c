#include "step6_country_array.h"


void sort(country_t * tab,int len ){
    bool permut;

    do {
        permut = false;
        for (int i = 1; i < len ; i++){
            if ( tab[i-1].co2perhbts < tab[i].co2perhbts ){
                permut = true;
                country_t temp = tab[i];
                tab[i] = tab[i-1];
                tab[i-1] = temp;
            }
        }

    } while (permut);
}



void analyse_line(country_t * tableau, char * line, int i){
    
            char iso_code[10] = {0};
            char country[50] = {0};
            int year;
            float co2;
            char consumption_co2[20];
            float cumulative_co2;
            int population;

            int err = sscanf(line,"%[^,],%[^,],%d,%f,%[^,],%f,%d",iso_code,country,&year,&co2,&consumption_co2,&cumulative_co2,&population);

            if (err != 7) { printf("error") ; exit(1);}

            float co2perhbts;
            float consumption_co22;
            if ( consumption_co2[0] == '?' ){
                consumption_co22 = -1;
                co2perhbts = -1;
            }
            else {
                int err2 = sscanf(line,"%*[^,],%*[^,],%*d,%*f,%f,%*f,%*d",&consumption_co22);
                co2perhbts = consumption_co22/((float) population) * 1000000;
                if (err2 != 1) { printf("error") ; exit(1);}
            }

            country_t line2 = {
                {0},
                {0},
                year,
                co2,
                consumption_co22,
                cumulative_co2,
                population,
                co2perhbts
            };

            tableau[i] = line2;

            strcpy(tableau[i].iso_code,iso_code);
            strcpy(tableau[i].country,country);
}