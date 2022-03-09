#include "Board.hpp"
#include "Direction.hpp"
#include "Game.hpp"
#include "Ship.hpp"
#include <iostream>
#include <random>


int getRandomInt(int from, int to);
void printScore(int turnCount, Board p, Board c);

/**
 * Constructor will create the ships vector and add ships to it.
 */
Game::Game(){
	this->player = *(new Board());
	player.setVisible(true);
	this->computer = *(new Board());
	computer.setVisible(true);

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
	std::cout<< "\nYou will play against THE ADMIRAL, the greatest BATTLESHIP AI ever!" << std::endl;
	std::cout<< "\nIn BATTLESHIP, the ships are as follows: " <<std::endl;
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
		std::cout << "" << std::endl;	
		
		if(d == 0){
			dir = HORIZONTAL;
		}

		if(d == 1){
			dir = VERTICAL;
		}

		if(d!=0 and d!=1){
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

	int d = -1;
	Direction dir;
	int row = -1;
	int col = -1;
	int length = -1;

	for(int i = 0; i<ships.size();i++){
		
		length = ships.at(i).getSpaces();

		d = getRandomInt(0,1);

		if(d==0){
			dir = HORIZONTAL;
		}
		else{
			dir = VERTICAL;
		}
		
		if(dir==HORIZONTAL){
			row = getRandomInt(0, HEIGHT-1);
			col = getRandomInt(0, (WIDTH - 1)-length);
		}
		else{
			row = getRandomInt(0, (HEIGHT-1)-length);
			col = getRandomInt(0, WIDTH-1);
		}
		
		if(!place(row,col,dir,ships.at(i),computer)){
			i--;
		}
		else{
			if(dir == HORIZONTAL){
				for(int k = col; k<(length+col);k++){
					computer[row][k] = ships.at(i).getChr();
				}
			}
			else{
				for(int k = row; k<(length+row);k++){
					computer[k][col] = ships.at(i).getChr();
				}

			}
		}

	}

	std::cout << "|---------------------------------COMPUTER BOARD---------------------------------|\n" << std::endl;
	std::cout << computer << std::endl;
}


/*Get random int in between given values.*/
int getRandomInt(int from, int to) {
	std::random_device rand_dev;
	std::mt19937 generator(rand_dev());
	std::uniform_int_distribution<int> distr(from, to);
	return distr(generator);
}

/**
 * Helper method that checks if it is safe to put a ship
 * at a particular spot with a particular direction.
 */
bool Game::place(const int& x, const int& y, Direction d, const Ship& s, Board& b){
	int length = s.getSpaces();
	int endRow = x + length;
	int endCol = y + length;

	
	if(x < 0 or x>=HEIGHT){
		std::cout << "The given row value is outside of the bounds of the board. Try again.\n" << std::endl;
		return false;
	}
	else if(y < 0 or y>=WIDTH){
		std::cout << "The given column value is outside of the bounds of the board. Try again\n." << std::endl;
		return false;
	}


	if(d == HORIZONTAL){
		if(endCol>WIDTH){
			std::cout << "This direction would place the ship outside of the bounds of the board. Try again.\n" << std::endl;
			return false;
		}
		for(int i = y; i<endCol; i++){
			if(b[x][i] != EMPTY){
				if(!(b<player) && !(player<b)){
					std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				}
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
			if(b[i][y] != EMPTY){
				if(!(b<player) && !(player<b)){
					std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				}
				return false;
			}
		}
		
	}

	return true;
}

/*Prints current score. */
void printScore(int turnCount, Board p, Board c, bool playerTurn){
	std::cout<<"\nPLAYER VS. THE ADMIRAL" << std::endl;
	std::cout << "------------------------"<<std::endl;
	if(playerTurn){
		std::cout << "ROUND " << turnCount+1 << " - PLAYER'S TURN" << std::endl;
	}
	else{
		std::cout << "ROUND " << turnCount+1 << " - ADMIRAL'S TURN" << std::endl; 
	}
	std::cout << "------------------------"<<std::endl;
	std::cout << "   " << p.count() << "HP   VS.   " << c.count() << "HP\n" << std::endl;	
}

/**
 * Call human turn/computer turn until someone wins.
 */
void Game::run(){
	int turnCount = 0;
	while(player.count()!=0){

		printScore(turnCount, player, computer, true);

		humanTurn();
		
		std::cout << "|---------------------------------COMPUTER BOARD---------------------------------|\n" << std::endl;
		std::cout << computer << std::endl;		

		printScore(turnCount, player, computer, false);

		if(computer.count()==0){
			std::cout << "You beat The ADMIRAL! Congratulations!" << std::endl;
			return;
		}
		

		computerTurn();

		std::cout << "|-----------------------------------YOUR BOARD-----------------------------------|\n" << std::endl;
		std::cout << player << std::endl;

		turnCount++;
   	}

	printScore(turnCount, player, computer, true);

	std::cout << "THE ADMIRAL wins!" << std::endl;
	return;
}

void Game::humanTurn(){
	bool finished = false;
	int row = -1;
	int col = -1;
	while(!finished){
		std::cout<<"Where would you like to shoot?"<<std::endl;
		std::cout << "Row: ";
		std::cin  >> row;
		std::cout << "Column: ";
		std::cin  >> col;
		if(computer[row][col] != HIT and computer[row][col] != MISS){
			std::cout << "\nYou shoot at (" << row << "," << col << ")." << std::endl;
			if(computer[row][col] == EMPTY){
				computer[row][col] = MISS;
				std::cout << "You missed!\n" << std::endl;
			}
			else{
				computer[row][col] = HIT;
				std::cout << "You hit one of THE ADMIRAL'S ships!\n" << std::endl;
			}
			finished = true;
		}
	}

}

void Game::computerTurn(){
	bool finished = false;
	int row = -1;
	int col = -1;
	while(!finished){
		row = getRandomInt(0, HEIGHT-1);
		col = getRandomInt(0, WIDTH-1);
		if(player[row][col] != HIT and player[row][col] != MISS){
			std::cout<<"THE ADMIRAL shoots at (" << row << "," << col << ")."  << std::endl;
			if(player[row][col] == EMPTY){
				player[row][col] = MISS;
				std::cout << "THE ADMIRAL missed!\n" << std::endl;
			}
			else{
				player[row][col] = HIT;
				std::cout << "THE ADMIRAL hit one of your ships!\n" << std::endl;
			}
			finished = true;
		}
	}
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