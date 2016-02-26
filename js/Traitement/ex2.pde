int largeur = 200;
int hauteur = 200;

float rand;
color couleur;
float longueur_totale = largeur*hauteur;
size(200, 200);
loadPixels();

for (int i=0; i< longueur_totale; i++)
{
  rand = dist(i%hauteur,i/hauteur,width/2,height/2)*255/dist(width/2,height/2,hauteur,largeur); 
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

