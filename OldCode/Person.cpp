#include "../include/Person.h"

spr * LoadBMP(std::string);
void dsp_sprite(spr*,int,int);

Person::Person() {
    this->xpos = rand() % (W_W - CHARACTER_W);
    this->ypos = rand() % (W_H - CHARACTER_H);
    SYSTEMTIME st;
    GetSystemTime(&st);
    SystemTimeToFileTime(&st,&this->lastmove);
}

Person::~Person() {}

Person::Person(const Person& other) {*this = other;}

Person& Person::operator=(const Person& rhs) {
    if (this == &rhs) return *this;
    return *this;
}

bool Person::initCharacter() {
    spr * file;
    file = LoadBMP("img/basicCharacter.bmp");
    if (file != NULL)
        dsp_sprite(file,0,0);
    free(file->image);
    free(file);
    if ((character = malloc(imagesize(0,0,CHARACTER_W,CHARACTER_H))) == NULL)
        return false;
    getimage(0,0,CHARACTER_W - 1,CHARACTER_H - 1, Person::character);
    file = LoadBMP("img/swordSlash.bmp");
    if (file != NULL)
        dsp_sprite(file,0,0);
    free(file->image);
    free(file);
    getch();
    cleardevice();
    return true;
}

void    Person::display() {
    putimage(this->xpos, this->ypos, Person::character, AND_PUT);
}

void *Person::character = NULL;
