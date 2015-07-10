#ifndef PERSON_H
#define PERSON_H

#include <graphics.h>
#define CHARACTER_W 17
#define CHARACTER_H 29
#define W_W 500
#define W_H 500

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

class Person {
    public:
        Person();
        virtual ~Person();
        Person(const Person& other);
        Person& operator=(const Person& other);

        static void     *character;
        static bool     initCharacter();

        unsigned int    getxpos() { return xpos; }
        void            setxpos(unsigned int val) { xpos = val; }
        unsigned int    getypos() { return ypos; }
        void            setypos(unsigned int val) { ypos = val; }
        void            display();
        FILETIME        lastmove;

    protected:
        unsigned int    xpos;
        unsigned int    ypos;

};

#endif
