#ifndef __FRAME_BUFFER_H__
#define __FRAME_BUFFER_H__

#define BLACK           0
#define BLUE            1
#define GREEN           2
#define CYAN            3
#define RED             4
#define MAGENTA         5
#define BROWN           6
#define LIGHT_GREY      7
#define DARK_GREY       8
#define LIGHT_BLUE      9
#define LIGHT_GREEN     10
#define LIGHT_CYAN      11
#define LIGHT_RED       12
#define LIGHT_MAGENTA   13
#define LIGHT_BROWN     14
#define WHITE           15

/**
 * In frame buffer, memory is devided into 16 bit cells
 * Bit:     | 15 - 9 | 7 - 4 | 3 - 0 |
 * Content: | ASCII  | FG    | BG    |
 */
union frame_buffer_cell {
    struct {
        unsigned char ascii:8;
        unsigned char fg:4;
        unsigned char bg:4;
    } __attribute__((packed)) bits;

    unsigned short raw;
};

void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg);

#endif