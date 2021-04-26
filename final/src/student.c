#include "student.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* get_fullname(Student* s){
	char* full = (char*)malloc((strlen(s->first_name) + strlen(s->last_name) + 1) * sizeof(char));
	sprintf(full, "%s %s", s->first_name, s->last_name);
	return full;
}

void print_student(Student* s){
	printf("%d: %s has gpa %.2f and rooms with %s\n", s->g_number, get_fullname(s), s->gpa, get_fullname(s->roommate));
}

char const* get_first_name(Student* s){
	return s->first_name;
}

char const* get_last_name(Student* s){
	return s->last_name;
}

int get_g_number(Student* s){
	return s->g_number;
}

float get_gpa(Student* s){
	return s->gpa;
}

Student* get_roommate(Student* s){
	return s->roommate;
}

void set_first_name(Student* s, char* fn){
	s->first_name = fn;
}

void set_last_name(Student* s, char* ln){
	s->last_name = ln;
}

void set_g_number(Student* s, int g){
	s->g_number = g;
}

void set_gpa(Student* s, float g){
	s->gpa = g;
}

void set_roommate(Student* s, Student* rm){
	s->roommate = rm;
}
