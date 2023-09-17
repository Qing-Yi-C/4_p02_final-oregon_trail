//4_p02_final-duckkkkkkkkkies


// GLOBAL VARIABLES -----------------------------------------------------------------------------
PFont titleFont, normalFont;
int totalMiles = 100;
int totalSegments = 8;
int miles, day, segment;
PImage river, fort;

Animation wagon;
int wagonX, wagonY;
int riverX, riverY;
int riverWidth, riverDepth;
int fortX, fortY;
int introChoice, introSlide;

boolean start, atRiver, atFort, inShop, move;
boolean aDys, bDys;
int wallet, food, oxen;
int foodCost = 2;
int oxenCost = 50;
int aHealth, bHealth;
int rations, hpCut, aDysCut, bDysCut, speed;

String[] instructionsText = {"Try taking a journey by covered wagon across " + totalMiles + " miles \n of plains, rivers, and mountains. On the plains, \n will you slosh your oxen through mud and water-filled \n ruts or will you plod through dust six inches deep? \n Each day is exhausting as Aaa and Bee (the party) have \n to control their food intake and health exhuastion.", "How will they cross the rivers? If you have money, food, \n and time, you might take a ferry. Or, you can ford/walk \n the river and hope you and your wagon aren't swallowed \n alive! If you can't afford the ferry, try the safer, longer \n method of caulking the wagon!", "What about supplies? Well, if you're low on food, \n eat meagerly or hope your party finds a fort with \n a shop. Buy oxen at the shop if some die in rivers. \n Zero oxen, food, or health means the party dies \n and fails to reach the goal. At forts, you can also \n choose to travel faster but the party will lose more \n health and risk disease in rivers. Watch the party's health!", "If for some reason you don't survive — all your oxen die, \n everyone starves to death, everyone exhaust themselves \n to death, or everyone dies of dysentery from the conditions \n — don't give up! Try again... and again... and again..."};
Choices options;


// SETUP ----------------------------------------------------------------------------------------

void setup () {
  size(800, 600);
  background(0);
  frameRate(10);
  textSize(20);

  titleFont = loadFont("Papyrus-100.vlw");
  normalFont = loadFont("Luminari-Regular-25.vlw");
  river = loadImage("trail_river.png");
  fort = loadImage("trail_fort.png");
  fort.resize(175, 100);

  startScreen();

  wagon = new Animation("wagon_", 5);
  wagonX = width*7/10;
  wagonY = width*1/4 - 25;
  riverX = width/2 - 50;
  riverY = height/2 - 78;
  fortX = width/2 - 90;
  fortY = height/2 - 125;

  options = new Choices();

  miles = day = segment = 0;
  atRiver = atFort = inShop = move = false;
  aDys = bDys = false;
  start = true;
  wallet = 500;
  food = 150;
  oxen = 4;
  aHealth = bHealth = 80;
  rations = 5;
  hpCut = 1;
  aDysCut = bDysCut = 0;
  speed = 4;
  introChoice = introSlide = 0;
}//setup


// RESET -----------------------------------------------------------------------------------------

void reset () {
  options = new Choices();
  miles = day = segment = 0;
  atRiver = atFort = inShop = move = false;
  aDys = bDys = false;
  start = true;
  wallet = 500;
  food = 150;
  oxen = 4;
  aHealth = bHealth = 80;
  rations = 5;
  hpCut = 1;
  aDysCut = bDysCut = 0;
  speed = 4;
  introChoice = introSlide = 0;
}//reset


// HELPER FUNCTIONS ------------------------------------------------------------------------------

