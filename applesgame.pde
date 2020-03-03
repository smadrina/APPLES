int sliderHeight = 20; // "slider" is the invisible x axis along which the basket moves
int sliderWidth = 800;
int sliderY = 650;
int basketPos = 0;
int basketWidth = 100;
boolean gotBasket = false;

Apples r1;

int numApples = 25;
Apples[] apples = new Apples[numApples];

void setup()
{
  size(800, 800);
  background(255);
  frameRate(30);
  
  for (int i = 0; i < apples.length; i++) 
  {
    apples[i] = new Apples(); // Create each object
    r1 = new Apples();
  }
}

class Apples
{
  float x = random(width);
  float y = random(-height);
  void fall()
  {
    y += 7;
    fill(255, 0, 0);
    ellipse(x, y, 40, 40);
    if (y >= sliderY) {
      y = sliderY;
    }
  }
}

void draw()
{  
  background(255);
  
  for (int i = 0; i < apples.length; i++) 
  {
    apples[i].fall();
  }
  
  noStroke();
  // basket slider vv
  fill(100,0); // invisible
  rect(0, sliderY, sliderWidth, sliderHeight);
  // basket (but right now its a rect) vv
  fill(101, 67, 33);
  rect(basketPos-basketWidth/2.0, sliderY, basketWidth, sliderHeight);
}

// if mouse is pressed, "hold" the basket
void mousePressed()
{
  if (mouseY>= sliderY && mouseY<=sliderHeight+sliderY)
  {
    if (mouseX>=basketPos-basketWidth && mouseX<basketPos+basketWidth)
    {
      gotBasket = true;
    }
  }
}

// if mouse released, dont hold/"move" the basket
void mouseReleased()
{
  if (gotBasket) gotBasket = false;
}

// if mouse is "held" and dragged, move the basket with the mouse
void mouseDragged()
{
  if (gotBasket && mouseX<sliderWidth)
  {
    basketPos = mouseX;
    if (basketPos < 0) basketPos = 0;
  }
}
