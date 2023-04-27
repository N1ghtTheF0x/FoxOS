#include "vga.hpp"

extern "C"
{
    void kernel_main(void)
    {
        VGA vga;

        vga.writeData("Hello World!");

        while(1);
    }
}