#ifndef TERMINAL_HPP
#define TERMINAL_HPP

#include "colors.hpp"

typedef u16* Terminalpointer;

#define TERMINAL_ADDRESS 0xB8000
#define TERMINAL_WIDTH 80
#define TERMINAL_HEIGHT 25

class Terminal
{
private:
    Terminalpointer p;
    size row;
    size column;
    u8 color;
public:
    Terminal();
    void setCharacter(char c,u8 color,size x,size y);
    void setCharacter(char c);
    void writeData(cstr data,size length);
    void writeData(cstr data);
};

#endif