void info () { //information display
  text("Day: " + day, 10, 30);
  text("Miles: " + miles, 90, 30);
  text("Goal: " + totalMiles, 190, 30);
  text("Aaa Health: " + aHealth, width - 330, 30);
  text("Bee Health: " + bHealth, width - 160, 30);
  text("Wallet: " + wallet, 10, height - 20);
  text("Food: " + food, 130, height - 20);
  text("Oxen: " + oxen, 230, height - 20);
  text("Food intake p/day: " + rations, width - 210, 60);
  text("Daily health toll from speed: " + hpCut, width - 300, 90);
  if (aHealth > 0) {
    if (aDys) {
      fill(255, 0, 0);
      text("Aaa has dysentery", 10, 60);
      fill(255);
    }
  } else {
    fill(255, 0, 0);
    text("Aaa died :(", 10, 60);
    fill(255);
  }
  if (bHealth > 0) {
    if (bDys) {
      fill(255, 0, 0);
      text("Bee has dysentery", 10, 90);
      fill(255);
    }
  } else {
    fill(255, 0, 0);
    text("Bee died :(", 10, 90);
    fill(255);
  }
}//info

void gameOver(String message) { //lose screen
  move = false;
  segment = -1;
  fill(255, 0, 0); //red
  textAlign(CENTER);
  textSize(100);
  textFont(normalFont);
  text(message, width/2, height/2);
  textAlign(LEFT);
  textSize(20);
  fill(255); //white
}//gameOver

boolean afford(int f, int o) {
  if (wallet >= (f * foodCost) + (o * oxenCost)) {
    return true;
  }
  return false;
}//enough money in wallet

void aDys () {
  if (speed == 2 && aHealth <= 60) {
    if (int(random(0, 100)) <= 20) {
      aDysCut = 3;
      aDys = true;
    }
  }
}
void bDys () {
  if (speed == 2 && bHealth <= 60) {
    if (int(random(0, 100)) <= 20) {
      bDysCut = 3;
      bDys = true;
    }
  }
}

// DRAW ------------------------------------------------------------------------------------------

