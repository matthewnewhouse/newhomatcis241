#include "sorter.h"
#include <stdio.h>
#include <string.h>

void sort(char** contents, int size){

	/*
	int s = 0;
	char* p = strtok(*contents,"\n");

	 while(p!=NULL){
	   p = strtok(NULL, "\n");
           s++;
	 }

	printf("LINES=%d",s);
	*/
	int s=3;
	char** array= (char**)malloc(sizeof(char*)*s);

	int i = 0;
	char* r = strtok(*contents,"\n");
	while(r!=NULL){
		array[i] = (char*)malloc(strlen(r)+1);
                array[i++]= r;
	         r = strtok(NULL, "\n");
	}

	printf("\n%s\n","INITIAL");
	for (int j = 0; j<s; j++){
		printf("%s\n", array[j]);
	}

	 int m;
	 char* key;
	 int n=0;
	 for(m=1; m < s;m++){

		key=array[m];
		n = m-1;
		while(n>=0 && strcmp(array[n], key)>0){
			array[n+1]= array[n];
		 	n-=1;	
		}
		array[n+1] = key;
	}

	printf("\n%s\n","FINAL");
 	for (int j = 0; j<s; j++){
	       printf("%s\n", array[j]);
	}	 
 
	free(array);	
}
