#include "file_lib.h"
#include "sorter.h"
#include <stdio.h>
	
/*****************************************************************
*Loads a file of strings, sorts the contents, and saves the file.
* 
*Usage: ./a.out FILE_TO_READ FILE_TO_WRITE
*
*@author Matthew Newhouse
*@version April 2021
*************************************************************** */

int main(int argc, char** argv){

	//Holds the contents of the file in an array of characters.
	char* contents;

	//Holds the number of lines in the lines in the file.
	int lines = 0;

	//Holds the number of bytes from the load file.
	size_t bytes = 0;

	//Loads the file into a single string in contents.
	bytes = load_file(argv[1], &contents);
	printf("Loaded %lu bytes from \"%s\".\n", bytes, argv[1]);

	//Finds the number of lines in the loaded file.
	for(int i = 0; contents[i]!=4; i++)
	{
		if(contents[i]==10){
		
			lines++;
		}
	}

	//Sorts the contents from the loaded file.
	sort(&contents, lines);

	//Saves the sorted contents to the given file name.
	save_file(argv[2],contents, bytes);

	//Frees the memory in contents.
	free(contents);

	printf("Finished sorting \"%s\" and saved the contents to \"%s\".\n", argv[1],argv[2]);

	return 0;	
}
