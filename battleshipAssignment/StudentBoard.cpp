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

	for(int i = 0; i<(HEIGHT*WIDTH);i++){
			this->grid[i] = other.grid[i];
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
	int val = -1;
	for(int i = 0; i<WIDTH;i++){
		os<< "\t" << i;
	}
	os<<"\n----------------------------------------------------------------------------------\n";
	
	if(b.visible){
	for(int i = 0; i <HEIGHT;i++){
		os<<i<<" |\t";
		for(int j = 0; j<WIDTH;j++){
			Board temp(b);
			val = temp[i][j];	
			if(val==EMPTY){
				os << " "<<"\t";
			}
			else if(val==CARRIER){
				os << "C" << "\t";
			}
			else if(val==BATTLESHIP){
				os << "B" << "\t";
			}
			else if(val==DESTROYER){
				os << "D" << "\t";
			}
			else if(val==SUBMARINE){
				os << "S" << "\t";
			}
			else if(val==PATROLBOAT){
				os << "P" << "\t";
			}
			else if(val==MISS){
				os << "-" << "\t";
			}
			else{
				os << "*" << "\t";
			}
		}
		os << "\n";
	}
	}
	else{
		for(int i = 0; i <HEIGHT;i++){
		os<<i<<" |\t";
		for(int j = 0; j<WIDTH;j++){
			Board temp(b);
			val = temp[i][j];
			if(val==MISS){
				os << "-" << "\t";
			}
			else if(val==HIT){
				os << "*" << "\t";
			}
			else{
				os << " " << "\t";
			}

		}
		os<< "\n";
		}
	}

	os<<"\n----------------------------------------------------------------------------------\n";

	return os;
}

int Board::count() const{
	int count = 0;
	for(int i = 0; i<(HEIGHT*WIDTH);i++){
		if(this->grid[i]!=EMPTY and this->grid[i]!=HIT and this->grid[i]!=MISS){
			count++;
		}
	}
	return count;
}

bool Board::operator< (const Board& other){
	if(count()<other.count()){
		return true;
	}
	return false;
}
