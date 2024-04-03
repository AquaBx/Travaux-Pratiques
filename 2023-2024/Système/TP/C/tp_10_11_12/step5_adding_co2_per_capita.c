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

            country_t line = {
                {0},
                {0},
                year,
                co2,
                consumption_co22,
                cumulative_co2,
                population,
                co2perhbts
            };

            tableau[i] = line;

            strcpy(tableau[i].iso_code,iso_code);
            strcpy(tableau[i].country,country);

        }
        fclose( file );


        
        printf("\n==== Tri CO2 consumption ====\n");

        sort(tableau,215);

        for (int c = 0; c < 15; c++){

            country_t line = tableau[c];
            if (line.consumption_co2 == -1){
                printf( "%s pas connu \n", line.country );
            }
            else {
                printf( "%s %f tonnes\n", line.country,line.co2perhbts );
            }
        }


   }
}