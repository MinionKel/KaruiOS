#include "../drivers/frame_buffer.h"
// #include "../drivers/io.h"

void main() {
    // char *video_memory = (char *)0xb8000;
    // *video_memory = 'X';
    fb_move_cursor(5);
    fb_write_cell(0, 'H', WHITE, BLACK);
    fb_write_cell(1, 'L', BLACK, RED);
    fb_write_cell(2, 'L', LIGHT_BLUE, LIGHT_CYAN);
}
