#include "frame_buffer.h"
#include "port.h"

#define FB_COMMAND_PORT 0x3D4
#define FB_DATA_PORT    0x3D5

#define FB_HIGH_BYTE_COMMAND    14
#define FB_LOW_BYTE_COMMAND     15

void fb_move_cursor(unsigned short pos) {
    port_write_byte(FB_HIGH_BYTE_COMMAND, FB_COMMAND_PORT);
    port_write_byte(((pos >> 8) & 0x00FF), FB_DATA_PORT);
    port_write_byte(FB_LOW_BYTE_COMMAND, FB_COMMAND_PORT);
    port_write_byte(pos & 0x00FF, FB_DATA_PORT);
}



void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg) {
	char *video_memory = (char *)0xb8000;
	video_memory[i*2] = c;
	video_memory[i*2+1] = ((fg & 0x0f) << 4) | (bg & 0x0f);
}