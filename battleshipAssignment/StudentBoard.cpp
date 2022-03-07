#include "Board.hpp"
#include "BoardValues.hpp"

#include <algorithm>
#include <iostream>

Board::Board(){
}

Board::Board(const Board& other){
}

Board& Board::operator=(const Board& other){
}

Board::~Board(){
}

void Board::setVisible(bool v){
}

int& Board::Internal::operator[](int index){
}

Board::Internal Board::operator[](int index){
}

std::ostream& operator<<(std::ostream& os, Board const& b){
}

int Board::count() const{
}

bool Board::operator< (const Board& other){
}