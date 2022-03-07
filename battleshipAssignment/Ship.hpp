#ifndef				__HPP_SHIP__
#define				__HPP_SHIP__

#include <exception>
#include <string>

class SunkShipException : public std::exception {
	public:
		SunkShipException(const std::string& message) : _message(message){}
	private:
		std::string _message;
};

class Ship {
	public:
		Ship(int _spaces, std::string _name, int _chr) : spaces{_spaces}, name(_name), chr{_chr} { }
		int getChr() const { return chr; }
		int getSpaces() const { return spaces; }
		int getHits() const { return hits; }
		void addHit() { hits++; if(hits == spaces){ throw SunkShipException("You sank a " + name + "!"); }}
		std::string getName() const { return name; }
	private:
		int spaces;
		int hits;
		std::string name;
		int chr;

		friend std::ostream& operator<<(std::ostream& os, Ship const& s){
			os << s.name << " [" << s.spaces << " spaces]";
			return os;
		}
};

#endif
