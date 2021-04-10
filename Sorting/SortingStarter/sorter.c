#include "sorter.h"
#include <stdio.h>
#include <string.h>

void sort(char** contents, int size){


	//Make Array Of Strings From Contents	
	char** array= (char**)malloc(sizeof(char*)*size);
	
	int i = 0;
	char* str = strtok(*contents,"\n");

	while(str!=NULL){
		array[i] = (char*)malloc(strlen(str)+2);

		for(int j = 0; j<strlen(str); j++){
			
			array[i][j] = str[j];
		}
	
		i++;	
	        str = strtok(NULL, "\n");
	}

	//Sort Array
	char* key;
	int n = 0;
	for(int m=1; m < size; m++){

		key = array[m];
		n = m-1;
		while(n>=0 && strcmp(array[n], key)>0){
			array[n+1]= array[n];
		 	n-=1;	
		}
		array[n+1] = key;
	}
	
	//Copy Array To Contents
	int chars = 0;
	for(int x = 0; x<size; x++){

		for(int y = 0; y<strlen(array[x]) ; y++){
	
			contents[0][chars] = array[x][y];
			chars++;
		}
		contents[0][chars] = '\n';
		chars++;
	}

	//Free Memory
	free(array);
}
