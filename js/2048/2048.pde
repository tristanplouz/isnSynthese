int [][]tab = new int [4][4];
int alI, alJ;
int score;
int []colorBank = new int [11];
int victoire=2048;
boolean moved=false;
boolean full=false;
int screen=0;//0:accueil;1:Jeu

void setup() {
  size(900, 600);
  textAlign(CENTER, CENTER);
  init();
}

void draw() {
  background(0);
  if(screen==0){
    home();
  }
  else if (screen==1) {
    game();
  }
}

void draw_digits() {
  rectMode(CENTER);
  background(120);
  fill(0);
  text(score, height-10, 100);
  for (int j=0; j<tab.length; j++) {
    for (int i=0; i<tab.length; i++) {
      setColor(j, i);
      rect(100+100*i+i*10, 100+100*j+j*10, 100, 100, 50);
      fill(0);
      text(tab[j][i], 100+100*i+i*10, 100+100*j+j*10);
    }
  }
  text(score, height-100, width-100);
}
void checkVictory() {
  full=true;
  for (int i =0; i<tab.length; i++) {
    if (max(tab[i])==victoire) {
      textSize(200);
      fill(255, 0, 0);
      text("Victoire", width/2, height/2);
      noLoop();
    }
    for (int j=0; j<tab[i].length; j++) {
      if (tab[i][j]==0) {
        full=false;
      }
    }
  }
}
void setColor(int a, int b) {
  switch (tab[a][b]) {
  case 2:
    fill(colorBank[0]);
    break;
  case 4:
    fill(colorBank[1]);
    break;
  case 8:
    fill(colorBank[2]);
    break;
  case 16:
    fill(colorBank[3]);
    break;
  case 32:
    fill(colorBank[4]);
    break;
  case 64:
    fill(colorBank[5]);
    break;
  case 128: 
    fill(colorBank[6]);
    break;
  case 256:
    fill(colorBank[7]);
    break;
  case 512:
    fill(colorBank[8]);
    break;
  case 1024:
    fill(colorBank[9]);
    break;
  case 2048:
    fill(colorBank[10]);
    break;
  default:
    fill(120);
    break;
  }
}
void decal_a_gauche() {
  for (int j =0; j<tab.length; j++) {
    for (int i =1; i<tab.length; i++) {      // Déplacer tout d'un case à gauche
      if (tab[j][i-1]==0) {
        tab[j][i-1]=tab[j][i];
        tab[j][i]=0;
        moved=true;
      }
    }
  }
}

void decal_en_haut() {
  for (int i =0; i<tab.length; i++) {
    for (int j =1; j<tab.length; j++) {      // Déplacer tout d'un case à gauche
      if (tab[j-1][i]==0) {
        tab[j-1][i]=tab[j][i];
        tab[j][i]=0;
        moved=true;
      }
    }
  }
}

void decal_a_droite() {
  for (int j=0; j<tab.length; j++) {
    for (int i =tab.length-1; i>0; i--) {
      if (tab[j][i]==0) {
        tab[j][i]=tab[j][i-1];
        tab[j][i-1]=0;
        moved=true;
      }
    }
  }
}
void decal_en_bas() {
  for (int i=0; i<tab.length; i++) {
    for (int j =tab.length-1; j>0; j--) {
      if (tab[j][i]==0) {
        tab[j][i]=tab[j-1][i];
        tab[j-1][i]=0;
        moved=true;
      }
    }
  }
}
void fusion_a_gauche() {
  for (int j=0; j<tab.length; j++) {
    for (int i =1; i<tab.length; i++) {
      if (tab[j][i-1]==tab[j][i]) {
        tab[j][i-1]=tab[j][i-1]+tab[j][i];
        tab[j][i]=0;
        score+=tab[j][i-1];
      }
    }
  }
}
void fusion_en_haut() {
  for (int i=0; i<tab.length; i++) {
    for (int j =1; j<tab.length; j++) {
      if (tab[j-1][i]==tab[j][i]) {
        tab[j-1][i]=tab[j-1][i]+tab[j][i];
        tab[j][i]=0;
        score+=tab[j-1][i];
      }
    }
  }
}
void fusion_a_droite() {  
  for (int j=0; j<tab.length; j++) {
    for (int i =tab.length-1; i>0; i--) {
      if (tab[j][i]==tab[j][i-1]) {
        tab[j][i]=tab[j][i]+tab[j][i-1];
        tab[j][i-1]=0;
        score+=tab[j][i];
      }
    }
  }
}
void fusion_en_bas() {  
  for (int i=0; i<tab.length; i++) {
    for (int j =tab.length-1; j>0; j--) {
      if (tab[j][i]==tab[j-1][i]) {
        tab[j][i]=tab[j][i]+tab[j-1][i];
        tab[j-1][i]=0;
      }
    }
  }
}
void init() {
  do {
    alI=int(random(tab.length));
    alJ=int(random(tab.length));
  } while (tab[alJ][alI] !=0);
  if (int(random(100))>50) {
    tab[alJ][alI] = 4;
  } else {
    tab[alJ][alI] = 2;
  }
  for (int i =0; i< colorBank.length; i++) {
    colorBank[i] = color(random(10, 245), random(10, 245), random(10, 245));
  }
  score=0;
}
void keyPressed() {
  if (key==CODED) {
    if (keyCode==LEFT) {
      for (int x=0; x<tab.length-1; x++) {
        decal_a_gauche();
        if (x==1) {
          fusion_a_gauche();
        }
      }
    }
    if (keyCode==UP) {
      for (int x=0; x<tab.length-1; x++) {
        decal_en_haut();
        if (x==1) {
          fusion_en_haut();
        }
      }
    }
    if (keyCode==RIGHT) {
      for (int x=0; x<tab.length-1; x++) {
        decal_a_droite();
        if (x==1) {
          fusion_a_droite();
        }
      }
    }
    if (keyCode==DOWN) {
      for (int x=0; x<tab.length-1; x++) {
        decal_en_bas();
        if (x==1) {
          fusion_en_bas();
        }
      }
    }
    if (moved) {
      Placer_un_chiffre();
    }
  }
}

void Placer_un_chiffre() {
  do {
    alI=int(random(tab.length));
    alJ=int(random(tab.length));
  } while (tab[alJ][alI] !=0);
  if (int(random(100))>75) {
    tab[alJ][alI] = 4;
  } else {
    tab[alJ][alI] = 2;
  }
  moved=false;
}
void home(){
  textSize(40);
  background(240);
  if (button(width/2-width/6, height/5, width/3, height/10,#293268)) {
    screen=1;
  }
  fill(0);
  text("Jouer",width/2, height/5+height/20);
}

void game(){
    textSize(40);

    draw_digits();
    checkVictory();
    if(button(2*width/3-10,4*height/5, width/3, height/10,colorBank[10])){
      screen=0;
    }
    fill(0);
    text("Accueil",2*width/3+width/6,4*height/5+height/20);
}
boolean button(int x, int y, int L, int l,color couleur) {
  rectMode(CORNER);
  if (mouseX> x && mouseX<x+L && mouseY>y && mouseY<y+l) {
    fill(50);
    if (mousePressed) {
      return true;
    }
  }
  fill(couleur);
  rect(x, y, L, l, 50, 50, 50, 50);
  return false;
}

