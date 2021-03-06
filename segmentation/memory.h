#ifndef INCLUDE_MEMORY_H
#define INCLUDE_MEMORY_H

#include "../utils/common.h"


unsigned int kmalloc(unsigned int sz);
unsigned int kmalloc_a(unsigned int sz, int align);
unsigned int kmalloc_p(unsigned int sz, unsigned int *phys);
unsigned int kmalloc_ap(unsigned int sz, int align, unsigned int *phys);
unsigned int kmalloc_hh(unsigned int sz, int align);
void kfree(void *p);



extern void loadPageDirectory(uint32_t val);
extern void enablePaging();

#endif /** INCLUDE_MEMORY_H */