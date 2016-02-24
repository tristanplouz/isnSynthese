PImage img;
PImage ASTERIX_ARRET;
PImage ASTERIX_DROITE[] = new PImage[4];
PImage ASTERIX_GAUCHE[] = new PImage[4];
int i=0, dist=0,jump=0;
void setup() {
  size(300, 200);
  frameRate(27);
  // ASTERIX_ARRET : image d'Astérix à l'arrêt
  ASTERIX_ARRET = loadImage("asterix_arretD.png");
  /* ASTERIX_DROITE est un tableau de 4 images
   nécessaires à l'animation faisant marcher
   Astérix vers la droite. */
   img=ASTERIX_ARRET;
  for (int j = 0; j<4; j++) {
    String nom_fichier = "asterix_droite_"+j+".png";
    ASTERIX_DROITE[j]=loadImage(nom_fichier);
  }
  for (int j = 0; j<4; j++) {
    String nom_fichier = "asterix_gauche_"+j+".png";
    ASTERIX_GAUCHE[j]=loadImage(nom_fichier);
  }
}

void draw() {
  background(#5256FF);
  if (keyPressed) {
    if (key==CODED) {
      if (keyCode==LEFT) {
        int indice=0;
        i=(i+1);
        indice = i/7;
        if (i>=27) i=0;
        img = ASTERIX_GAUCHE[indice];
        dist--;
        if (dist<0 )dist=300;
      }
      if (keyCode==RIGHT) {
        int indice=0;
        i=(i+1);
        indice = i/7;
        if (i>=27) i=0;
        img = ASTERIX_DROITE[indice];
        dist++;
        if (dist>300)dist=0;
      }
      if (keyCode==UP) {
        jump+=10;
        dist++;
      }
    }
  } else {
    img=ASTERIX_ARRET;
  }
  if(jump>0)jump--;
  image(img, dist, height-(img.height)-jump);
}

