#include "terminal.hpp"
#include "string.hpp"

Terminal::Terminal()
{
    p = (Terminalpointer)TERMINAL_ADDRESS;
    color = COLOR(Color::White,Color::Black);
    for(size y = 0;y < TERMINAL_HEIGHT;y++)
        for(size x = 0;x < TERMINAL_WIDTH;x++)
            setCharacter(' ',color,x,y);
}

void Terminal::setCharacter(char c,u8 color,size x,size y)
{
    if(c == '\n')
    {
        row++;
        column = 0;
        return;
    }
    size pos = y * TERMINAL_WIDTH + x;
    p[pos] = (u16)c | (u16)color << 8;
}

void Terminal::setCharacter(char c)
{
    setCharacter(c,color,column,row);
    if(++column == TERMINAL_WIDTH)
    {
        column = 0;
        if(++row == TERMINAL_HEIGHT)
            row = 0;
    }
}

void Terminal::writeData(cstr str)
{
    writeData(str,strlen(str));
}

void Terminal::writeData(cstr str,size length)
{
    for(size i = 0;i < length;i++)
        setCharacter(str[i]);
}