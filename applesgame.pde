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

Apples r1;
int numApples = 5;
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
  frameRate(40);

  rBound = int(width-(basket.width/2)-100);
  lBound = int(-(basket.width/2)+100);

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
  boolean fall(int i)
  {
    y += 5;
    fill(255, 0, 0);
    ellipse(x, y, 40, 40);
    if (x>=basketPos && x<basketPos+basket.height && y>=basket2.height-5 && y<=basket2.height+5) {
      y=basket2.height;
      inBasket = true;
      println(i, "inBasket", gamePlay, gameOver, gameWon, numFallen, basketApple, groundApple); //ftftf,
      //fallenApple[i] = i;
      //if (fallenApple.contains(i)) {
      //  return true; }
    }
    if (y>=800 && x<basketPos && x>basketPos+basket.height) {
      onGround = true;
      println(i, "onGround", gamePlay, gameOver, gameWon, numFallen, basketApple, groundApple); //tftff,tfftf
      return true;
    }
    return false;
  }
}

  void draw()
  {
    
    //STARTUP: DONE
    if (gamePlay == false && gameOver == false) 
    { 
      background(window2); 
      image(start, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) 
      { 
        image(tstart, 0, 0);
      } else if (mouseClicked || mousePressed) { 
        gamePlay = true;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
      } else { 
        image(fstart, 0, 0);
      }
    }
    //GAMEPLAY
    else { 
      background(window); 
      window.loadPixels();
      for (int col=0; col<width; col++) {
        for (int row=0; row<height; row++) {
          int loc = col+row*width;
          int slide = col+row*width;
          window2.pixels[loc] = window2.pixels[loc];
        }
        window.updatePixels();
      } 

      //SLIDER/BASKET
      noStroke();
      // basket slider vv
      fill(100, 0); // invisible
      rect(0, sliderY, sliderWidth, sliderHeight);
      image(basket, basketPos, 0);
      
      
      if (numFallen < numApples && (basketApple+groundApple) != numApples) {
      for (int i = 0; i < numApples; i++) 
      { 
        apples[i].fall(i); 
        if (inBasket == true) { 
          basketApple +=1; 
          numFallen +=1;
          println(inBasket, onGround, numFallen, groundApple, basketApple);
        }
        if (onGround == true) { 
          groundApple +=1; 
          numFallen +=1;
          println(inBasket, onGround, numFallen, groundApple, basketApple);
        }
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
   }
      
      //BAR
      image(basket2, basketPos, 0);
      image(bar, 0, 0);
    }

    //LOST: DONE
    if (gamePlay == false && gameOver == true && gameWon == false && (basketApple+groundApple) == numApples) { 
      background(window2);
      image(lost, 0, 0);
      image(lost2, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) {
        image(treplay, 0, 0);
      } else if (mouseClicked || mousePressed) { 
        gamePlay = true; 
        gameOver = false;
        gameWon = false;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
      } else { 
        image(freplay, 0, 0);
      }
    }

    //WON: DONE
    if (gamePlay == false && gameOver == true && gameWon == true && (basketApple+groundApple) == numApples) { 
      background(window2);
      image(won, 0, 0);
      image(won2, 0, 0);
      if (mouseX>(width/2)-140 && mouseX<(width/2)+140 && mouseY>(height/2)+250 && mouseY<(height-60)) {
        image(treplay, 0, 0);
      } else if (mouseClicked || mousePressed) { 
        gamePlay = true; 
        gameOver = false;
        gameWon = false;
        numFallen = 0;
        basketApple = 0;
        groundApple = 0;
      } else { 
        image(freplay, 0, 0);
      }
    }
    
    
        rect(0, basket2.width+415, 1000, 1, 0); // basket level
        rect(0, basket2.width+500, 1000, 1, 0); // ground level
    
    
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
