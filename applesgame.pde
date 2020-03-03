int sliderHeight = 20;
int sliderWidth = 1200;
int sliderY = 450;
int slidePos = 0;
int slideWidth = 10;
boolean gotSlider = false;

Apples r1;

int numApples = 25;
Apples[] apples = new Apples[numApples];

void setup()
{
  size(600, 600);
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
    y = y + 7;
    
    fill(255, 0, 0);
    
    ellipse(x, y, 40, 40);
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
  fill(255);
  rect(0, sliderY, sliderWidth, sliderHeight);
  fill(101, 67, 33);
  rect(slidePos-slideWidth/2.0, sliderY, slideWidth, sliderHeight);
}

void mousePressed()
{
  if (mouseY>=sliderY && mouseY<=sliderHeight+sliderY)
  {
    if (mouseX >= slidePos-slideWidth && mouseX < slidePos+slideWidth)
    {
      gotSlider = true;
    }
  }
}


void mouseReleased()
{
  if (gotSlider) gotSlider = false;
}

void mouseDragged()
{
  if (gotSlider && mouseX<sliderWidth+50)
  {
    slidePos = mouseX;
    if (slidePos < 0) slidePos = 0;
  }
}
