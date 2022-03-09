#include "Board.hpp"
#include "Direction.hpp"
#include "Game.hpp"
#include "Ship.hpp"
#include <iostream>
#include <random>

/**
 * Constructor will create the ships vector and add ships to it.
 */
Game::Game(){
	this->player = *(new Board());
	this->computer = *(new Board());
	std::vector<Ship>::iterator i;
	i = ships.begin();
	i = ships.insert(i,*(new Ship(2,"Patrol Boat",80)));
	i = ships.insert(i,*(new Ship(3,"Submarine",83)));
	i = ships.insert(i,*(new Ship(3,"Destroyer",68)));
	i = ships.insert(i,*(new Ship(4,"Battleship",66)));
	i = ships.insert(i,*(new Ship(5,"Carrier",67)));	
}

/**
 * Begin Game let's user and then computer setup boards then calls run()
 */
void Game::beginGame(){
	std::cout<< "|-----------------------------------BATTLESHIP-----------------------------------|" <<std::endl;
	std::cout<< "\nYou will play versus THE ADMIRAL, the greatest BATTLESHIP AI ever!" << std::endl;
	std::cout<< "\nIn BATTLESHIP, the pieces are as follows: " <<std::endl;
	for(int i = 0; i<ships.size();i++){
		std::cout<<"\t"<<ships.at(i)<<std::endl;
	}
	std::cout<<""<<std::endl;
	
	placeShips();
	placeShipsPC();
	run();
}

/**
 * Handle the human placing ships.
 */
void Game::placeShips(){
	int row;
	int col;
	int d;
	Direction dir;
	for(int i = 0; i<ships.size();i++){
		std::cout<<"Where would you like to place The " << ships.at(i)<<"?"<<std::endl;
		std::cout << "Row: ";
		std::cin  >> row;
		std::cout << "Column: ";
		std::cin  >> col;
		std::cout << "Would you like to place The " << ships.at(i) << " HORIZONTALLY or VERTICALLY? (Input 0 or 1)" << std::endl;
		std::cout << "Direction: ";
		std::cin  >> d;
		
		if(d == 0){
			dir = HORIZONTAL;
		}
		
		if(d == 1){
			dir = VERTICAL;
		}

		std::cout << "" << std::endl;
		if(row < 0 or row>=HEIGHT){
			std::cout << "The given row value is outside of the bounds of the board. Try again.\n" << std::endl;
			i--;
		}
		else if(col < 0 or col>=WIDTH){
			std::cout << "The given column value is outside of the bounds of the board. Try again\n." << std::endl;
			i--;
		}
		else if(d!=0 and d!=1){
			std::cout << "The given direction value was not 0 or 1. Try again.\n" << std::endl;
			i--;
		}
		else if(!place(row,col,dir,ships.at(i),player)){
			i--;
		}
		else{
			int length = ships.at(i).getSpaces();
			if(dir == HORIZONTAL){
				for(int k = col; k<(length+col);k++){
					player[row][k] = ships.at(i).getChr();
				}
			}
			else{
				for(int k = row; k<(length+row);k++){
					player[k][col] = ships.at(i).getChr();
				}
				
			}
			
			if(dir == HORIZONTAL){
				std::cout << "The " << ships.at(i).getName() << " has been successfully placed at (" << row << "," << col 
					<< ") horizontally.\n" <<std::endl;
			}
			else{
				std::cout << "The " << ships.at(i).getName() << " has been successfully placed at (" << row << "," << col 
					<< ") vertically.\n" <<std::endl;	
			}
		}
	}
	std::cout << "|-----------------------------------YOUR BOARD-----------------------------------|\n" << std::endl;
	std::cout << player << std::endl;
}

/**
 * Handle the computer placing ships.
 */
void Game::placeShipsPC(){
	
}

/**
 * Helper method that checks if it is safe to put a ship
 * at a particular spot with a particular direction.
 */
bool Game::place(const int& x, const int& y, Direction d, const Ship& s, Board& b){
	int length = s.getSpaces();
	int endRow = x + length;
	int endCol = y + length;
	if(d == HORIZONTAL){
		if(endCol>WIDTH){
			std::cout << "This direction would place the ship outside of the bounds of the board. Try again.\n" << std::endl;
			return false;
		}
		for(int i = y; i<endCol; i++){
			if(player[x][i] != EMPTY){
				std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				return false;
			}
		}
	}
	else{
		if(endRow>HEIGHT){
			std::cout << "This direction would place the ship outside of the bounds of the board. Try again.\n" << std::endl;
			return false;
		}
		for(int i = x; i<endRow; i++){
			if(player[i][y] != EMPTY){	
				std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				return false;
			}
		}
		
	}

	return true;
}

/**
 * Call human turn/computer turn until someone wins.
 */
void Game::run(){
	while(true){
	humanTurn();
	if(computer.count()==0){
		return;
	}
	computerTurn();
	if(player.count()==0){
		return;
	}
   }
}

void Game::humanTurn(){
}

void Game::computerTurn(){
}

/**
 * Create a game instance and start.
 */
int main(int argc, char** argv){
	(void)argc;
	(void)argv;
	Game g;
	g.beginGame();

	return 0;
}
