#ifndef			__TEST_H__
#define			__TEST_H__

#include "student.h"
#include <stdlib.h>

int example();

void easyPeasy(int* x);
void one(Student* a);
void two(Student* a, Student* b);
void three(Student a, Student* b);
Student four();
Student* five();
Student* six();
void seven(Student** mem);
double quadratic(double a, double b, double c);
void capitalize(char* str, size_t len);

#endif
