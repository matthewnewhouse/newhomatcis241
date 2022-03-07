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
}

/**
 * Begin Game let's user and then computer setup boards then calls run()
 */
void Game::beginGame(){
}

/**
 * Handle the human placing ships.
 */
void Game::placeShips(){
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
}

/**
 * Call human turn/computer turn until someone wins.
 */
void Game::run(){
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