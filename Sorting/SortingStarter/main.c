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
	size_t bytes = load_file(argv[1], &contents);
	printf("Loaded %lu bytes from \"%s\".\n", bytes, argv[1]);

	//Find Number Of Lines
	int lines = 0;

	for(int i = 0; contents[i]!=4;i++){
		if(contents[i]==10){
			lines++;
		}
	}

	//Sort Contents
	sort(&contents, lines);

	//Save Contents To File
	save_file(argv[2],contents, bytes);

	//Free Contents Memory
	free(contents);

	printf("Finished sorting \"%s\" and saved the contents to \"%s\".\n", argv[1],argv[2]);

	return 0;	

}
