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

	private:
		Board player;
		Board computer;
		std::vector<Ship> ships;
};

#endif
