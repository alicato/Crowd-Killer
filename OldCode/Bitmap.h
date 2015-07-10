#ifndef BITMAP_H
#define BITMAP_H

#include <winbgim.h>
#include <cstdio>
#include <iostream>

typedef struct pixel
{
    unsigned char bleu;
    unsigned char vert;
    unsigned char rouge;
    unsigned char alpha;
}pix;

typedef struct sprite
{
    unsigned int larg;
    unsigned int haut;
    pix * image;
}spr;

spr * LoadBMP(std::string);
void dsp_sprite(spr*,int,int);

#endif
