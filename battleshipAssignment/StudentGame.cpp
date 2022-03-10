#include "Board.hpp"
#include "Direction.hpp"
#include "Game.hpp"
#include "Ship.hpp"
#include <iostream>
#include <random>

int getPlayerShipCount();
int getComputerShipCount();
int getRandomInt(int from, int to);
void printScore(int turnCount, Board p, Board c);
std::vector<Ship> playerShips{};
std::vector<Ship> computerShips{};

/*
 *Create ships vector and adds ships to it.
 */
Game::Game(){
	Board* playerBoard = new Board();
	player = *(playerBoard);
	player.setVisible(true);

	Board* computerBoard = new Board();
	computer = *(computerBoard);
	computer.setVisible(false);

	Ship* Carrier = new Ship(5,"Carrier",67,0);
	Ship* Battleship = new Ship(4,"Battleship",66,0);
	Ship* Destroyer = new Ship(3,"Destroyer",68,0);
	Ship* Submarine = new Ship(3,"Submarine",83,0);
	Ship* PatrolBoat = new Ship(2,"Patrol Boat",80,0);

	std::vector<Ship>::iterator i;
	i = ships.begin();
	i = ships.insert(i,*PatrolBoat);
	i = ships.insert(i,*Submarine);
	i = ships.insert(i,*Destroyer);
	i = ships.insert(i,*Battleship);
	i = ships.insert(i, *Carrier);

	playerShips = std::vector<Ship>(ships);
	computerShips = std::vector<Ship>(ships);
	
	delete Carrier;
	delete Battleship;
	delete Destroyer;
	delete Submarine;
	delete PatrolBoat;
	delete playerBoard;
	delete computerBoard;
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
	std::string inputRow;
	std::string inputCol;
	std::string inputDir;
	int row;
	int col;
	int d;
	Direction dir;
	for(int i = 0; i<ships.size();i++){

		std::cout << "|-----------------------------------YOUR BOARD-----------------------------------|\n" << std::endl;
		std::cout << player << std::endl;

		row = -100;
		col = -100;
		d = -100;
		std::cout<<"Where would you like to place The " << ships.at(i)<<"?"<<std::endl;
		
		std::cout << "Row: ";
		std::cin  >> inputRow;

		std::cout << "Column: ";
		std::cin  >> inputCol;

		std::cout << "Would you like to place The " << ships.at(i) << " HORIZONTALLY or VERTICALLY? (Input 0 or 1)" << std::endl;
		std::cout << "Direction: ";
		std::cin  >> inputDir;
		std::cout << "" << std::endl;	
	

		for(char c : inputRow){
			if(!isdigit(c)){
				row = -1;	
			}
		}
		if(row!=-1){
			row = stoi(inputRow);
		}



		for(char c : inputCol){
			if(!isdigit(c)){
				col = -1;
			}
		}
		if(col!=-1){
			col = stoi(inputCol);
		}



		for(char c : inputDir){
			if(!isdigit(c)){
				d = -1;
			}
		}
		if(d!=-1){
			d = stoi(inputDir);
		}



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
		std::cout << "The given column value is outside of the bounds of the board. Try again.\n" << std::endl;
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

int getPlayerShipCount(){
	int count = playerShips.size();
	for(int i = 0; i<playerShips.size();i++){
		if(playerShips.at(i).getHits() == playerShips.at(i).getSpaces()){
			count --;
		}
	}
	return count;
}

int getComputerShipCount(){
	int count = computerShips.size();
	for(int i = 0; i<computerShips.size();i++){
		if(computerShips.at(i).getHits() == computerShips.at(i).getSpaces()){
			count --;
		}
	}

	return count;
}

/*Prints current score. */
void printScore(int turnCount, Board p, Board c, bool playerTurn){
	std::cout<<"\nPLAYER VS. THE ADMIRAL" << std::endl;
	std::cout << "--------------------------"<<std::endl;
	if(playerTurn){
		std::cout << "ROUND " << turnCount+1 << " - PLAYER'S TURN" << std::endl;
	}
	else{
		std::cout << "ROUND " << turnCount+1 << " - ADMIRAL'S TURN" << std::endl; 
	}
	std::cout << "--------------------------"<<std::endl;
	std::cout << p.count() << "HP VS. " << c.count() << "HP" << std::endl;
	std::cout << "--------------------------"<<std::endl;
	std::cout << getPlayerShipCount() << " SHIPS VS. " << getComputerShipCount() << " SHIPS" << std::endl;	

	if(p.count() == c.count()){
		std::cout << "--------------------------"<<std::endl;
		std::cout << "TIED GAME\n" << std::endl;
	}
	else if(p.count() < c.count()){
		std::cout << "--------------------------"<<std::endl;
		std::cout << "THE ADMIRAL IS WINNING\n" << std::endl;
	}
	else{
		std::cout << "--------------------------"<<std::endl;
		std::cout << "PLAYER IS WINNING\n" << std::endl;
	}
}

/**
 * Call human turn/computer turn until someone wins.
 */
void Game::run(){
	int turnCount = 0;

	while(player.count()!=0){

		printScore(turnCount, player, computer, true);

		humanTurn();

		printScore(turnCount, player, computer, false);

		if(computer.count()==0){
			std::cout << "You beat The ADMIRAL! Congratulations!" << std::endl;
			return;
		}
		

		computerTurn();

		std::cout << "|-----------------------------------YOUR BOARD-----------------------------------|\n" << std::endl;
		std::cout << player << std::endl;
		
		std::cout << "|---------------------------------COMPUTER BOARD---------------------------------|\n" << std::endl;
		std::cout << computer << std::endl;

		turnCount++;
   	}

	printScore(turnCount, player, computer, true);

	std::cout << "THE ADMIRAL wins!" << std::endl;
	return;
}

void Game::humanTurn(){
	std::string inputRow;
	std::string inputCol;
	bool finished = false;
	int row;
	int col;
	while(!finished){
		row = -100;
		col = -100;
		std::cout<<"Where would you like to shoot?"<<std::endl;
		std::cout << "Row: ";
		std::cin  >> inputRow;
		std::cout << "Column: ";
		std::cin  >> inputCol;
		

		for(char c : inputRow){
			if(!isdigit(c)){
				row = -1;
			}
		}
		if(row != -1){
			row = stoi(inputRow);
		}

		for(char c : inputCol){
			if(!isdigit(c)){
				col = -1;
			}
		}
		if(col != -1){
			col = stoi(inputCol);
		}

		if(row < 0 or row>=HEIGHT){
			std::cout << "\nThe given row value is outside of the bounds of the board. Try again.\n" << std::endl;
		}
		else if(col < 0 or col>=WIDTH){
			std::cout << "\nThe given column value is outside of the bounds of the board. Try again.\n" << std::endl;
		}
		else if(computer[row][col] != HIT and computer[row][col] != MISS){
			std::cout << "\nYou shot at (" << row << "," << col << ")." << std::endl;
			if(computer[row][col] == EMPTY){
				computer[row][col] = MISS;
				std::cout << "You missed!" << std::endl;
			}
			else{
				if(computer[row][col] == CARRIER){
					
					std::cout << "You hit one of THE ADMIRAL'S ships!" << std::endl;
					try{
					computerShips.at(0).addHit();
					}
					catch(SunkShipException e){
						std::cout << "You sank THE ADMIRAL'S carrier!" << std::endl;
					}
				}
				else if(computer[row][col] == BATTLESHIP){
					std::cout << "You hit one of THE ADMIRAL'S ships!" << std::endl;
					try{
						computerShips.at(1).addHit();
					}
					catch(SunkShipException e){
						std::cout << "You sank THE ADMIRAL'S battleship!" << std::endl;
					}
				}
				else if(computer[row][col] == DESTROYER){
					std::cout << "You hit one of THE ADMIRAL'S ships!" << std::endl;
					try{
						computerShips.at(2).addHit();
					}
					catch(SunkShipException e){
						std::cout << "You sank THE ADMIRAL'S destroyer!" << std::endl;
					}
				}
				else if(computer[row][col] == SUBMARINE){
					std::cout << "You hit one of THE ADMIRAL'S ships!" << std::endl;
					try{
						computerShips.at(3).addHit();
					}
					catch(SunkShipException e){
						std::cout << "You sank THE ADMIRAL'S submarine!" << std::endl;
					}
				}
				else if(computer[row][col] == PATROLBOAT){
					std::cout << "You hit one of THE ADMIRAL'S ships!" << std::endl;
					try{
						computerShips.at(4).addHit();
					}
					catch(SunkShipException e){
						std::cout << "You sank THE ADMIRAL'S patrol boat!" << std::endl;
					}
				}

				computer[row][col] = HIT;
			}

			finished = true;
		}
		else{
			std::cout << "\nYou have already shot there. Try somwehere else.\n" << std::endl;
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
				if(player[row][col] == CARRIER){
					
					std::cout << "THE ADMIRAL hit your carrier!" << std::endl;
					try{
						playerShips.at(0).addHit();
					}
					catch(SunkShipException e){
						std::cout << "THE ADMIRAL sank your carrier!" << std::endl;
					}
				}
				else if(player[row][col] == BATTLESHIP){
					
					std::cout << "THE ADMIRAL hit your battleship!" << std::endl;
					try{
						playerShips.at(1).addHit();
					}
					catch(SunkShipException e){
						std::cout << "THE ADMIRAL sank your battleship!" << std::endl;
					}
				}
				else if(player[row][col] == DESTROYER){
					
					std::cout << "THE ADMIRAL hit your destroyer!" << std::endl;
					try{
						playerShips.at(2).addHit();
					}
					catch(SunkShipException e){
						std::cout << "THE ADMIRAL sank your destroyer!" << std::endl;
					}
				}
				else if(player[row][col] == SUBMARINE){
					
					std::cout << "THE ADMIRAL hit your submarine!" << std::endl;
					try{
						playerShips.at(3).addHit();
					}
					catch(SunkShipException e){
						std::cout << "THE ADMIRAL sank your submarine!" << std::endl;
					}
				}
				else if(player[row][col] == PATROLBOAT){
					
					std::cout << "THE ADMIRAL hit your patrol boat!" << std::endl;
					try{
						playerShips.at(4).addHit();
					}
					catch(SunkShipException e){
						std::cout << "THE ADMIRAL sank your patrol boat!" << std::endl;
					}
				}

				std::cout << "" << std::endl;
				player[row][col] = HIT;
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
