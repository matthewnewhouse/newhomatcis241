#ifndef			__STUDENT__H__
#define			__STUDENT__H__

typedef struct student {
	char const* first_name;
	char const* last_name;
	int g_number;
	float gpa;
	struct student* roommate;
} Student;

extern Student Mario;

char* get_fullname(Student* s);
void print_student(Student* s);
char const* get_first_name(Student* s);
char const* get_last_name(Student* s);
int get_g_number(Student* s);
float get_gpa(Student* s);
Student* get_roommate(Student* s);

void set_first_name(Student* s, char* fn);
void set_last_name(Student* s, char* ln);
void set_g_number(Student* s, int g);
void set_gpa(Student* s, float g);
void set_roommate(Student* s, Student* rm);

#endif
