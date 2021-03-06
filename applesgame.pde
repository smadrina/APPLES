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
int basketApple = 0;
int groundApple = 0;
int numFallen = 0;
boolean inBasket = false;
boolean onGround = false;
float x = 0;
float y = 0;
boolean replayed = false;

Apples r1;
int numApples = 10;
Apples[] apples = new Apples[numApples];
int [] fallenApple = new int[numApples];

void setup()
{ 
  if (gamePlay == false) {
    basketApple = 0;
    groundApple = 0;
    numFallen = 0;
  }

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
  frameRate(50);

  lBound = int(0);
  rBound = int(width);

  if (mouseX <= lBound) { 
    mouseX = 0;
  } else if (rBound <= mouseX) { 
    mouseX = width;
  }

  for (int i = 0; i < numApples; i++) 
  { 
    apples[i] = new Apples(); // Create each object
    r1 = new Apples();
  }
}

class Apples
{ 
  float x = random(width);
  float y = random(-height);
  
  void replay()
  {
  if (replayed == true) {
      y = 0;
      x = 0;
      y += random(-height);
      x += random(width);
      numFallen = 0;
      basketApple = 0;
      groundApple = 0;
    }
  }
  
  boolean fall()
  {
    y += 5;
    
    pushMatrix();
    scale(0.75);
    image(sapple,x,y-sapple.height);
    popMatrix();
    
    //fill(255,0,0); // L BOUND
    //rect(basketPos-(basket.width/2), 0, 1, 1000);
    //fill(0,255,0); // R BOUND
    //rect(basketPos+(basket.width/2), 0, 1, 1000);
    fill(255,0,0); // U BOUND
    rect(0, 670, 1000, 1);
    fill(0, 255,0); // D BOUND
    rect(0, 770, 1000, 1);
    
    if (int(y) <= 1200 && int(y) >= 900
        && int(x) >= basketPos-(basket.width/2) && int(x) <= basketPos+(basket.width/2)) {
          // IF APPLE BOTTOM TOUCHES BASKET TOP (CAUGHT)
          if (x > basketPos+basket2.width) { x = 5000; }
          else if (x < basketPos) { x = -1; }
          y = width+sapple.height;
        basketApple ++; 
         }
    if (int(y) <= basket2.width+1200+5 && int(y) >= basket2.width+1200-5) 
        { 
          // IF APPLE BOTTOM TOUCHES BAR TOP (NOT CAUGHT)
          y = width+sapple.height; groundApple ++; 
      }   
        
    if (numApples == basketApple)
      { gamePlay = false;
        gameWon = true;
        gameOver = true;
        return gameOver; }
    else if (numApples != basketApple)
      { gamePlay = false;
        gameWon = false;
        gameOver = true;
        return gameOver; }
    return false;
     
  }
}

  void draw()
  {
    
    //STARTUP
    if (gamePlay == false && gameOver == false) 
    { 
      background(window2); 
      image(start, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) 
      { 
        image(tstart, 0, 0);
      } else if (mouseClicked) { 
        gamePlay = true;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
      } else { 
        image(fstart, 0, 0);
      }
    }
    //change dark bg to light bg
    else { 
      background(window); 
      window.loadPixels();
      for (int col=0; col<width; col++) {
        for (int row=0; row<height; row++) {
          int loc = col+row*width;
          window2.pixels[loc] = window2.pixels[loc];
        }
        window.updatePixels();
      } 

      //SLIDER/BASKET
      noStroke();
      // basket slider vv
      fill(100, 0); // invisible
      rect(0, sliderY, sliderWidth, sliderHeight);
      image(basket, basketPos-(basket.width/2), 0);
      
      //GAME PLAY
      if (basketApple+groundApple != numApples) {
      for (int i = 0; i < numApples; i++) 
      { 
        if (replayed == true)
          { apples[i].replay(); 
            println(i);
            if (i == numApples-1)
            { replayed = false; }
        }
          
        apples[i].fall(); 
        if (numFallen == numApples-1) 
        { 
          gameOver = true; 
        if (gameOver == true) {
          if (basketApple == numFallen) { 
            gameWon = true; 
            gamePlay = false;
          }
          else { 
            gameWon = false; 
            gamePlay = false;
          }
        }
        }
      onGround = false;
      inBasket = false;
      }
      gameOver = true;
      gamePlay = false;
   } //<>// //<>// //<>// //<>//
   
      //bottom bar + front basket
      image(basket2, basketPos-(basket.width/2), 0);
      image(bar, 0, 0);
    }

    //LOST SCREEN
    if (gamePlay == false && gameOver == true && gameWon == false && (basketApple+groundApple) == numApples) { 
      background(window2);
      image(lost, 0, 0);
      image(lost2, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+135 && mouseY>(height/2)+270 && mouseY<(height-60)) {
        image(treplay, 0, 0);
       if (mouseClicked && mouseX>(width/2)-140 && mouseX<(width/2)+135 && mouseY>(height/2)+270 && mouseY<(height-60)) { 
        gamePlay = true; 
        gameOver = false;
        gameWon = false;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
        replayed = true;
      } } else { 
        image(freplay, 0, 0);
      }
    }

    //WON SCREEN
    if (gamePlay == false && gameOver == true && gameWon == true && (basketApple+groundApple) == numApples) { 
      background(window2);
      image(won, 0, 0);
      image(won2, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+135 && mouseY>(height/2)+270 && mouseY<(height-60)) {
        image(treplay, 0, 0);
      if (mouseClicked && mouseX>(width/2)-140 && mouseX<(width/2)+135 && mouseY>(height/2)+270 && mouseY<(height-60)) { 
        gamePlay = true; 
        gameOver = false;
        gameWon = false;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
        replayed = true;
      } } else { 
        image(freplay, 0, 0);
      }
    }
  }


  // if mouse is pressed, "hold" the basket
  void mousePressed()
  { 
    mousePressed = true;
    mouseReleased = false;
    mouseDragged = false;
    mouseClicked = false;
    if (mouseY >= sliderY)
    { 
      gotBasket = true;
    }
  }

  // if mouse released, dont hold/"move" the basket
  void mouseReleased()
  { 
    mouseReleased = true;
    mouseDragged = false;
    mouseClicked = false;
    mousePressed = false;
    if (gotBasket) gotBasket = false;
  }

  // if mouse is "held" and dragged, move the basket with the mouse
  void mouseDragged()
  { 
    mouseDragged = true;
    mouseReleased = false;
    mousePressed = false;
    mouseClicked = false;
    if (gotBasket && mouseX<rBound && mouseX>=lBound)
    { 
      basketPos = mouseX;
    }
  }

  void mouseClicked()
  { 
    mouseClicked = true;
    mouseDragged = false;
    mouseReleased = false;
    mousePressed = false;
  }
