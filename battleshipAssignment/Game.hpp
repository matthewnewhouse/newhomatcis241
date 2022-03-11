#ifndef				__HPP_GAME__
#define				__HPP_GAME__

#include "Board.hpp"
#include "Direction.hpp"
#include "Ship.hpp"
#include <vector>

class Game {
	public:
		Game();
		void hello();
		void placeShips();
		void placeShipsPC();
		void beginGame();
		void run();
		void humanTurn();
		void computerTurn();
		bool place(const int& x, const int& y, Direction d, const Ship& s, Board& b);
		
		//Helper methods I added.
		void printPlayerBoard();
		void printComputerBoard();
		int getPlayerShipCount();
		int getComputerShipCount();
		int getRandomInt(int from, int to);
		void printScore(int turnCount, Board p, Board c, bool playerTurn);

	private:
		Board player;
		Board computer;
		std::vector<Ship> ships;

		//Extra variables to keep track of the player's and computer's ships.
		std::vector<Ship> playerShips{};
		std::vector<Ship> computerShips{};
};

#endif
