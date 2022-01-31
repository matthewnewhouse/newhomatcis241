#include "lite_vector.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

lite_vector* lv_new_vec(size_t type_size){
}

void lv_cleanup(lite_vector* vec){
}

size_t lv_get_length(lite_vector* vec){
}

bool lv_clear(lite_vector* vec){
}

void* lv_get(lite_vector* vec, size_t index){
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
}