#include "sorter.h"
#include <stdio.h>
#include <string.h>

/*****************************************************************
*Takes an array of a string, turns it into an array with multiple
*strings, sorts the strings in alphabetical order, and copies
*the sorted contents into the original pointer.
*
*@param contents the array of a string with the file contents.
*@param size the number of lines in the file.
*@return none
*
*@author Matthew Newhouse
*@version April 2021
*****************************************************************/
void sort(char** contents, int size){
	
	//Used to track the number of chars in contents.
	int chars = 0;

	//Holds the key for the insertion sort.
	char* key;

	//Used to loop through array in the insertion sort.
	int n = 0;

	//Holds the seperated strings from contents.
	char** array= (char**)malloc(sizeof(char*)*size);
	
	//Used to hold individual strings within contents.
	char* str = strtok(*contents,"\n");
	
	//Makes an array of strings from the file contents.
	for(int i = 0;str!=NULL; i++){

		array[i] = (char*)malloc(strlen(str)+sizeof(char));
		for(int j = 0; j<strlen(str); j++){	

			array[i][j] = str[j];
		}
	        str = strtok(NULL, "\n");
	}

	//Sorts the strings in the array.
	for(int m = 1; m < size; m++){

		key = array[m];
		n = m-1;
		while(n>=0 && strcmp(array[n], key)>0){

			array[n+1]= array[n];
		 	n-=1;	
		}
		array[n+1] = key;
	}
	
	//Copies the strings from the array into a single
	//string in contents.
	for(int i = 0; i < size; i++){

		for(int j = 0; j < strlen(array[i]) ; j++){

			contents[0][chars] = array[i][j];
			chars++;
		}
		contents[0][chars] = '\n';
		chars++;

	}

	//Frees the memory from array.
	for(int i = 0; i < size; i++){

		free(array[i]);
	}
	free(array);
}
