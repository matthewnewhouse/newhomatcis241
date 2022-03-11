#include "Board.hpp"
#include "BoardValues.hpp"
#include <algorithm>
#include <iostream>

/*********************************************************
 * Representation of a board in the BATTLESHIP game.
 * The board's visiblity can be turned on and off.
 * The values that correlate to ships are stored in
 * the board's grid.
 *
 * @author Matthew Newhouse
 * @version Winter 2022
 ********************************************************/

/*********************************************************
* Constructor creates a board that defaults to not
* visible and has a grid with a predetermined height
* and width.
*********************************************************/
Board::Board(){
	this->visible = false;
	this->grid = new int[HEIGHT*WIDTH]{0};
}

/********************************************************
 * Takes a board "other" and deep copies it.
 *
 * @param other is the board to be copied into this.
 *******************************************************/
Board::Board(const Board& other){
	this->visible = other.visible;
	this->grid = new int[HEIGHT*WIDTH]{0};
	
	//Copies the other board's grid into this grid.
	for(int i = 0; i<(HEIGHT*WIDTH);i++){
			this->grid[i] = other.grid[i];
	}
}

/*******************************************************
 * Overloads the equal operator for board.
 *
 * @param other is the board to compare this to.
 * @return this board with copied data from other.
 ******************************************************/
Board& Board::operator=(const Board& other){
	Board temp(other);
	std::swap(this->visible, temp.visible);
	std::swap(this->grid, temp.grid);
	return *this;
}

/*******************************************************
 * Destructor deletes the grid from the board.
 ******************************************************/
Board::~Board(){
	delete[] this->grid;
}

/******************************************************
 * Sets the visibiltiy of the board to true or false.
 *
 * @param v is a boolean variable.
 *****************************************************/
void Board::setVisible(bool v){
	this->visible = v;
}

/******************************************************
 * Overloads the [] operator.
 *
 * @param index is used to access a specfic location
 * in the grid.
 * @return an integer from the grid.
 *****************************************************/
int& Board::Internal::operator[](int index){
        if(index >= WIDTH){
                throw std::out_of_range(std::to_string(index) 
				+ " is greater value than or equal to grid width of " 
				+ std::to_string(WIDTH));
        }
        return _grid[index];
}

/******************************************************
 * Overloads the [] operator.
 *
 * @param index is used to access a specfic location
 * in the grid.
 * @return an internal class object.
 *****************************************************/
Board::Internal Board::operator[](int index){
        if(index >= HEIGHT){
                throw std::out_of_range(std::to_string(index) 
				+ " is greater value than or equal to grid height of " 
				+ std::to_string(HEIGHT));
        }
        return Board::Internal(grid+(index * WIDTH));
}

/******************************************************
 * Overloads the << operator for printing a board.
 *
 * @param os, a stream and b, a board.
 * @return os, the stream.
 *****************************************************/
std::ostream& operator<<(std::ostream& os, Board const& b){
	Board temp(b);
	int val = -1;

	//Prints column numbers.
	for(int i = 0; i<WIDTH;i++){
		os << "\t" << i;
	}

	os << "\n----------------------------------------------------------------------------------\n";
	
	//If this board is visible, show spaces with ships. Otherwise, make them appear empty.
	if(temp.visible){

		//Loops through every spot on the grid.
		for(int i = 0; i <HEIGHT;i++){

			os << i << " |\t";
			
			for(int j = 0; j<WIDTH;j++){
			
				val = temp[i][j];	
			
				//Conditional structure for each possible value in the grid.
				if(val==EMPTY){
					os << " " << "\t";
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
	//Else, the ships shouldn't be visible to the player.
	else{

		//Loops through every spot in the grid.
		for(int i = 0; i <HEIGHT;i++){
		
			os << i << " |\t";
		
			for(int j = 0; j<WIDTH;j++){
		
				val = temp[i][j];
		
				//Only misses, hits, or empty spots are shown.
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

	os << "----------------------------------------------------------------------------------\n";

	return os;
}

/******************************************************
 * Counts the number of spaces with ships on a board's
 * grid.
 *
 * @return int, the count of spaces with ships.
 *****************************************************/
int Board::count() const{
	
	int count = 0;
	
	//Loops through every spot in the grid and counts all spaces with ships.
	for(int i = 0; i<(HEIGHT*WIDTH);i++){
		
		if(this->grid[i]!=EMPTY and this->grid[i]!=HIT and this->grid[i]!=MISS){
		
			count++;
		}
	}
	return count;
}

/****************************************************
 * Overloads the < operator for comparing boards.
 * 
 * @param other is the board to compare to this
 * board.
 * @return bool. True if this board has less spaces
 * with ships than the other board.
 ****************************************************/
bool Board::operator< (const Board& other){
	return count()<other.count();
}
