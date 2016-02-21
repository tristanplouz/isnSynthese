/*********************************************************************
 *                ISN à La Pérouse - Kerichen                        *
 * ******************************************************************* 
 *                             PONG                                  *
 *     Nom, prénom : DRUSSEL Tristan, TS1                            *
 *     Lycée : Vauban                                                *
 *     Version de Processing: 3.0                                    *  
 *     Librairie: minim                                              *
 *********************************************************************/
/*|-------------------------+-----------+-----+-------+-------------| 
 *| Critère                 | Excellent | Bon | Moyen | Insuffisant | 
 *|-------------------------+-----------+-----+-------+-------------| 
 *| Respect des bons usages |           |     |       |             | 
 *|-------------------------+-----------+-----+-------+-------------| 
 *| Correction du code      |           |     |       |             | 
 *|-------------------------+-----------+-----+-------+-------------| 
 *| Interface utilisateur   |           |     |       |             | 
 *|-------------------------+-----------+-----+-------+-------------| 
 *|-----------------------------------------------------------------| 
 *| Commentaires :                                                  |
 *|                                                                 |
 *|                                                                 |
 *|                                                                 |
 *|                                                                 |
 *|                                                                 |
 *|                                                                 |
 *|                                                                 |
 *|-----------------------------------------------------------------| 
 */

//Definition des variables Accueil
int centerButton;
int screen=0; //Variable pour les differents ecrans(0: Accueil; 
//1: Jeu; 2:HighScore; 3:Credits)

//Definition des variables Jeu
int xBall, yBall, tBall;
float vX;
float vY;
int rebond=0;
int [] score= {0, 0};
boolean perdu = false;
int[]couleurBall = {0, 0, 255};

//Definition des variables multijoueurs
boolean [] clavier = new boolean [255]; //CF keyboard
int xPaD, yPaD, xPaG, yPaG, padl, paGL, paDL;
boolean multi;

//highscore
int highscoreSolo;
PrintWriter highscoreWrite;
BufferedReader highscoreRead; 
String highscoreEver;

void setup() {

  size(750,800);
  centerButton=(width/2)-(width/3)/2;
  textAlign(CENTER, CENTER);

  rebondS = minim.loadFile("data/rebond.wav");
  popS = minim.loadFile("data/pop.mp3");
  perduS = minim.loadFile("data/end.mp3");
}

void draw() {

  if (screen==0) {
    homeScreen();
    if (highscoreSolo<=score[0]) {
      highscoreSolo=score[0];
      if (getHighscore()<highscoreSolo) {
        putHighscore();
      }
    }
    reset();
  } else if (screen==1) {
    multi=false;
    paGL=height/2;
    if (abs(vX)< 1 || abs(vY)<1) {
      vX= random(-2, 2) ;
      vY= random(-2, 2) ;
    } else {
      playScreenSolo();
    }
  } else if (screen==2) {
    multi=true;
    playScreenMulti();
  } else if (screen==3) {
    highscore();
  } else if (screen==4) {
    credits();
  }
}

void stop() {
  highscoreWrite.close();
} 

/********************************************************
 *Fonction gerant les boutons                            *
 *********************************************************/

boolean button(int x, int y, int L, int l) {
  if (mouseX> x && mouseX<x+L && mouseY>y && mouseY<y+l) {
    fill(50);
    if (mousePressed) {
      return true;
    }
  }
  rect(x, y, L, l, 50, 50, 50, 50);
  return false;
}

/********************************************************
 *Fonction gerant le reset des variables de jeu         *
 *********************************************************/

void reset() {
  xBall=width/2;
  yBall=height/2;
  tBall=50;
  vX= random(-2, 2) ;
  vY= random(-2, 2) ;
  xPaD=width/9;
  yPaD=yPaG=height/2;
  xPaG=width*8/9;
  padl=10;
  paGL=paDL=height/5;
  perdu=false;
  rebond=0;
  score[0]=0;
  score[1]=0;
}

/********************************************************
 *Fonction gerant l'ecran credits                       *
 ********************************************************/
