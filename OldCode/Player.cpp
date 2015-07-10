#include "../include/Player.h"

Player::Player(){}

Player::Player(bool p1){
    if (p1) {
        up = VK_UP;
        down = VK_DOWN;
        left = VK_LEFT;
        right = VK_RIGHT;
    } else {
        up = 'Z';
        down = 'S';
        left = 'Q';
        right = 'D';
    }
}

Player::~Player(){}

Player::Player(const Player& other) : Person(other){}

Player& Player::operator=(const Player& rhs)
{
    if (this == &rhs) return *this;
    return *this;
}

void    Player::move() {
    SYSTEMTIME st;
    FILETIME actual;
    GetSystemTime(&st);
    SystemTimeToFileTime(&st,&actual);
    if (actual.dwHighDateTime == this->lastmove.dwHighDateTime &&
            actual.dwLowDateTime - this->lastmove.dwLowDateTime < 300000)
        return;
    setfillstyle(SOLID_FILL, getmaxcolor());
    bar(xpos,ypos,xpos + CHARACTER_W + 1, ypos + CHARACTER_H + 1);
    if (GetKeyState(this->up) & 0x8000 && this->ypos > 0)
        this->ypos -= 1;
    if (GetKeyState(this->down) & 0x8000 && this->ypos < (W_H - CHARACTER_H - 12))
        this->ypos += 1;
    if (GetKeyState(this->left) & 0x8000 && this->xpos > 0)
        this->xpos -= 1;
    if (GetKeyState(this->right) & 0x8000 && this->xpos < (W_W - CHARACTER_W - 9))
        this->xpos += 1;
    this->display();
    this->lastmove = actual;
}
