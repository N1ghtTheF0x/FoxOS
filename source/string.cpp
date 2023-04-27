#include "string.hpp"

size strlen(cstr str)
{
    size len = 0;
    while (str[len]) len++;
    return len;
}

String::String(char* b): buffer(b)
{

}
String::String(cstr str): buffer((char*)str)
{

}
String::operator cstr()
{
    return buffer;
}
size String::length()
{
    return strlen(*this);
}