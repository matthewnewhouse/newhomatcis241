#include "file_lib.h"
#include "sorter.h"
#include <stdio.h>
	
/*
 * Read the file from the command-line.
 * Usage:
 * ./a.out FILE_TO_READ FILE_TO_WRITE
 *size_t load_file(char* path, char** contents);
 *size_t save_file(char* path, char* contents, size_t size);
 */

int main(int argc, char** argv){
	char* FILE_TO_READ = argv[1];
	char* FILE_TO_WRITE = argv[2];
	char* contents = malloc(sizeof(char) );
	size_t size = load_file(FILE_TO_READ, &contents);

	size = save_file(FILE_TO_WRITE, contents, size );
	

	// Sort the file with the function you wrote.
	

	// Write out the new file.
	

}

// You can see if your file worked correctly by using the
// command:
//
// diff ORIGINAL_FILE NEW_FILE
//
// If the command returns ANYTHING the files are different.
