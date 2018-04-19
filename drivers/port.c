#include "port.h"

void port_write_byte(unsigned char byte, unsigned short port) {
    __asm__("out %%al, %%dx": : "a" (byte), "d" (port));
}