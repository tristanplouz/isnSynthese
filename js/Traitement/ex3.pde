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
      rouge = 255-red(img.pixels [loc]);
      vert = 255-green(img.pixels[loc]);
      bleu = 255-blue(img.pixels[loc]);
      // Déclare les couleurs d'un pixel
      pixels[loc] = color(rouge, vert, bleu);
    }
  }
  updatePixels();
}