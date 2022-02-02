#include "lite_vector.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

lite_vector* lv_new_vec(size_t type_size){
	lite_vector* vec = malloc(sizeof(lite_vector));
	vec->length=0;
	vec->max_capacity=10;
	vec->type_size=type_size;
	vec->data = (void**)malloc(10*sizeof(void*));
	return vec;
}

void lv_cleanup(lite_vector* vec){
	free (vec->data);
	return;
}

size_t lv_get_length(lite_vector* vec){
	return vec->length;
}

bool lv_clear(lite_vector* vec){
	for(int i=0; i<vec->length;i++){
		vec->data[i]= NULL;
	}
	vec->length=0;
	return true;
}

void* lv_get(lite_vector* vec, size_t index){
	return vec->data[index];
}

/**
 * lv_resize is essentially private since we marked it static.
 * The job of this function is to attempt to resize the vector.
 * There may be functions you can call to do this for you, or
 * you may write it yourself.  Either way it isn't too hard.
 * With everything though, check to make sure the code worked
 * and return appropriately.  Do NOT destroy the data if the code
 * fails.  If the resize cannot complete, the original vector
 * must remain unaffected.
 */
static bool lv_resize(lite_vector* vec){
	size_t max = (int)(vec->max_capacity*1.5);
	
	void**tmp = (void**) malloc((max*sizeof(void*)));
	memcpy(tmp,vec->data,vec->length*sizeof(void*));
	
	free(vec->data);
	vec->data = tmp;
	vec->max_capacity = max;

	return true;
}

bool lv_append(lite_vector* vec, void* element){
	
	if(vec->length  == vec->max_capacity){
		lv_resize(vec);	
	}

	vec->data[vec->length]=element;	
	
	vec->length++;
	return true;
}
