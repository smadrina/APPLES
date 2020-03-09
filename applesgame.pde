int sliderHeight = 20; // "slider" is the invisible x axis along which the basket moves
int sliderWidth = 800;
int sliderY = 410;
int basketPos = mouseX;
int rBound;
int lBound;
boolean gotBasket = false;
boolean gamePlay = false;
boolean mouseClicked = false;
boolean mouseReleased = false;
boolean mousePressed = false;
boolean mouseDragged = false;

Apples r1;
int numApples = 25;
Apples[] apples = new Apples[numApples];

void setup()
{ window = loadImage("cts12_window.png");
  window2 = loadImage("cts12_window2.png");
  start = loadImage("cts12_start.png");
  tstart = loadImage("cts12_tstart.png");
  fstart = loadImage("cts12_fstart.png");
  bapple = loadImage("cts12_apple.png");
  sapple = loadImage("cts12_apple22.png");
  bar = loadImage("cts12_bar.png");
  basket = loadImage("cts12_basket.png");
  size(850, 850);
  frameRate(40);
  
  rBound = int(width-(basket.width/2)-100);
  lBound = int(-(basket.width/2)+100);
  
  if (mouseX <= lBound) { mouseX = 0; }
  else if (rBound <= mouseX) { mouseX = width; }
  
  for (int i = 0; i < apples.length; i++) 
  { apples[i] = new Apples(); // Create each object
    r1 = new Apples(); } }

class Apples
{ float x = random(width);
  float y = random(-height);
  float down = 0.0;
  //void fall()
  //{ bapple = loadImage("cts12_apple.png");
  //  bapple.loadPixels();
  //  loadPixels();
  //  for (float col=random(width); col<width; col++) {
  //    for (float row=random(-height); row<height; row++) {
  //      y += 7;
  //      down = y+x*width;
  //      float loc = col+row*width;
  //      pixels[int(loc)] = bapple.pixels[int(down)]; }
  //  bapple.updatePixels();
  //  updatePixels(); }
  //}
}

void draw()
{
  //STARTUP: DONE
  if (gamePlay == false) { background(window2);
    image(start,0,0);
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
      window.updatePixels();} 
  
  //for (int i = 0; i < apples.length; i++) 
  //{ apples[i].fall(); }
  
  //SLIDER/BASKET
  noStroke();
  // basket slider vv
  fill(100,0); // invisible
  rect(0, sliderY, sliderWidth, sliderHeight);
  image(basket,basketPos,0);
  
  //BAR
  image(bar,0,0); } }

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
