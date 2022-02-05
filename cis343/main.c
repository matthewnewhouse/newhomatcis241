#include <stdio.h>
#include "lite_vector.h"

int main(int argc, char** argv){
	lite_vector * lv = lv_new_vec(sizeof(int*));
	printf("Size: %i\n", sizeof(char));
/*	
	int x[1000];
	for(int i=0; i<1000; ++i) {
		x[i] = i;
		lv_append(lv, &(x[i]));
	};

	printf("Capacity: %zu\n",lv->max_capacity);
	printf("Length: %zu\n", lv->length);

	printf("Element1: %i\n", lv->data[0]);
	lv_clear(lv);
	printf("Clean: %i\n", lv->data[0]);

*/
	lv_cleanup(lv);
	
}
