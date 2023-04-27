#ifndef STRING_HPP
#define STRING_HPP

#include "types.hpp"

size strlen(cstr str);

class String
{
private:
    char* buffer;
public:
    String(char* buffer);
    String(cstr string);
    operator cstr();
    size length();
};

#endif