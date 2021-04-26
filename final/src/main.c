#include "student.h"
#include "test.h"
#include "gtest/gtest.h"
#include <stdio.h>
#include <stdlib.h>

Student Mario;

int main(int argc, char** argv){
/**
 * You can use a Student like this:
 *

	Student ira;
	ira.first_name = "Ira";
	ira.last_name = "Woodring";
	ira.g_number = 9;
	ira.gpa = 3.86;

	Student sarah;
	sarah.first_name = "Sarah";
	sarah.last_name = "Woodring";
	sarah.g_number = 7;
	sarah.gpa = 4.01;
	sarah.roommate = &ira;
	
	ira.roommate = &sarah;
	print_student(&ira);
	print_student(&sarah);

*/
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

TEST(Example, Demonstration){
	int x = example();
	EXPECT_EQ(x, 42);
}

TEST(Final, EasyPeasy){
	int x = 42;
	easyPeasy(&x);
	EXPECT_EQ(x, 42 * 42);
}

TEST(Final, OneTest){
	Student a;
	one(&a);
	EXPECT_STREQ(a.first_name, "Jigglypuff");
	EXPECT_STREQ(a.last_name, "Ketchum");
	EXPECT_FLOAT_EQ(a.gpa, 1.16);
	EXPECT_EQ(a.g_number, 10);
}

TEST(Final, TwoTest){
	Student a;
	a.first_name = "Hal";
	a.last_name = "Ketchum";
	a.gpa = 4.0;
	a.g_number = 1234;
	Student b;
	two(&a, &b);
	EXPECT_STREQ(get_fullname(&a), get_fullname(&b));
	EXPECT_FLOAT_EQ(a.gpa, b.gpa);
	EXPECT_EQ(a.g_number, b.g_number);
}

TEST(Final, ThreeTest){
	Student a;
	Student* b = (Student*)malloc(sizeof(Student));
	a.first_name = "Tobias";
	a.last_name = "Rieper";
	a.gpa = 4.0;
	a.g_number = 47;
	three(a, b);
	EXPECT_STREQ(get_fullname(&a), get_fullname(b));
	EXPECT_FLOAT_EQ(a.gpa, b->gpa);
	EXPECT_EQ(a.g_number, b->g_number);
}

TEST(Final, FourTest){
	Student a = four();
	Student* m = &Mario;
	EXPECT_STREQ(get_fullname(&a), "T. Yoshisaur Munchakoopas");
	EXPECT_EQ(a.roommate, m);
	EXPECT_FLOAT_EQ(a.gpa, 3.1);
	EXPECT_EQ(a.g_number, 1990);
}

TEST(Final, FiveTest){
	Student* l = five();
	EXPECT_STREQ(get_fullname(l), "Luigi Mario");
	EXPECT_EQ(l->g_number, 2);
	EXPECT_FLOAT_EQ(l->gpa, 3.54);
}

TEST(Final, SixTest){
	Student* students = six();
	EXPECT_STREQ(get_fullname(&students[3]), "Luigi Mario");
	EXPECT_EQ(students[3].g_number, 2);
	EXPECT_FLOAT_EQ(students[3].gpa, 3.54);
	// Segfault check
	students[9] = Mario;
	free(students);
}

TEST(Final, SevenTest){
	Student* students;
	seven(&students);
	EXPECT_STREQ(get_fullname(&students[3]), "Luigi Mario");
	EXPECT_EQ(students[3].g_number, 2);
	EXPECT_FLOAT_EQ(students[3].gpa, 3.54);
	// Segfault check
	students[9] = Mario;
	free(students);
}

TEST(Final, QuadraticTest){
	double a = 1;
	double b = 7;
	double c = 10;
	EXPECT_FLOAT_EQ(quadratic(a, b, c), -2); 
	a = 1;
	b = -1;
	c = -6;
	EXPECT_FLOAT_EQ(quadratic(a, b, c), 3);
}

TEST(Final, CapitalizeTest){
	char str[] = "abcdefghijklmnopqrstuvwxyz.;'0123456789()@`[{";
	size_t len = 45;
	capitalize((char*)str, len);
	EXPECT_STREQ(str, "ABCDEFGHIJKLMNOPQRSTUVWXYZ.;'0123456789()@`[{");
}	
