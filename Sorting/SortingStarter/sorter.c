#include "sorter.h"

void sort(char* contents, int size){

	int i;
	int key;
	int j;

	for(i=1; i < size;i++){

		key = contents[i];
		j = i-1;

		while(j>=0 && contents[j] > key){

			contents[j+1]= contents[j];
			j-=1
		}
		contents[j+1] = key;
	}
}
