#include "lite_vector.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

lite_vector* lv_new_vec(size_t type_size){
	lite_vector vec;
	vec.length=0;
	vec.max_capacity=1;
	vec.type_size=type_size;
	vec.data = malloc(sizeof(void**));
	return &vec;
}

void lv_cleanup(lite_vector* vec){
	for(int i=0;i<vec->max_capacity;i++){
		free(vec->data[i]);
	}
	free (vec->data);
	return;
}

size_t lv_get_length(lite_vector* vec){
	size_t len = sizeof(vec->data)/sizeof(vec->data[0]);
	return len;
}

bool lv_clear(lite_vector* vec){
	for(int i=0; i<vec->length;i++){
		vec->data[i]= NULL;
	}
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
}

bool lv_append(lite_vector* vec, void* element){
	if(vec->length = vec->max_capacity){
		
	}
	else{
		vec->data[length]=element;
	}
	length++;
	return true;
}
