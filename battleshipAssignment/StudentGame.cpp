#include "Board.hpp"
#include "Direction.hpp"
#include "Game.hpp"
#include "Ship.hpp"
#include <iostream>
#include <random>

/*********************************************************
 * Representation of a BATTLESHIP game. This consists of
 * the various ship pieces, the player and computer
 * boards, and the methods needed to properly run the
 * game.
 *
 * @author Matthew Newhouse
 * @version Winter 2022
 ********************************************************/

/********************************************************
 * Constructor creates the player and computer boards,
 * sets their visibilites, and creates the ships
 * needed for the game.
 *******************************************************/
Game::Game(){

	//Creates player's board. It is visible.
	Board* playerBoard = new Board();
	player = *(playerBoard);
	player.setVisible(true);

	//Creates the conputer's board. It is not visible. 
	Board* computerBoard = new Board();
	computer = *(computerBoard);
	computer.setVisible(false);

	//Creates all five BATTLESHIP pieces.
	Ship* Carrier = new Ship(5,"Carrier",67,0);
	Ship* Battleship = new Ship(4,"Battleship",66,0);
	Ship* Destroyer = new Ship(3,"Destroyer",68,0);
	Ship* Submarine = new Ship(3,"Submarine",83,0);
	Ship* PatrolBoat = new Ship(2,"Patrol Boat",80,0);

	//Adds all of the ships to a vector.
	std::vector<Ship>::iterator i;
	i = ships.begin();
	i = ships.insert(i,*PatrolBoat);
	i = ships.insert(i,*Submarine);
	i = ships.insert(i,*Destroyer);
	i = ships.insert(i,*Battleship);
	i = ships.insert(i, *Carrier);

	//Creates vectors to track hits on the
	//player's and computer's ships.
	playerShips = std::vector<Ship>(ships);
	computerShips = std::vector<Ship>(ships);
	
	//Deletes all dynamic memory allocation
	//to make sure no leaks are possible.
	delete Carrier;
	delete Battleship;
	delete Destroyer;
	delete Submarine;
	delete PatrolBoat;
	delete playerBoard;
	delete computerBoard;
}

/********************************************************
 * Starts up the game by printing the starting text.
 * Places the player's and computer's ships.
 * Runs the game until someone wins.
 *******************************************************/
void Game::beginGame(){

	//Prints basic start up information.
	std::cout<< "|-----------------------------------BATTLESHIP-----------------------------------|" <<std::endl;
	std::cout<< "\nYou will play against THE ADMIRAL, the greatest computer player ever!" << std::endl;
	std::cout<< "\nIn BATTLESHIP, the ships are as follows: " <<std::endl;
	
	//Prints ship game pieces.
	for(int i = 0; i<ships.size();i++){
		std::cout<<"\t"<<ships.at(i)<<std::endl;
	}
	std::cout<<""<<std::endl;
	
	//Places ships and starts the game.
	placeShips();
	placeShipsPC();
	run();
}

/********************************************************
 * Places the player's ships and ensures no errors occur.
 *******************************************************/
