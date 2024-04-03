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
} country_t ;


void main(){
   FILE *file;
   char line[500];

   int i = -1;

   country_t tableau[215];
   
   if ( !fopen_s( &file, "./owid-co2-data-excerpt.csv", "r" ) ) {
        while (fgets( line, 500, file )){
            i++;

            if (i == 0){continue;}

            char iso_code[10] = {0};
            char country[50] = {0};
            int year;
            float co2;
            char consumption_co2[20];
            float cumulative_co2;
            int population;

            int err = sscanf(line,"%[^,],%[^,],%d,%f,%[^,],%f,%d",iso_code,country,&year,&co2,&consumption_co2,&cumulative_co2,&population);

            if (err != 7) { printf("error") ; exit(1);}

            float consumption_co22;
            if ( consumption_co2[0] == '?' ){
                consumption_co22 = -1;
            }
            else {
                int err2 = sscanf(line,"%*[^,],%*[^,],%*d,%*f,%f,%*f,%*d",&consumption_co22);
                if (err2 != 1) { printf("error") ; exit(1);}
            }

            country_t line = {
                {0},
                {0},
                year,
                co2,
                consumption_co22,
                cumulative_co2,
                population
            };

            tableau[i] = line;

            strcpy(tableau[i].iso_code,iso_code);
            strcpy(tableau[i].country,country);

        }
        fclose( file );

        for (int c = 0; c < 215; c++){

            country_t line = tableau[c];
            if (line.consumption_co2 == -1){
                printf( "No data available on the consumption CO2 caused by %s in %d.\n", line.country,line.year );
            }
            else {
                printf( "%s caused %f million tons of CO2 in %d.\n", line.country,line.consumption_co2,line.year );
            }
        }

   }
}