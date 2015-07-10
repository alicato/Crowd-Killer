#include "../include/Bitmap.h"

void dsp_sprite(spr * sprite,int posx, int posy)
{
    unsigned int x,y,nbpix;

    nbpix=0;
    for(y=0;y<sprite->haut;y++) {
         for(x=0;x<sprite->larg;x++) {
                 putpixel(x+posx,sprite->haut-1-y+posy,COLOR(sprite->image[nbpix].rouge,sprite->image[nbpix].vert,sprite->image[nbpix].bleu));
                 nbpix++;
         }
     }
}

spr * LoadBMP(std::string name)
{
    FILE *bmp;
    spr * sprite;
    unsigned short int offset,type;

    bmp=fopen(name.c_str(),"rb");
    if (bmp!=NULL) {
      sprite=(spr*)malloc(sizeof(spr));
      if (sprite!=NULL) {
         fread(&type,sizeof(unsigned short int),1,bmp); //Vérification de la signature
         if (type==19778) {
            fseek(bmp,10,SEEK_SET);
            fread(&offset,sizeof(unsigned short int),1,bmp); //Adresse de l'information image
            fseek(bmp,18,SEEK_SET);
            fread(&sprite->larg,sizeof(unsigned int),2,bmp); //Récupération des dimensions
            fseek(bmp,offset,SEEK_SET);
            sprite->image=(pix*)malloc(sprite->haut*sprite->larg*sizeof(pix));
            fread(sprite->image,sprite->haut*sprite->larg*sizeof(pix),1,bmp);
          } else {
            std::cout<< "Image invalide" <<std::endl;
            free(sprite);
            exit(0);
          }
      } else {
            std::cout<< "Erreur d'allocation mémoire" <<std::endl;
            exit(0);
      }
    } else {
        std::cout<< "Fichier introuvable" <<std::endl;
        exit(0);
    }
    fclose(bmp);
    return(sprite);
}
