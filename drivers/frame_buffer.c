#include "frame_buffer.h"
#include "port.h"

#define FB_COMMAND_PORT 0x3D4
#define FB_DATA_PORT    0x3D5

#define FB_HIGH_BYTE_COMMAND    14
#define FB_LOW_BYTE_COMMAND     15

#define VIDEO_MEMORY_BASE       0xb8000
#define MAX_ROWS                25
#define MAX_COLS                80

static unsigned short cursor_pos;

void fb_move_cursor(unsigned short pos) {
    port_write_byte(FB_HIGH_BYTE_COMMAND, FB_COMMAND_PORT);
    port_write_byte(((pos >> 8) & 0x00FF), FB_DATA_PORT);
    port_write_byte(FB_LOW_BYTE_COMMAND, FB_COMMAND_PORT);
    port_write_byte(pos & 0x00FF, FB_DATA_PORT);
}

int fb_move_cursor_to(unsigned short row, unsigned short col) {
    unsigned short pos = row * 80 + col;
    fb_move_cursor(pos);
    return 0;
}

void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg) {
	char *video_memory = (char *)VIDEO_MEMORY_BASE;
	video_memory[i*2] = c;
	video_memory[i*2+1] = ((bg & 0x0f) << 4) | (fg & 0x0f);
}

void fb_print(char *str, unsigned int len) {
    char *head = str;
    unsigned int i;
    for (i = 0; i < len; i++) {
        fb_write_cell(cursor_pos, *(head+i), WHITE, BLACK);
        cursor_pos += 1;
        fb_move_cursor(cursor_pos);
    }
}

void clear_screen() {
    unsigned int i;
    for (i = 0; i < MAX_ROWS * MAX_COLS; i++) {
        fb_write_cell(i, ' ', WHITE, BLACK);
    }
}

void init_framebuffer() {
    cursor_pos = 0;
    clear_screen();
    fb_move_cursor(0);
}