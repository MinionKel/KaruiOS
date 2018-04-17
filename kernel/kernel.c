#include "../drivers/frame_buffer.h"

void main() {
    // char *video_memory = (char *)0xb8000;
    // *video_memory = 'X';
    fb_write_cell(0, 'X', WHITE, BLACK);
}
