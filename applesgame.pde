int sliderHeight = 20;
int sliderWidth = 1200;
int sliderY = 450;
int slidePos = 0;
int slideWidth = 10;
boolean gotSlider = false;

void setup()
{
  size(600, 600);
  background(255);
  frameRate(5);
}

void draw()
{
  //draw the time slider
  noStroke();
  fill(255);
  rect(0, sliderY, sliderWidth, sliderHeight);
  fill(101, 67, 33);
  rect(slidePos-slideWidth/2.0, sliderY, slideWidth, sliderHeight);
  
  
  float pick = random(1);
  if(pick < 0.5)
  {
    fill(200, 0, 0, 140);
  }
  else if(pick < 0.7)
  {
    fill(225, 0, 0, 140);
  }
  else
  {
    fill(255, 0, 0, 140);
  }
  
  //ellipse(random(width), 50, 40, 40);

  ellipse(random(width), 50, 40, 40);
  
  /*for (int fall = 50; fall > 20; fall++)
  {
    ellipse(random(width), fall, 40, 40);
  }
  */
}

void mousePressed()
{
  //This allows you to grab the slider.
  //If you put all of this logic in mouseDragged,
  //you need to drag slowly so the mouse does not get
  //ahead of the slider. This implementation performs better.
  if (mouseY>=sliderY && mouseY<=sliderHeight+sliderY)
  { //I coud have made this all into one if.  Just
    //used two to make it a little more readable
    //I'm intentionally making the grab borders a bit wider, so it is easier to grab.
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
