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
	char* contents;
	size_t size = load_file(argv[1], &contents);
	printf("%lu: number of bytes from the load file.\n",size);
	
	sort(&contents, size);

	/*	
	for (size_t i = 0; i<size; ++i){

		printf("%c", contents[i]);
	}
	*/
	
	size = save_file(argv[2], contents, size );
	printf("%lu: number of bytes from the save file.\n",size);

	return 0;	

}

// You can see if your file worked correctly by using the
// command:
//
// diff ORIGINAL_FILE NEW_FILE
//
// If the command returns ANYTHING the files are different.
