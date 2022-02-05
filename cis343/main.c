#include <stdio.h>
#include "lite_vector.h"

int main(int argc, char** argv){
	lite_vector * lv = lv_new_vec(NULL);
	lite_vector * lv2 = lv_new_vec(8);
	lv_get_length(lv);
	lv_clear(lv);
	lv_get(lv,0);
	lv_get(lv2,-1);
	lv_append(lv2,NULL);
	lv_append(lv,0);
	lv_cleanup(lv);
	
}
