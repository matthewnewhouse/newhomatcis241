#include "sorter.h"
#include <stdio.h>
#include <string.h>

void sort(char** contents, int size){


	//Make Array Of Strings From Contents	
	char** array= (char**)malloc(sizeof(char*)*size);
	
	int i = 0;
	char* r = strtok(*contents,"\n");

	while(r!=NULL){
		array[i] = (char*)malloc(strlen(r)+2);
		for(int o = 0; o<strlen(r);o++){
			
			array[i][o] = r[o];
		}
	
		i++;	
	         r = strtok(NULL, "\n");
	}

	//Sort Array
	 int m;
	 char* key;
	 int n=0;
	 for(m=1; m < size;m++){

		key=array[m];
		n = m-1;
		while(n>=0 && strcmp(array[n], key)>0){
			array[n+1]= array[n];
		 	n-=1;	
		}
		array[n+1] = key;
	}
		
	
	//Copy Array To Contents
	int z = 0;
	for(int x = 0; x<size; x++){

		for(int y = 0; y<strlen(array[x]) ; y++){
	
			contents[0][z] = array[x][y];
			z++;
		}
		contents[0][z] = '\n';
		z++;
	}

	//Free Memory
	free(array);
}