void credits() {
  background(255);
  fill(0);
  textSize(70);
  text("Pong", width/2, height/8);
  textSize(20);
  fill(30);
  text("Developé par Tristan Drussel\nen cours d'ISN\nSon par"+
    " soundjax.com et universal-soundbank.com", width/2, 2*height/8);

  textSize(10);
  text("LGPL,2015", width/2, 7.5*height/8);
  if (button(5*width/6, 5*height/6, width/10, height/20)) {
    screen=0;
  }
  fill(255);
  textSize(20);
  text("Menu", 5*width/6+width/20, 5*height/6+height/40);
}

/********************************************************
 *Fonctions l'ecran des highscores                      *
 *********************************************************/

void highscore() {
  background(0);
  fill(255);
  text("Meilleur score solo de la session: \n"+
    highscoreSolo, width/2, 2*height/5);
  text("Meilleur score solo de la vie: \n"+ 
    getHighscore(), width/2, 3*height/5);

  if (button(3*width/4, 3*height/5, width/5, height/10)) {
    screen=0;
  }
  fill(0);
  text("Menu", 3*width/4+width/10, 3*height/5+height/20);
}

int getHighscore() {
  highscoreRead = createReader("highscore.txt"); 
  try {
    highscoreEver = highscoreRead.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    highscoreEver = null;
  }
  if (highscoreEver!=null) {
    return int(highscoreEver);
  }
  return 0;
}

/********************************************************
 *Fonctions le fichier des highscores                   *
 *********************************************************/
void putHighscore() {
  highscoreWrite = createWriter("highscore.txt");
  highscoreWrite.println(highscoreSolo);
  highscoreWrite.flush();
  highscoreWrite.close();
}

/********************************************************
 *Fonction gérant l'écran d'accueil                      *
 *********************************************************/

