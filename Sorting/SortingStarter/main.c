#include "file_lib.h"
#include "sorter.h"
#include <stdio.h>
	
/*
 * Read the file from the command-line.
 * Usage:
 * ./a.out FILE_TO_READ FILE_TO_WRITE
 *size_t load_file(char* path, char** contents);
 *size_t save_file(char* path, char* contents, size_t size);
 *void sort(char** contents, int size)
 */

int main(int argc, char** argv){

	//Load File Into Contents
	char* contents;
	size_t size = load_file(argv[1], &contents);
	printf("%lu: number of bytes from the load file.\n",size);

	//Find Number Of Lines
	int s = 0;

	for(int z=0; (contents)[z]!=4;z++){
		if((contents)[z]==10){

			s++;
		}
	}

	//Sort Contents
	sort(&contents, s);

	//Save Contents To File
	save_file(argv[2],contents, size );

	//Free Contents Memory
	free(contents);

	printf("\n%s\n", "FINISHED!");

	return 0;	

}
