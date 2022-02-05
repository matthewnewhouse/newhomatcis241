#include "lite_vector.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

//Creates a new lite vector from the given size of the data type.
lite_vector* lv_new_vec(size_t type_size){

	//If the type_size is NULL, return NULL.
	if(!type_size){
		return NULL;
	}

	//Size of the type should be greater than 0.
	//Otherwise, a null is returned.
	if(type_size<=0){
		return NULL;
	}

	//Mallocs enough memory for a lite_vector.
	//The pointer vec points to this memory.
	lite_vector* vec = malloc(sizeof(lite_vector));

	//The initial length is always 0, since nothing
	//has been appended.
	vec->length=0;

	//The default capacity is 10.
	vec->max_capacity=10;

	//Type size isn't really used, but it is
	//stored anyways.
	vec->type_size=type_size;

	//Mallocs enough memory for 10 of the given
	//data type. Data will point to this memory.
	vec->data = (void**)malloc(10*sizeof(void*));
	return vec;
}


//Frees up all malloc'd memory in the lite vector.
void lv_cleanup(lite_vector* vec){

	//If the vector is NULL, return NULL.
	if(!vec){
		return;
	}

	//Frees the lite vector's data.
	free (vec->data);
	//Frees the lite vector.
	free (vec);

	return;
}

//Returns the number of elements in the lite vector.
size_t lv_get_length(lite_vector* vec){

	//If the lite_vector is NULL, return 0.
	if(!vec){
		return 0;
	}

	//Otherwise, return the vector's length.
	return vec->length;
}

//Removes all of the elements in the lite vector.
bool lv_clear(lite_vector* vec){

	//If the vector is null, return false.
	if(!vec){
		return false;
	}

	//Otherwise, all elements in the vector's
	//data are set to NULL.
	for(int i=0; i<vec->length;i++){
		vec->data[i]= NULL;
	}

	//The vector's length is set to 0.
	vec->length=0;

	//The elements were removed successfully,
	//so true is returned.
	return true;
}

//Returns an element from the vector, given an index.
void* lv_get(lite_vector* vec, size_t index){

	//If the index is less than 0,
	//NULL is returned.
	if(index<0){
		return NULL;
	}
	//If the vector is NULL,
	//NULL is returned.
	if(!vec){
		return NULL;
	}

	//Otherwise, the element at the given index 
	//is returned.
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
	if(!vec){
		return false;
	}

	//Max stores the new max capacity that
	//the vector will be resized to.
	//The original max capacity is multiplied
	//by 1.5.
	size_t max = (int)(vec->max_capacity*1.5);
	
	//TMP (temp) will hold the memory for the new data,
	//which has a larger max capacity.
	void**tmp = (void**) malloc((max*sizeof(void*)));

	//If tmp is NULL due to a failed Malloc, the
	//function will return false.
	if(!tmp){
		return false;
	}

	//Otherwise, memcopy will copy the contents of
	//the current data into tmp.
	memcpy(tmp,vec->data,vec->length*sizeof(void*));
	
	//Data's original malloc'd memory is freed.
	free(vec->data);

	//Data now points to tmp's memory, which
	//has a larger max capacity.
	vec->data = tmp;

	//The vector's max capacity is now set to the
	//new max, calculated above.
	vec->max_capacity = max;

	//The resizing was successful.
	return true;
}

//An element is appened to the end of the lite vector.
bool lv_append(lite_vector* vec, void* element){
	
	//If the the vector is NULL, return false.
	if(!vec){
		return false;
	}

	//If the given element is NULL, return false.
	if(!element){
		return false;
	}

	//If the number of elements equals the max
	//capacity, resize the vector.
	if(vec->length  == vec->max_capacity){
		lv_resize(vec);	
	}

	//The element is appended to the end of the vector.
	vec->data[vec->length]=element;	
	
	//The vector's length is increased by 1.
	vec->length++;

	//The element was successfully appended.
	return true;
}
