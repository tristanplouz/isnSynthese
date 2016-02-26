int largeur = 200;
int hauteur = 200;

float rand;
color couleur;
float longueur_totale = largeur*hauteur;
size(200, 200);
loadPixels();

for (int i=0; i< longueur_totale; i++)
{
  rand = dist(i%hauteur,i/hauteur,0,0)*255/dist(0,0,hauteur,largeur); 
  couleur = color(rand);
  pixels[i]=couleur;
}

updatePixels();


/*
x=i%largeur
y=i/largeur;
max=255
dist(0,0,x,y)=color
*/