void homeScreen() {
  textSize(40);
  background(240);
  fill(#293268);
  if (button(centerButton, height/5, width/3, height/10)) {
    screen=1;
  }
  fill(30);
  text("Jouer solo", centerButton+width/6, height/5+height/20);

  fill(#722a58);
  if (button(centerButton, 2*height/5, width/3, height/10)) {
    screen=2;
  }
  fill(30);
  text("Jouer multijoueur", centerButton+width/6, 
    2*height/5+height/20);

  fill(#2d8f50);
  if (button((width/2)-(width/3)/2, 3*height/5, 
    width/6-10, height/10)) {
    screen=3;
  }
  fill(30);
  text("Highscore", (width/2)-(width/6)+width/12-10, 
    3*height/5+height/20);

  fill(#2d8f50);
  if (button((3*width/4)-(width/2)/2+10, 3*height/5, 
    width/6-10, height/10)) {
    screen=4;
  }
  fill(30);
  text("Credits", 3*(width/4)-(width/6), 3*height/5+height/20);

  fill(#7b702b);
  if (button(centerButton, 4*height/5, width/3, height/10)) {
    exit();
  }
  fill(30);
  text("Quitter", centerButton+width/6, 4*height/5+height/20);
}

/********************************************************
 *Fonctions gérant le clavier suggérée par Corentin Lucas*
 *********************************************************/

void keyPressed() {
  clavier[keyCode]=true;
}
void keyReleased() {
  clavier[keyCode]=false;
}

/********************************************************
 *Fonction gerant le jeu multijoueur                    *
 ********************************************************/

void playScreenMulti() {
  styleGame();
  if (clavier[90]&&yPaD>0) {
    yPaD-=10;
  }
  if (clavier[83]&&yPaD<height) {
    yPaD+=10;
  }
  if (clavier[40]&&yPaG<height) {
    yPaG+=10;
  }
  if (clavier[38]&&yPaG>0) {
    yPaG-=10;
  }
  textSize(70);
  fill(0);
  text("J1: "+score[0]+"        "+"J2: "+score[1],width/2,height/2);
  fill(255, 200, 200);
  rectMode(CENTER);
  rect(xPaD, yPaD, padl, paGL);
  fill(0, 55, 55);
  rect(xPaG, yPaG, padl, paDL);
  rectMode(CORNER);
  fill(couleurBall[0], couleurBall[1], couleurBall[2]);
  ellipse(xBall, yBall, tBall, tBall);
  xBall+=vX*4;
  yBall+=vY*4;

  if (((xBall <= xPaD+5+tBall/2 && xBall >= xPaD) && 
    (yBall<(yPaD+paDL/2+tBall/2) && yBall>(yPaD-paDL/2-tBall/2)))||
    ((xBall >= xPaG-5-tBall/2 && xBall <= xPaG) && 
    (yBall<(yPaG+paGL/2+tBall/2) && yBall>(yPaG-paGL/2-tBall/2)))) {
    vX*=random(-2, -1);
    vY+=random(-2, 2);
    couleurBall[0]=int(random(255));
    couleurBall[1]=int(random(255));
    couleurBall[2]=int(random(255));
    if (vX>10 && xBall >= xPaD) {
      paDL=10;
    }
    if (vX<-10 && xBall <= xPaG) {
      paGL=10;
    }
  }
  //rebond Y
  if (yBall>height||yBall<0) {
    vY*=-1;
  }
  if (xBall < 0+tBall/2 && !perdu) {
    score[1]++;
    xBall=width/2;
    yBall=height/2;
    vX= random(-2, 2) ;
    vY= random(-2, 2) ;
    paDL=paGL=height/5;
  }
  if (xBall > width-tBall/2 && !perdu) {
    score[0]++;
    xBall=width/2;
    yBall=height/2;
    vX= random(-2, 2) ;
    vY= random(-2, 2) ;
  }
  if (score[0] == 5 ||score[1] == 5 ) {
    perdu=true;
  }
  if (perdu) {
    perdu();
  }
}

/********************************************************
 *Fonction gerant le jeu Solo                           *
 *********************************************************/

void playScreenSolo() {

  styleGame();
  yPaD=mouseY;
  textSize(70);
  fill(0);
  text(score[0], width/2, height/2);
  fill(couleurBall[0], couleurBall[1], couleurBall[2]);
  ellipse(xBall, yBall, tBall, tBall);

  xBall+=vX*4;
  yBall+=vY*4;

  if ( ((xBall <= xPaD+5+tBall/2 && xBall >= xPaD) && 
    (yBall<(yPaD+paGL/2+tBall/2) && (yBall>(yPaD-paGL/2-tBall/2))))) {
    vX*=random(-2, -1);
    vY+=random(-2, 2);
    score[0]++;
    couleurBall[0]=int(random(255));
    couleurBall[1]=int(random(255));
    couleurBall[2]=int(random(255));
  }
  if (xBall > width-tBall/2) {
    vX*=(-1);
    rebond++;
  }
  if ( yBall > height-tBall/2  || yBall < tBall/2) {
    vY*=(-1);
    rebond++;
  }
  if (rebond==5) {
    paGL*=0.75;
  }
  if (rebond==20) {
    if (vY>10) {
      vY=1;
    }        
    if (vX>10) {
      vX=1;
    }
    vY*=1.5;
    vX*=1.5;

    rebond=0;
  }
  if (xBall<0+tBall/2) {
    perdu=true;
  }
  rectMode(CENTER);
  fill(0, 0, 255);
  rect(xPaD, yPaD, padl, paGL);
  rectMode(CORNER);
  if (perdu == true) {
    perdu();
  }
}

/********************************************************
 *Fonction gerant le style des ecrans de jeu             *
 *********************************************************/

void styleGame() {

  background(255, 20, 50);

  fill(0);
  if (button(0, 0, 50, 25)) {
    screen=0;
  }
  fill(255);
  textSize(10);
  text("Home", 25, 12.5);
}

/********************************************************
 *Fonctions gérant le status perdu du jeu               *
 ********************************************************/

void perdu() {
  background(0);

  fill(255);
  textSize(50);
  if (!perduS.isPlaying()) {  
  }
  if (!multi) {
    text("Perdu", width/2, height/2);
    text(score[0], width/2, 2*height/3);
    if (highscoreSolo<score[0]) {
      highscoreSolo=score[0];
      println(highscoreSolo);
    }
  } else {
    background(random(255), random(255), random(255));
    if (score[0]==5) {
      text("Joueur2 a perdu", width/2, height/2);
    } else {
      text("Joueur1 a perdu", width/2, height/2);
    }
    text("J1: "+score[0]+"        "+"J2: "+score[1], width/2, 
      2*height/3);
  }
  if (button(3*width/4, 3*height/5, width/5, height/10)) {
    screen=0;
  }
  fill(0);
  text("Menu", 3*width/4+width/10, 3*height/5+height/20);
}

