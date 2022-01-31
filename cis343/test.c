#include <stdio.h>
#include <string.h>
#include "acutest.h"
#include "lite_vector.h"

void test_new_vec_string(void){
	lite_vector * lv = lv_new_vec(sizeof(char*));
	TEST_CHECK( lv != NULL );
	TEST_CHECK( lv_get_length(lv) == 0 );
	lv_cleanup(lv);
}

void test_new_vec_int(void){
	lite_vector * lv = lv_new_vec(sizeof(int));
	TEST_CHECK( lv != NULL);
	TEST_CHECK( lv_get_length(lv) == 0 );
	lv_cleanup(lv);
}

void test_new_vec_double(void){
	lite_vector * lv = lv_new_vec(sizeof(double));
	TEST_CHECK( lv != NULL );
	TEST_CHECK( lv_get_length(lv) == 0 );
	lv_cleanup(lv);
}

void test_cleanup(void){
	lite_vector * lv = lv_new_vec(sizeof(long));
	TEST_CHECK( lv != NULL );
	lv_cleanup(lv);
}

void test_add(void){
	lite_vector * lv = lv_new_vec(sizeof(char*));
	lv_append(lv, "Mr. ");
	lv_append(lv, "W. ");
	lv_append(lv, "says ");
	lv_append(lv, "hi!");
	TEST_CHECK( lv_get_length(lv) == 4 );
}

void test_get(void){
	lite_vector * lv = lv_new_vec(sizeof(char*));
	lv_append(lv, "Mr. ");
	lv_append(lv, "W. ");
	lv_append(lv, "says ");
	lv_append(lv, "hi!");
	TEST_CHECK( lv_get_length(lv) == 4 );
	TEST_CHECK( !strcmp(lv_get(lv, 0), "Mr. "));
	TEST_CHECK( !strcmp(lv_get(lv, 1), "W. "));
	TEST_CHECK( !strcmp(lv_get(lv, 2), "says "));
	TEST_CHECK( !strcmp(lv_get(lv, 3), "hi!"));
	TEST_CHECK( strcmp(lv_get(lv, 0), "Mr. \n"));
}

void test_remove(void){
	lite_vector * lv = lv_new_vec(sizeof(int));
	int x[1000];
	for(int i=0; i<1000; ++i){
		x[i] = i;
		lv_append(lv, (x + i));
		//printf("%d\n", lv_get(lv, i));
	};
	TEST_CHECK( lv_get_length(lv) == 1000 );
	lv_clear(lv);
	TEST_CHECK( lv_get_length(lv) == 0);
	int y = 42;
	lv_append(lv, &y);
	TEST_CHECK( lv_get_length(lv) == 1);
	lv_cleanup(lv);
}

TEST_LIST = {
	{ "Setup tests - string", test_new_vec_string },
	{ "Setup tests - integer", test_new_vec_int },
	{ "Setup tests - double", test_new_vec_double },
	{ "Cleanup test", test_cleanup },
	{ "Adding element test", test_add },
	{ "Getting element test", test_get},
	{ "Remove all test", test_remove},
	{NULL, NULL}
};