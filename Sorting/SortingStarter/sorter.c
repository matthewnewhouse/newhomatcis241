#include "sorter.h"
#include <stdio.h>
#include <string.h>

void sort(char** contents, int size){

	
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

	/*	
	prntf("\nARRAY AFTER LOAD:%s\n","");
	for (int w = 0; w<size; w++){
		for(int u = 0; u<strlen(array[w]); u++){

			printf("%c", (array)[w][u]);
		}
	}
	*/

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

	/*
	printf("\nARRAY AFTER SORT:%s\n","");
	for (int w = 0; w<size; w++){
		for(int u = 0; u<2; u++){

		printf("%c", (array)[w][u]);
	}
	}

	printf("\nCONTENTS BEFORE COPY:%s\n","");
	for (int w = 0; w<1; w++){
		for(int u = 0; u<15; u++){

			printf("%c", (contents)[0][u]);
		}
	}
	*/

	/*
	contents[0][3] = 'g';

	printf("CONTENTS[0]:%s\n",contents[0]);
	printf("CONTENTS[0][0]:%c\n",contents[0][3]);

	*/
		

	 int z = 0;
	for(int x = 0; x<size; x++){

		for(int y = 0; y<strlen(array[x]) ; y++){
		/*
			printf("\nARRAY IN COPY:%s\n","");
			for (int w = 0; w<size; w++){
			for(int u = 0; u<2; u++){


			printf("%c", (array)[w][u]);}}
			printf("%s", "\n");
	

			printf("\nCONTENTS IN COPY:%s\n","");

			for (int w = 0; w<1; w++){
	
				for(int u = 0; u<z; u++){

		printf("%c", (array)[0][u]);}}
			printf("CONTENTS MATRIX BEFORE:%c\n", contents[0][z]);
			printf("CHANGE TO:%c\n", array[x][y]);
			printf("x=%d\n", x);
			printf("y=%d\n", y);
			*/
			contents[0][z] = array[x][y];
			//printf("CONTENTS MATRIX AFTER:%c\n", contents[0][z]);
			z++;
		}
		//printf("CONTENTS MATRIX BEFORE:%c\n", contents[0][z]);
		contents[0][z] = '\n';
		//printf("CONTENTS MATRIX AFTER:%c\n", contents[0][z]);
		z++;
		//printf("\nEND OF LOOP:%d\n", x);
	}

	//printf("BYTES:%d\n", z);

	free(array);
}
