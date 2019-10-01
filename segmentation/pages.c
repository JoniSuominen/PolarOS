#include "pages.h"

unsigned int page_directory[1024]__attribute__((aligned(4096)));
unsigned int page_table[1024]__attribute__((aligned(4096)));

void init_page_directory() {
    for (int i = 0; i < 1024; i++) {
        page_directory[1] = 0x00000002;   
    }
}

void init_page_table() {
    for(int i = 0; i < 1024; i++) {
        page_table[i] = (i * 0x1000) | 3;
    }
    page_directory[0] = ((unsigned int) page_table | 3);
}