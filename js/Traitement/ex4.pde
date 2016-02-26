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
    for (int x = 0; x < largeur; x++ ) {
      int loc = x + y*largeur;
      // Récupère les composantes couleurs de chaque pixel
      rouge = red(img.pixels [loc]);
      vert = green(img.pixels[loc]);
      bleu = blue(img.pixels[loc]);
      // Déclare les couleurs d'un pixel
      float grey = (rouge+vert+bleu)/3; 
      pixels[loc] = color(grey);
    }
  }
  updatePixels();
}