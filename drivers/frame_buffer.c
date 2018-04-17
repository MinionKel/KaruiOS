#include "frame_buffer.h"

void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg) {
	char *video_memory = (char *)0xb8000;
	video_memory[i] = c;
	video_memory[i+1] = ((fg & 0x0f) << 4) | (bg & 0x0f);
}