#include "circleLib.h"

const double PI = 3.14159;

double calcRectPerim(double length, double width){

	return (length*2) + (width*2);
}

double calcRectArea(double length, double width){
	return length * width;
}
