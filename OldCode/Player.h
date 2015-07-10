#ifndef PLAYER_H
#define PLAYER_H

#include "Person.h"
#include <winuser.h>
#include <iostream>


class Player : public Person
{
    public:
        Player();
        Player(bool p1);
        ~Player();
        Player(const Player& other);
        Player&     operator=(const Player& other);
        void        move();

        char            getup() { return up; }
        void            setup(char val) { up = val; }
        char            getdown() { return down; }
        void            setdown(char val) { down = val; }
        char            getleft() { return left; }
        void            setleft(char val) { left = val; }
        char            getright() { return right; }
        void            setright(char val) { right = val; }
    private:
        char    up;
        char    down;
        char    left;
        char    right;
};

#endif
