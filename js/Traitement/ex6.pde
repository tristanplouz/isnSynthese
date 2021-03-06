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
      
      
      rouge = red(img.pixels [loc])/2;
      vert = green(img.pixels[loc])/2;
      bleu = blue(img.pixels[loc])/2;
      // Déclare les couleurs d'un pixel
      
      pixels[loc] = color(rouge,vert,bleu);
    }
  }
  updatePixels();
}