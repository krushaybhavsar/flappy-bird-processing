PImage bg, flappy, topPipe, botPipe;
float bgx, bgy, fx, fy, g, Vfy;
int [] pipeX, pipeY;
int gameState, score;

void setup(){
  size(1500,864);
  bg = loadImage("background.png");
  flappy = loadImage("flappybird.png");
  topPipe = loadImage("toppipe.png");
  botPipe = loadImage("bottompipe.png");
  flappy.resize(70, 50);
  fx = 300;
  fy = 50;
  g = 0.25;
  pipeX = new int [10000]; //[0,0,0,0]
  pipeY = new int [pipeX.length];
  for(int i = 0; i < pipeX.length; i++){
    pipeX[i] = width + 400*i;
    pipeY[i] = (int)random(-650, -300);
  }
  gameState = -1;
}

void draw(){
  if(gameState == -1){
    startScreen();
  }else if(gameState == 0){
    setBg();  
    setPipes();
    flappy();
    score();
  }else{
    textSize(100);
    text("You Lose!", ((width/2) - 240), height/2);
  }
}
  
void keyPressed(){
  if(key == ' '){
    Vfy = -7;
  }
}

void startScreen(){
  image(bg, 0, 0);
  textSize(100);
  text("Click the mouse to begin", 150, 400);
  textSize(50);
  text("(Press the spacebar to make Flappy fly)", 275, 480);
  if(mousePressed){
    gameState = 0;
  }
}

void score(){
  textSize(40);
  text("Score: "+score, width - 250, 70);
}

void setPipes(){
  for(int i = 0; i < pipeX.length; i++){
    image(topPipe, pipeX[i], pipeY[i]);
    image(botPipe, pipeX[i], pipeY[i] + 1020);
    pipeX[i]-=2;
    if(fx > (pipeX[i]-60) && fx < (pipeX[i]+138)){
      if(!(fy > pipeY[i]+793 && fy < pipeY[i]+(1020-50))){
        gameState = 1;
      }else if (fx == pipeX[i] || fx == pipeX[i]+1){
        score++;
      }
    }
  }
}

void flappy(){
  image(flappy, fx, fy);
  fy = fy + Vfy;
  Vfy = Vfy + g;
  if(fy > height || fy < 0){
    gameState = 1;
  }
}

void setBg(){
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx = bgx - 1;
  if(bgx < -bg.width){
    bgx = 0;
  }
}
