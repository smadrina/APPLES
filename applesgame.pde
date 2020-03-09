int sliderHeight = 20; // "slider" is the invisible x axis along which the basket moves
int sliderWidth = 800;
int sliderY = 410;
int basketPos = mouseX;
int rBound;
int lBound;
boolean gotBasket = false;
boolean gamePlay = false;
boolean gameOver = false;
boolean gameWon = false;
boolean mouseClicked = false;
boolean mouseReleased = false;
boolean mousePressed = false;
boolean mouseDragged = false;
int score = 0;
int numFallen = 0;

Apples r1;
int numApples = 25;
Apples[] apples = new Apples[numApples];

void setup()
{ if (gamePlay == false) {
  score = 0;
  numFallen = 0; }
  
  window = loadImage("cts12_window.png");
  window2 = loadImage("cts12_window2.png");
  start = loadImage("cts12_start.png");
  tstart = loadImage("cts12_tstart.png");
  fstart = loadImage("cts12_fstart.png");
  treplay = loadImage("cts12_treplay.png");
  freplay = loadImage("cts12_freplay.png");
  won = loadImage("cts12_won.png");
  won2 = loadImage("cts12_won2.png");
  lost2 = loadImage("cts12_lost2.png");
  lost = loadImage("cts12_lost.png");
  bapple = loadImage("cts12_apple.png");
  sapple = loadImage("cts12_apple22.png");
  bar = loadImage("cts12_bar.png");
  basket = loadImage("cts12_basket.png");
  basket2 = loadImage("cts12_basket2.png");
  size(850, 850);
  frameRate(40);
  
  rBound = int(width-(basket.width/2)-100);
  lBound = int(-(basket.width/2)+100);
  
  if (mouseX <= lBound) { mouseX = 0; }
  else if (rBound <= mouseX) { mouseX = width; }
  
  for (int i = 0; i < numApples; i++) 
  { apples[i] = new Apples(); // Create each object
    r1 = new Apples(); } }

class Apples
{
  float x = random(width);
  float y = random(-height);
  
  //void fall(int i)
  //{ y += 8;
  //  fill(255, 0, 0);
  //  ellipse(x, y, 40, 40);
  //  if (y>=0 && basketPos<x && x<(basket.width+basketPos)) { 
  //    println("caught",i,numApples-1,score, numFallen);
  //    score++; 
  //    numFallen++; }
  //  if (y==700) {
  //    println("ground",i,numApples-1,score, numFallen); }
  //    numFallen++;
  boolean appleFallen=false;
  void fall(int i)
  {
    y += 7;
    fill(255, 0, 0);
    ellipse(x, y, 40, 40);
    appleFallen=false;
     if (y<=sliderY && y>=sliderY-sliderHeight){
       if (x>=basketPos && x<basketPos+basket.width){
     println("caught");
     score++;
     appleFallen=true;
     }
  }
    if (y >= 700) {
      y = 700;
      println("ground");
      appleFallen=true;
    //if (i == numApples-1) {
    //  gameOver = true; 
    //  gamePlay = false;
    //  if (numApples-1 == score) 
    //    { gameWon = true; }
    //  return; }
  }
}}

void draw()
{
  //STARTUP: DONE
  if (gamePlay == false && gameOver == false) { background(window2);
    image(start,0,0);
    if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) {
      image(tstart,0,0); }
    else if (mouseClicked || mousePressed) { gamePlay = true; }
    else { image(fstart,0,0); }
    
  }
  //GAMEPLAY
  else { background(window); 
      window.loadPixels();
      for (int col=0; col<width; col++) {
        for (int row=0; row<height; row++) {
          int loc = col+row*width;
          int slide = col+row*width;
          window2.pixels[loc] = window2.pixels[loc]; 
      }
      window.updatePixels(); } 
      
  //SLIDER/BASKET
  noStroke();
  // basket slider vv
  fill(100,0); // invisible
  rect(0, sliderY, sliderWidth, sliderHeight);
  image(basket,basketPos,0);
  
  for (int i = 0; i < numApples; i++) 
  { apples[i].fall(i); 
    if (gameOver == true) 
      { gamePlay = false; break; }}
    
  //BAR
  image(basket2,basketPos,0);
  image(bar,0,0); 
}
    
  //LOST: DONE
  if (gamePlay == false && gameOver == true && gameWon == false && numFallen == numApples-1) { background(window2);
    image(lost,0,0);
    image(lost2,0,0);
    if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) {
      image(treplay,0,0); }
    else if (mouseClicked || mousePressed) { gamePlay = true; gameOver = false;}
    else { image(freplay,0,0); } }
    
  //WON: DONE
  if (gamePlay == false && gameOver == true && gameWon == true && numFallen == numApples-1) { background(window2);
    image(won,0,0);
    image(won2,0,0);
    if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) {
      image(treplay,0,0); }
    else if (mouseClicked || mousePressed) { gamePlay = true; gameOver = false;}
    else { image(freplay,0,0); } } }

// if mouse is pressed, "hold" the basket
void mousePressed()
{ mousePressed = true;
  mouseReleased = false;
  mouseDragged = false;
  mouseClicked = false;
  if (mouseY >= sliderY)
    { gotBasket = true; } }

// if mouse released, dont hold/"move" the basket
void mouseReleased()
{ mouseReleased = true;
  mouseDragged = false;
  mouseClicked = false;
  mousePressed = false;
if (gotBasket) gotBasket = false; }

// if mouse is "held" and dragged, move the basket with the mouse
void mouseDragged()
{ mouseDragged = true;
  mouseReleased = false;
  mousePressed = false;
  mouseClicked = false;
  if (gotBasket && mouseX<rBound && mouseX>=lBound)
  { basketPos = mouseX; } }
    
void mouseClicked()
{ mouseClicked = true;
  mouseDragged = false;
  mouseReleased = false;
  mousePressed = false; }
