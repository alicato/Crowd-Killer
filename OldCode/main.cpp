#include <iostream>
#include <string>
#include <graphics.h>
#include <dos.h>
#include <ctime>
#include <cstdlib>
#include "include/Player.h"

int main() {
    SYSTEMTIME st;
    GetSystemTime(&st);
    char c = 0;
    bool loop;
    srand(time(NULL));
    Player p1(true);
    Player p2(false);

    initwindow(W_W, W_H, "Crowd");
    setbkcolor(getmaxcolor());
    loop = Person::initCharacter();
    while (loop) {
        if (kbhit())
            c = getch();
        p1.move();
        p2.move();
        if (GetKeyState(0x1b) & 0x8000)
            loop = false;
    //    p1.display();
    //    p2.display();
        c = 0;
    }
    free(Person::character);
    closegraph();
    return 0;
}