void draw() {
  background(0);

  info(); //displays info

  if (start) {
    startScreen();
    options.display(options.makeIntroChoices());
    introChoices(introChoice);
  }

  if (miles >= totalMiles) { //screen for ONLY winners :P
    move = false;
    segment = -1; // not a fort or river segment
    fill(0, 255, 0); //green
    textAlign(CENTER);
    textSize(100);
    text("YOU MADE IT!!", width/2, height/2);
    textAlign(LEFT);
    textSize(20);
    fill(255); //white
  }

  if (aHealth <= 0 && bHealth <= 0) { //LOSERS screens :PP
    gameOver("Aaa and Bee both died!");
  }
  if (food <= 0) {
    gameOver("Party starved to death!");
  }
  if (oxen <= 0) {
    gameOver("Oxen died! Party stranded!");
  }

  if (move == true && food > 0 && oxen > 0 && aHealth > 0 && bHealth > 0) { //wagon display
    wagon.display(wagonX, wagonY);
    fill(#19B43F);
    noStroke();
    rect(0, wagonY + wagon.getHeight(), width, height);
    fill(255);
    info();
  }

  // 1, 3, 5, 6 rivers (0, 2, 4, 5)
  //2, 4, 7 forts (1, 3, 6)
  if (miles == 8) { //different segments at certain number of miles
    atRiver= true;
    segment = 1;
    riverWidth = int(random(10, 20));
    riverDepth = int(random(2, 10));
  }
  if (miles == 20) {
    atFort= true;
    segment = 2;
  }
  if (miles == 40) {
    atRiver= true;
    segment = 3;
    riverWidth = int(random(10, 20));
    riverDepth = int(random(2, 10));
  }
  if (miles == 48) {
    atFort= true;
    segment = 4;
  }
  if (miles == 60) {
    atRiver= true;
    segment = 5;
    riverWidth = int(random(10, 20));
    riverDepth = int(random(2, 10));
  }
  if (miles == 68) {
    atRiver= true;
    segment = 6;
    riverWidth = int(random(10, 20));
    riverDepth = int(random(2, 10));
  }
  if (miles == 76) {
    atFort= true;
    segment = 7;
  }
  if (miles == 88) {
    atRiver= true;
    segment = 8;
    riverWidth = int(random(10, 20));
    riverDepth = int(random(2, 10));
  }

  if (move) { //if wagon is moving, increase the counters
    if (frameCount % speed == 0) { //starts off speed 5 frames
      miles++;
    }
    if (frameCount % 10 == 0) {
      day++;
      aHealth -= (hpCut + aDysCut);
      bHealth -= (hpCut + bDysCut);
      food-=rations; //consume rations # of food per 1 day
      if (rations == 15) {
        if (aHealth > 0 && aHealth <=77) {
          aHealth += 3;
        }
        if (bHealth > 0 && bHealth <=77) {
          bHealth += 3;
        }
        if (aHealth >77) {
          aHealth = 80;
        }
        if (bHealth >77) {
          bHealth = 80;
        }
      }
    }
  }

  if (atRiver == true && food > 0 && oxen > 0 && aHealth > 0 && bHealth > 0) { //stops wagon and displays images for each scenario
    fill(#19B43F);
    noStroke();
    rect(0, wagonY + wagon.getHeight(), width, height);
    fill(255);
    image(wagon.images[wagon.frame], wagonX, wagonY);
    image(river, riverX, riverY);
    move = false;
    options.display(options.makeRiverChoices());
    info();
  }
  if (atFort == true && food > 0 && oxen > 0 && aHealth > 0 && bHealth > 0) {
    if (inShop) {
      fill(0);
      noStroke();
      rect(0, wagonY + wagon.getHeight(), width, height);
      fill(255);
      image(fort, fortX, fortY);
      move = false;
      options.display(options.makeShopChoices());
      info();
    } else {
      fill(#19B43F);
      noStroke();
      rect(0, wagonY + wagon.getHeight(), width, height);
      fill(255);
      image(wagon.images[wagon.frame], wagonX, wagonY);
      image(fort, fortX, fortY);
      move = false;
      options.display(options.makeTrailChoices());
      info();
    }
  }
}//draw


// KEYPRESSED -----------------------------------------------------------------------------------

void keyPressed() {
  if (key == 'r') {
    reset(); //reset button
  }

  if (start) {
    if (key == '1') {
      introChoice = 1;
    }//1
    if (key == '2') {
      introChoice = 2;
    }//2
    if (key == '3') {
      introChoice = 3;
    }//3
    if (keyCode == ENTER || keyCode == RETURN) {
      introSlide++;
    }//enter/return
  }//start

  for (int i = 0; i <= totalSegments; i++) { // goes through all segments
    //RIVER OPTIONS -----------------------------------------------------------------------------
    int crossing = riverWidth * riverDepth; // min 20, max 200

    if (key == '1' && segment == i && move == false && atRiver == true) {
      int guess = int(random(20, 200));
      if (guess < crossing) {
        println("You cross the river successfully! \n ");
        miles++;
        move = true;
        atRiver = false;
        aDys();
        bDys();
      } else {
        println("You failed to cross the river unharmed.");
        int hpLoss = int(random(3, 10));
        int foodLoss = int(random(10, 15));
        int oxenLoss = int(random(1, 3));
        aHealth -= hpLoss;
        bHealth -= hpLoss;
        food -= foodLoss;
        oxen -= oxenLoss;
        println("Party lost " + hpLoss + " health, " + foodLoss+ " food, and " + oxenLoss + " oxen. \n ");
        miles++;
        move = true;
        atRiver = false;
        aDys();
        bDys();
      }
    }//ford/walk across the river

    if (key == '2' && segment == i && move == false && atRiver == true) {
      int guess = int(random(75, 200));
      day+=2;
      food -= 2 * rations;
      if (guess < crossing) {
        println("You cross the river successfully! \n ");
        miles++;
        move = true;
        atRiver = false;
        aDys();
        bDys();
      } else {
        println("You failed to cross the river unharmed.");
        int hpLoss = int(random(3, 10));
        int foodLoss = int(random(10, 15));
        int oxenLoss = int(random(1, 3));
        aHealth -= hpLoss;
        bHealth -= hpLoss;
        food -= foodLoss;
        oxen -= oxenLoss;
        println("Party lost " + hpLoss + " health, " + foodLoss+ " food, and " + oxenLoss + " oxen. \n ");
        miles++;
        move = true;
        atRiver = false;
        aDys();
        bDys();
      }
    }//caulk/waterproof the wagon takes two days but better possibility

    if (key == '3' && segment == i && move == false && atRiver == true) {
      day++;
      food -= 1 * rations;
      if (wallet >= 50) {
        println("You hired a ferry to cross the river.");
        println("You paid " + 50 + " dollars. \n ");
        wallet -= 50;
        miles++;
        move = true;
        atRiver = false;
      } else {
        println("You cannot afford the ferry cost of $50. \n");
      }
    }//pay for ferry

    if (key == '4' && segment == i && move == false && atRiver == true) {
      day+=5; // adds 5 days to days counter
      food -= 5 * rations; //consumes food
      if (aHealth <= 80 && bHealth <=80) {
        if (aHealth > 60 && bHealth > 60) {
          aHealth = 80;
          bHealth = 80;
        } else if (aHealth > 0) {
          aHealth += 20;
        } else if (bHealth > 0) {
          bHealth += 20;
        }
      }//adds health to Aaa and Bee (maximum 80 health)
    }//take rest at river


    // FORT OPTIONS ------------------------------------------------------------------------------
    if (key == '1' && segment == i && move == false && atFort == true && inShop == false) {
      miles++; //breaks out of move being false
      move = true;
      atFort = false;
      aDys();
      bDys();
    }//continue trail at fort

    if (key == '2' && segment == i && move == false && atFort == true && inShop == false) {
      day+=5; // adds 5 days to days counter
      food -= 5 * rations; //consumes food
      if (aHealth <= 80 && bHealth <=80) {
        if (aHealth > 60 && bHealth > 60) {
          aHealth = 80;
          bHealth = 80;
        } else if (aHealth > 0) {
          aHealth += 20;
        } else if (bHealth > 0) {
          bHealth += 20;
        }
      }//adds health to Aaa and Bee (adds 20 health, their maximum health is 80)
    }//take rest at fort

    if (key == '3' && segment == i && move == false && atFort == true && inShop == false) {
      if (rations == 5) {
        rations = 15;
      } else {
        rations = 5;
      }
    }//changes rations from normal to high and vice versa

    if (key == '4' && segment == i && move == false && atFort == true && inShop == false) {
      if (speed == 4) {
        speed = 2;
        hpCut = 2;
      } else {
        speed = 4;
        hpCut = 1;
      }
    }//changes speed from normal to faster and vice versa

    // FORT SHOP OPTIONS -----------------------------------------------------------------------
    if (key == '5' && segment == i && move == false && atFort == true) {
      inShop = true;
    }//shop menu
    if (key == '1' && segment == i && move == false && atFort == true && inShop == true) {
      if (afford(5, 0)) {
        wallet -= (5 * foodCost);
        food+=5;
      } else {
        fill(255, 0, 0);
        text("UR JUST TOO POOR!", width/2 - 110, height/4);
        fill(255);
      }
    }//buying 5 food per button press of 1
    if (key == '2' && segment == i && move == false && atFort == true && inShop == true) {
      if (afford(0, 1)) {
        wallet -= (1 * oxenCost);
        oxen+=1;
      } else {
        fill(255, 0, 0);
        text("UR JUST TOO POOR!", width/2 - 110, height/4);
        fill(255);
      }
    }//buying 1 oxen per button press of 2
    if (key == '3' && segment == i && move == false && atFort == true && inShop == true) {
      inShop = false;
    }//exit shop
  }
}//keyPressed


// INTRODUCTION FUNCTIONS -----------------------------------------------------------------------

void startScreen() {
  if (introChoice != 2) {
    background(0);
    textAlign(CENTER);
    textFont(titleFont);
    text("The Oregon Trail", width/2, 125);
  }
}//startScreen

void introChoices(int numChoice) {
  if (numChoice == 1) {
    move = true;
    start = false;
  } else if (numChoice == 2) {
    instructions(introSlide);
  } else if (numChoice == 3) {
    gameOver("You didn't even try, loser!! >:(");
  }
}//introChoices

void instructions(int n) {
  background(0);
  textAlign(CENTER);
  String text = "";
  if (n >= 0 && n <= 3) {
    text = instructionsText[n];
  } else if (n > 3) {
    reset();
  }
  if (n < 4) {
    text("Press enter/return to continue your journey.", width/2, height-100);
  }
  text(text, width/2, height/3);
}//instructions
