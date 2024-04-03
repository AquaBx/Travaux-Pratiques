#include <string.h>
#include <stdio.h>
#include <stdbool.h>


void main(){
   FILE *file;
   char line[500];

   int i = 0;

   if ( !fopen_s( &file, "./owid-co2-data-excerpt.csv", "r" ) ) {
        while (fgets( line, 500, file )){
            if (i == 0){i++; continue;}

            char iso_code[10];
            char country[50];
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
                printf( "No data available on the consumption CO2 caused by %s in %d.\n", country,year );
            }
            else {
                int err2 = sscanf(line,"%*[^,],%*[^,],%*d,%*f,%f,%*f,%*d",&consumption_co22);
                if (err2 != 1) { printf("error") ; exit(1);}
                printf( "%s caused %f million tons of CO2 in %d.\n", country,consumption_co22,year );
            }

        }
        fclose( file );
   }
}