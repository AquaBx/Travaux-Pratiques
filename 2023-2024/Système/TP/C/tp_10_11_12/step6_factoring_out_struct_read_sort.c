
#include "step6_country_array.h"



void main(){
   FILE *file;
   char line[500];

   int i = -1;

   country_t tableau[215];
   
   if ( !fopen_s( &file, "./owid-co2-data-excerpt.csv", "r" ) ) {
        while (fgets( line, 500, file )){
            i++;
            if (i == 0){continue;}

            analyse_line(tableau, line, i);

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