#include "Board.hpp"
#include "BoardValues.hpp"

#include <algorithm>
#include <iostream>

Board::Board(){
	this->visible = false;
	this->grid = new int[HEIGHT*WIDTH];
}

Board::Board(const Board& other){
	this->visible = other.visible;
	this->grid = new int[HEIGHT*WIDTH];

	for(int i = 0; i<HEIGHT;i++){
		for(int j = 0; j<WIDTH; j++){
			this->grid[i*j] = other.grid[i*j];
		}
	}
}

Board& Board::operator=(const Board& other){
	Board temp(other);
	std::swap(this->visible, temp.visible);
	std::swap(this->grid, temp.grid);
	return *this;
}

Board::~Board(){
	delete this->grid;
}

void Board::setVisible(bool v){
	this->visible = v;
}

int& Board::Internal::operator[](int index){
        if(index >= WIDTH){
                throw std::out_of_range(std::to_string(index) + " is greater value than or equal to grid width of " + std::to_string(WIDTH));
        }
        return _grid[index];
}

Board::Internal Board::operator[](int index){
        if(index >= HEIGHT){
                throw std::out_of_range(std::to_string(index) + " is greater value than or equal to grid height of " + std::to_string(HEIGHT));
        }
        return Board::Internal(grid+(index * WIDTH));
}

std::ostream& operator<<(std::ostream& os, Board const& b){
	os << "|-----------------------------------YOUR BOARD-----------------------------------|\n";
	for(int i = 0; i<WIDTH;i++){
		os<< "\t" << i;
	}
	os<<"\n----------------------------------------------------------------------------------\n";
	for(int i = 0; i <HEIGHT;i++){
		os<<i<<" |\t";
		for(int j = 0; j<WIDTH;j++){
			if(b.grid[i*j]==EMPTY){
				os << i*j<<"\t";
			}
		}
		os << "\n";
	}
	return os;
}

int Board::count() const{
	return HEIGHT*WIDTH;
}

bool Board::operator< (const Board& other){
	if(count()<other.count()){
		return true;
	}
	return false;
}
