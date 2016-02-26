PImage img;
int largeur = 600;
int hauteur = 450;
float rouge, vert, bleu;

void setup() {
  size(600, 450);
  img = loadImage( "tournesol.jpg");
}

void draw() {
 loadPixels();
  img.loadPixels();
  for (int y = 0; y < hauteur; y++ ) {
    for (int x =0 ; x < largeur; x++ ) {
      int loc = x + y*largeur;
      // Récupère les composantes couleurs de chaque pixel
      
      float rand = dist(x,y,largeur/2,hauteur/2)*20/dist(0,0,hauteur,largeur); 
      rouge = red(img.pixels [loc])/rand;
      vert = green(img.pixels[loc])/rand;
      bleu = blue(img.pixels[loc])/rand;
      // Déclare les couleurs d'un pixel
      
      pixels[loc] = color(rouge,vert,bleu);
    }
  }
  updatePixels();
}