void Game::placeShips(){

	//Used for input validation.
	std::string inputRow;
	std::string inputCol;
	std::string inputDir;

	//Holds row, column, direction values.
	int row;
	int col;
	int d;
	Direction dir;

	//Loops through every ship to be placed.
	for(int i = 0; i<ships.size();i++){

		printPlayerBoard();

		//Row, column, and direction values need to be given by the player.
		row = -100;
		col = -100;
		d = -100;

		std::cout<<"Where would you like to place The " << ships.at(i)<<"?"<<std::endl;
		
		//Gets row value from user.
		std::cout << "Row: ";
		std::cin  >> inputRow;

		//Gets column value from user.
		std::cout << "Column: ";
		std::cin  >> inputCol;

		//Gets direction value from user.
		std::cout << "Would you like to place The " << ships.at(i) << " HORIZONTALLY or VERTICALLY? (Input 0 or 1)" << std::endl;
		std::cout << "Direction: ";
		std::cin  >> inputDir;
		std::cout << "" << std::endl;	
	

		//Checks if the given row is valid.
		for(char c : inputRow){
			if(!isdigit(c)){
				row = -1;	
			}
		}
		if(row!=-1){
			row = stoi(inputRow);
		}



		//Checks if the given column is valid.
		for(char c : inputCol){
			if(!isdigit(c)){
				col = -1;
			}
		}
		if(col!=-1){
			col = stoi(inputCol);
		}



		//Checks if the given direction is valid.
		for(char c : inputDir){
			if(!isdigit(c)){
				d = -1;
			}
		}
		if(d!=-1){
			d = stoi(inputDir);
		}


		//Makes sure direction value is either 0 or 1.
		if(d == 0){
			dir = HORIZONTAL;
		}

		if(d == 1){
			dir = VERTICAL;
		}

		//This conditional structure checks if all given values are within the bounds of the board.
		//If so, then the ship is placed.
		//This is statement checks if the direction is HORIZONTAL or VERTICAL
		if(d!=0 and d!=1){
			std::cout << "The given direction value was not 0 or 1. Try again.\n" << std::endl;
			i--;
		}
		//Uses a helper method to check if the placement is valid.
		else if(!place(row,col,dir,ships.at(i),player)){
			i--;
		}
		//If the placement is valid, the ship is placed on the board.
		else{
			//Tracks the length of the ship.
			int length = ships.at(i).getSpaces();
		
			//Places ship hoizontally or vertically.
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
			
			//Lets the player know their placement was successful.
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
		printPlayerBoard();
}

/********************************************************
 * A helper method I added to print the player's board.
 *******************************************************/
void Game::printPlayerBoard(){
	std::cout << "|-----------------------------------YOUR BOARD-----------------------------------|\n" << std::endl;
	std::cout << player << std::endl;
}

/********************************************************
 * A helper method I added to print the computer's board.
 *******************************************************/
void Game::printComputerBoard(){
	std::cout << "|---------------------------------COMPUTER BOARD---------------------------------|\n" << std::endl;
	std::cout << computer << std::endl;
}


/********************************************************
 * Places the computer's ships and ensures
 * no errors occur.
 *******************************************************/
void Game::placeShipsPC(){

	//Tracks neccessary information about ship placement.
	//This includes coordinates, direction, and ship length.
	int row = -1;
	int col = -1;
	int d = -1;
	Direction dir;
	int length = -1;

	//Loops through every ship in BATTLESHIP.
	for(int i = 0; i<ships.size();i++){
		
		length = ships.at(i).getSpaces();

		//Uses a helper method I added to
		//get a random integer. In this case,
		//0 or 1 for horizontal or vertical.
		d = getRandomInt(0,1);

		if(d==0){
			dir = HORIZONTAL;
		}
		else{
			dir = VERTICAL;
		}
		
		//Depending on the ship's direction,
		//random row and column values are found.
		//Ship length is taken into account.
		if(dir==HORIZONTAL){
			row = getRandomInt(0, HEIGHT-1);
			col = getRandomInt(0, (WIDTH - 1)-length);
		}
		else{
			row = getRandomInt(0, (HEIGHT-1)-length);
			col = getRandomInt(0, WIDTH-1);
		}
		
		//Checks if the placement is valid.
		if(!place(row,col,dir,ships.at(i),computer)){
			i--;
		}
		//If so, the ship is placed.
		else{
			//Placement changes depending on direction.
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

	printComputerBoard();
}


/********************************************************
 * A helper method I added to get a random integer.
 * This should be from a uniform disribtuion and comes
 * from the C++ random library.
 *
 * @param minVal, maxVal. Values to find random integer
 * in between (and including).
 * @return a random integer in between (and including)
 * the minimum and maximum value.
 *******************************************************/
int Game::getRandomInt(int minVal, int maxVal) {
	std::random_device rand_dev;
	std::mt19937 generator(rand_dev());
	std::uniform_int_distribution<int> distr(minVal, maxVal);
	return distr(generator);
}

/********************************************************
 * A helper method to find if a ships' placement will
 * be valid.
 *
 * @param x,y,d,s,b. Coordinates, direction, ship,
 * and board are needed to determing if placement is
 * valid.
 * @return bool. True or false if placement of ship
 * is valid or not.
 *******************************************************/
bool Game::place(const int& x, const int& y, Direction d, const Ship& s, Board& b){
	
	//Finds ship length and determines the last
	//row and column the ship will need.
	int length = s.getSpaces();
	int endRow = x + length;
	int endCol = y + length;

	//Checks if row is valid.
	if(x < 0 or x>=HEIGHT){
		std::cout << "The given row value is outside of the bounds of the board. Try again.\n" << std::endl;
		return false;
	}
	//Checks if column is valid.
	else if(y < 0 or y>=WIDTH){
		std::cout << "The given column value is outside of the bounds of the board. Try again.\n" << std::endl;
		return false;
	}


	//Tries to place the ship depending on direction.
	if(d == HORIZONTAL){

		//Makes sure ship can be placed within bounds.
		if(endCol>WIDTH){
			std::cout << "This direction would place the ship outside of the bounds of the board. Try again.\n" << std::endl;
			return false;
		}
		//Makes sure ship will not intersect with another ship.
		for(int i = y; i<endCol; i++){
			if(b[x][i] != EMPTY){
				//Only the player should see this error message for their ship placement, not the computer.
				if(!(b<player) && !(player<b)){
					std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				}
				return false;
			}
		}
	}
	else{
		//Makes sure ship can be placed within bounds.
		if(endRow>HEIGHT){
			std::cout << "This direction would place the ship outside of the bounds of the board. Try again.\n" << std::endl;
			return false;
		}
		//Makes sure ship will not intersect with another ship.
		for(int i = x; i<endRow; i++){
			if(b[i][y] != EMPTY){
				//Only the player should see this error message for ship placement.
				if(!(b<player) && !(player<b)){
					std::cout << "The coordinates you selected intersect with another ship. Try again.\n" << std::endl;
				}
				return false;
			}
		}
		
	}

	return true;
}


/********************************************************
 * A helper method I added to find the number of ships
 * the player has left.
 *
 * @return number of ships the player has left.
 *******************************************************/
int Game::getPlayerShipCount(){
	int count = playerShips.size();
	
	//Loops through all of the player's ships.
	for(int i = 0; i<playerShips.size();i++){

		//Subtracts ships that are sunk.
		if(playerShips.at(i).getHits() == playerShips.at(i).getSpaces()){
			count --;
		}
	}
	return count;
}

/********************************************************
 * A helper method I added to find the number of ships
 * the computer has left.
 *
 * @return number of ships the computer has left.
 *******************************************************/
int Game::getComputerShipCount(){
	int count = computerShips.size();

	//Loops through all of the computer's ships.
	for(int i = 0; i<computerShips.size();i++){
		
		//Subtracts ships that are sunk from count.
		if(computerShips.at(i).getHits() == computerShips.at(i).getSpaces()){
			count --;
		}
	}
	return count;
}

/********************************************************
 * A helper method I added to print the current score
 * of the game
 *
 * @param turncount, p, c, playerTurn. To accurately
 * print the current state of the game the method needs
 * to know what turn it is, the infor from both boards,
 * and if it is currently the player's turn.
 *******************************************************/
void Game::printScore(int turnCount, Board p, Board c, bool playerTurn){
	
	//Prints the top of the score board.
	std::cout<<"\nPLAYER VS. THE ADMIRAL" << std::endl;
	std::cout << "--------------------------"<<std::endl;
	
	//Prints what turn it is and whose turn it is.
	if(playerTurn){
		std::cout << "ROUND " << turnCount+1 << " - PLAYER'S TURN" << std::endl;
	}
	else{
		std::cout << "ROUND " << turnCount+1 << " - ADMIRAL'S TURN" << std::endl; 
	}

	//Prints how many ship spaces the player and computer have left.
	std::cout << "--------------------------"<<std::endl;
	std::cout << p.count() << "HP VS. " << c.count() << "HP" << std::endl;
	std::cout << "--------------------------"<<std::endl;

	//Prints the number of ships each player has left.
	std::cout << getPlayerShipCount() << " SHIPS VS. " << getComputerShipCount() << " SHIPS" << std::endl;	

	//Prints the state of the game (i.e. who is winning).
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

/********************************************************
 * The main logic of the game. Alternates between
 * human and computer turns until someone wins.
 *******************************************************/
void Game::run(){

	//Counts the number of turns of the game so far.
	int turnCount = 0;

	//As long as the player has at least one ship left, the game will continue.
	while(player.count()!=0){

		printScore(turnCount, player, computer, true);

		humanTurn();

		printScore(turnCount, player, computer, false);

		//If the player beats the computer, the game ends.
		if(computer.count()==0){
			std::cout << "You beat The ADMIRAL! Congratulations!" << std::endl;
			return;
		}
		

		computerTurn();

		printPlayerBoard();
		
		printComputerBoard();

		turnCount++;
   	}

	//If the while loop is exited, the player has lost.
	printScore(turnCount, player, computer, true);

	std::cout << "THE ADMIRAL wins!" << std::endl;
	return;
}

/********************************************************
 * Simulates the player's turn.
 * Input is needed to know which coordinate to attack,
 * so it must be validated.
 *******************************************************/
void Game::humanTurn(){

	//Used for input validation.
	std::string inputRow;
	std::string inputCol;

	//Used to check if a valid coordinate has been found.
	bool finished = false;

	//The coordinate used for the attack.
	int row;
	int col;

	//Exits once a proper coordinate is found.
	while(!finished){

		//Row and column values must be input be the user.
		row = -100;
		col = -100;

		//Asks player for row and column values.
		std::cout<<"Where would you like to shoot?"<<std::endl;
		std::cout << "Row: ";
		std::cin  >> inputRow;
		std::cout << "Column: ";
		std::cin  >> inputCol;
		

		//Validates row input.
		for(char c : inputRow){
			if(!isdigit(c)){
				row = -1;
			}
		}
		if(row != -1){
			row = stoi(inputRow);
		}

		//Validates column input.
		for(char c : inputCol){
			if(!isdigit(c)){
				col = -1;
			}
		}
		if(col != -1){
			col = stoi(inputCol);
		}

		//Checks if row is within the bounds of the board.
		if(row < 0 or row>=HEIGHT){
			std::cout << "\nThe given row value is outside of the bounds of the board. Try again.\n" << std::endl;
		}
		//Checks if the column is within the bounds of the board.
		else if(col < 0 or col>=WIDTH){
			std::cout << "\nThe given column value is outside of the bounds of the board. Try again.\n" << std::endl;
		}
		//Checks to make sure the player hasn't already chosen this coordinate before.
		else if(computer[row][col] != HIT and computer[row][col] != MISS){
			
			//Lets the user know there coordinate was acceptable.
			std::cout << "\nYou shot at (" << row << "," << col << ")." << std::endl;
			
			//If the spot the player shot is empty, they missed.
			if(computer[row][col] == EMPTY){
				computer[row][col] = MISS;
				std::cout << "You missed!" << std::endl;
			}
			//Otherwise, they hit a ship.
			else{
				//This conditional structure finds the ship that was hit and
				//adds a hit onto the proper ship. It is possible the player
				//may sink a ship.
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

			//The turn is finished once a spot on the computer's board has been hit.
			finished = true;
		}

		//The player has already shot at this coordinate, so they must choose a new one.
		else{
			std::cout << "\nYou have already shot there. Try somwehere else.\n" << std::endl;
		}
	}

}

/********************************************************
 * Used to simulate the computer's turn. The computer
 * will choose a coordinate randomly.
 *******************************************************/
void Game::computerTurn(){

	//Tracks if the computer is finished with their turn.
	bool finished = false;

	//Tracks the random coordinate.
	int row = -1;
	int col = -1;

	//Exits this while loop once a spot on the player's board has been hit.
	while(!finished){

		//Uses helper method to get random coordinate from a uniform distribution.
		row = getRandomInt(0, HEIGHT-1);
		col = getRandomInt(0, WIDTH-1);
		
		//If this coordinate hasn't been randomly selected before, it is either a hit or a miss.
		if(player[row][col] != HIT and player[row][col] != MISS){
			
			//Lets the player know where the computer shot at.
			std::cout<<"THE ADMIRAL shoots at (" << row << "," << col << ")."  << std::endl;
			
			//If the computer missed, they player is notified.
			if(player[row][col] == EMPTY){
			
				player[row][col] = MISS;
				std::cout << "THE ADMIRAL missed!\n" << std::endl;
			}
			//Otherwise, a ship was hit on the player's board.
			else{

				//This conditional strucutre will notify the player which
				//of their ships was hit and if any ships were sunk.
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

			//The computer's turn is finished.
			finished = true;
		}
	}
}

/********************************************************
 * Creates the game and begins it.
 *
 * @ param argc, argv. Normal parameters for a main
 * function.
 * @return 0
 *******************************************************/
int main(int argc, char** argv){
	(void)argc;
	(void)argv;
	Game g;
	g.beginGame();

	return 0;
}
