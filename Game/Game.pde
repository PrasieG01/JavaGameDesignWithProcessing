/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 5/29/2024
 */

/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 5/29/2024
 */

import processing.sound.*;
PGraphics pg;
PImage mask; 

//------------------ GAME VARIABLES --------------------//

//VARIABLES: Title Bar
String titleText = "";
String extraText = "";

//VARIABLES: scores
int lvl1Score = 0;
int lvl2Score = 0;
String progressBar = "Null";
String playerName = "";
boolean typeName = true;
boolean nameEntered = false;
boolean isPass;
float isSimiliar;

//VARIABLES: Intro Screen
Screen introScreen;
String introBgFile = "images/SquidGameIntro.jpg";
PImage introBg;

//VARIABLES: Rules Screen
Screen rulesScreen;
String rulesBgFile = "images/rules.png";
PImage rulesBg;

//VARIABLES: Broken Cookie Screen
Screen brokenScreen;
String brokenBgFile = "images/brokencookie.jpg";
PImage brokenBg;

//VARIABLES: Splash 1 Screen
Screen splash1;
String splash1BgFile = "images/SplashOne.png";
PImage splash1Bg;

///VARIABLES: Level 1 Screen
String lvl1File = "images/start-to-finish-line-racing-track-success-concept-for-life-racing-for-bigger-goals-illustration-template-layout-from-top-view-vector.jpg";
PImage lvl1Bg;
World lvl1World;

///VARIABLES: Win Dalgona Screen
Screen dalgonaWinScreen;
String dalgonaWinBgFile = "images/windalgona.png";
PImage dalgonaWinBg;


Button b1 = new Button("rect", 1080, 580, 200, 100, "Level 1");
Button b11 = new Button("rect", 450, 140, 200, 100, "Level 1");
Button startButton = new Button("rect", 620, 260, 200, 80, "Game Rules");
Button checkButton = new Button("rect", 120, 300, 200, 100, "Check");
Button tryButton = new Button("rect", 980, 440, 200, 100, "Try Again!");
Button tryButton1 = new Button("rect", 30, 660, 200, 100, "Try Again!");
Button resetLvl2Button = new Button("rect", 120, 300, 200, 100, "Reset Lvl1");

String squidgirl = "images/squidgirl.jpg";
String squidchar = "sprites/squidchar1.png";
Sprite squidply1;
float currentX;
float currentY;

SoundFile running;
SoundFile squidGameTheme;
AudioIn in;
Delay delay;
int time;

AnimatedSprite popular;
int pikaSpawn = 0;

  

//VARIABLES: Splash 2 Screen
Screen splash2;
String splash2BgFile = "images/SplashTwo.png";
PImage splash2Bg;

//VARIABLES: Level 2 Screen: Dalgona
World lvl2World;
String lvl2WorldFile = "images/SquidGame02.jpg";
PImage lvl2WorldBg;

//Grid world2Grid;
PImage candydrawing;
Sprite needle;
PImage cookies;
Button b2 = new Button("rect", 100, 580, 200, 100, "Level 2");
Button b22 = new Button("rect", 1090, 140, 200, 100, "Level 2");
SoundFile cutting;


//VARIABLES: EndScreen
Screen endScreen;
PImage endBg;
String endBgFile; //add file

//VARIABLES: Whole Game
//SoundFile song;
Screen currentScreen = introScreen;
World currentWorld;
private int msElapsed = 0;


StatusBar statusBar;
//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //SETUP: Match the screen size to the background image size
  size(1500,800);  //these will automatically be saved as width & height
  imageMode(CORNER);    //Set Images to read coordinates at corners  

  //SETUP: Set the title on the title bar
  surface.setTitle(titleText);

   statusBar = new StatusBar(0, 0, "", true);

  //SETUP: Load BG images used in all screens
  introBg = loadImage(introBgFile);
  introBg.resize(width, height);

  rulesBg = loadImage(rulesBgFile);
  rulesBg.resize(width, height);

   brokenBg = loadImage(brokenBgFile);
  brokenBg.resize(width, height);

  splash1Bg = loadImage(splash1BgFile);
  splash1Bg.resize(width, height);

  lvl1Bg = loadImage(lvl1File);
  lvl1Bg.resize(width, height);

  splash2Bg = loadImage(splash2BgFile);
  splash2Bg.resize(width, height);

  lvl2WorldBg = loadImage(lvl2WorldFile);
  lvl2WorldBg.resize(width, height);

   dalgonaWinBg = loadImage(dalgonaWinBgFile);
   dalgonaWinBg.resize(width, height);

  // endBg = loadImage(endBgFile);
  // endBg.resize(width, height); 
  
  //SETUP: Screens - setup splash & intro & end
  introScreen = new Screen("intro", introBg);
  rulesScreen = new Screen("rules", rulesBg);
  brokenScreen = new Screen("broken", brokenBg);
  dalgonaWinScreen = new Screen("win", dalgonaWinBg);
  splash1 = new Screen("splash1", splash1Bg);
  splash2 = new Screen("splash2", splash2Bg);
  endScreen = new Screen("end", endBg);
  currentScreen = introScreen;

  //SETUP: level1 screen - RLGL
  lvl1World = new World("levelOneGrid", lvl1File , 9.0, 0, 0);

 squidply1 = new Sprite("sprites/squidchar1.png");
 squidply1.resize(100,100);
 currentX = squidply1.getCenterX();
 currentY =  squidply1.getCenterY();
 lvl1World.addSprite(squidply1);
 popular = new AnimatedSprite("sprites/pikachu.png","sprites/pikachu.json");
 popular.resize(100,100);
 running = new SoundFile(this,"sounds/run.mp3");
 squidGameTheme = new SoundFile(this,"sounds/SquidGame.mp3");
 time = millis();
 delay = new Delay(this);


  //SETUP: level2 screen - Dalgona
  lvl2World = new World("level2", candydrawing);
  candydrawing = loadImage("images/dalgona.png");
  candydrawing.resize(width, height);
  cutting = new SoundFile(this,"sounds/chop.mp3" );
  in = new AudioIn(this, 0);

  ///lvl2 sprites
  needle = new Sprite("images/needle.png");
  needle.resize(100,100);
  cookies = loadImage("images/cookies.png");
  cookies.resize(800,800);


  //lvl2 Create a graphics buffer
  pg = createGraphics(1500, 800);
  pg.beginDraw();
  pg.background(candydrawing);
  pg.endDraw();

  
  //SETUP: Other
  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Magnetic.mp3");
  // song.play();
  

  println("Game started...");


} //end setup()


//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();
  updateScreen();


if (currentScreen == introScreen && typeName) {
    
    fill(255,20,147);
    textSize(40);
    text("Enter Your Name: ", 50, 200);
    text(playerName, 400, 200);

  } 

  // Title bar
  fill(255);
  rect(60, 40, width, 40);
  fill(0);
  textSize(20);
  text("Lvl1 Score: " + statusBar.lvl1Score + "Lvl2 Score:" + statusBar.lvl2Score + " | Player: " + playerName, 200, 45);

  //simple timing handling
  if (msElapsed % 300 == 0) {
    // populateSprites();
    // moveSprites();
  }
  msElapsed +=100;

  //check for end of game
  if(isGameOver()){
    endGame();
  }


if (currentScreen == lvl2World) {
    
    fill(255,20,147);
    textSize(25);
    text("Click after done with \n all four cookies! ", 120, 260);

  } 

  currentScreen.pause(100);

 //end draw()
}


//------------------ USER INPUT METHODS --------------------//

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("\nKey pressed: " + keyCode); //key gives you a character for the key pressed

  if(!running.isPlaying())
  {
    running.play();
  }
  //What to do when a key is pressed?
  //set [W] key to move the player1 up & avoid Out-of-Bounds errors
  if(keyCode == 87 && squidply1.getCenterY() > 0){
    //testDalgona();
    currentY -=5; //W
  }

  if(keyCode == 65 && squidply1.getCenterX() > 0){
    System.out.println("position" + squidply1.getCenterX());
    lvl1World.moveBgXY(10,0);
    currentX -=5; //A

  }
  if(keyCode == 83 && squidply1.getCenterY() < height){
   currentY+=5;
  } 

  if(keyCode == 68 && squidply1.getCenterX() < width){ //s
    if(lvl1World.distToRightEdge() != 0)
    {
      lvl1World.moveBgXY(-10,0);
    }
    currentX +=5;
  }

   squidply1.moveTo(currentX, currentY);


  //CHANGING SCREENS BASED ON KEYS
  //change to level1 if 1 key pressed, level2 if 2 key is pressed
  if(key == '1'){
    currentScreen = lvl1World;
  } else if(key == '2'){
    currentScreen = lvl2World;
  } else if(key == '3'){
    currentScreen = brokenScreen;
  }

//Store User Name
  if(typeName && !nameEntered){
    if(key == BACKSPACE){
      if(playerName.length() > 0){
        playerName = playerName.substring(0, playerName.length() - 1);
      }
    }
    else if(key != ENTER && key != RETURN){
      playerName += key;
    }
    else if(key == ENTER || key == RETURN){
      nameEntered = true;
      typeName = false; //disable typing after they enter their name

    }
      
    } else{
    if(key == ' '){
     // lvlScore++;
    }
  }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){

  //check if click was successful
  System.out.println("\nMouse was clicked at (" + mouseX + "," + mouseY + ")");

  System.out.println( get(mouseX, mouseY));
  //what to do if clicked? (Make player1 jump back?)

//if mouse is clicked on the lvl2World
  if(currentScreen == lvl2World) {
    //testDalgona();
  }

  //Identify when button is clicked
  if(currentScreen == lvl2World && checkButton.isMouseOverButton()){
    testDalgona();
    isPass = true;
  }
  // //Identify when button is clicked
   if(currentScreen == introScreen && b1.isMouseOverButton()){
    System.out.println("Clicked!");
    currentScreen = lvl1World;
   }

   // //Identify when button is clicked
   if(currentScreen == introScreen && startButton.isMouseOverButton()){
    System.out.println("Clicked start button");
    currentScreen = rulesScreen;
   }

   // //Identify when button is clicked
   if(currentScreen == introScreen && b2.isMouseOverButton()){
    System.out.println("Clicked level 2");
    currentScreen = lvl2World;
   }

   // //Identify when button is clicked
   if(currentScreen == rulesScreen && b11.isMouseOverButton()){
    System.out.println("Clicked b11 button");
    currentScreen = lvl1World;
   }

   // //Identify when button is clicked
   if(currentScreen == rulesScreen && b22.isMouseOverButton()){
    System.out.println("Clicked level 2");
    currentScreen = lvl2World;
   }

  //   //Identify when button is clicked
   if(currentScreen == dalgonaWinScreen && tryButton.isMouseOverButton()){
    System.out.println("resetting to introscreen");
    currentScreen = introScreen;

   }

   if(currentScreen == brokenScreen && tryButton1.isMouseOverButton()){
    System.out.println("resetting to lvl2");
    currentScreen = lvl2World;
    resetScores();
  }


   //   //Identify when button is clicked
   if(currentScreen == brokenScreen && tryButton1.isMouseOverButton()){
    System.out.println("resetting to introscreen");
    currentScreen = lvl2World;

   }

}

public void resetScores() {
  statusBar.lvl1Score = 0;
  statusBar.lvl2Score = 0;
}




//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText + " " );
  
  }
}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //UPDATE: Background of the current Screen
  currentScreen.show();

if(currentScreen == introScreen){
    currentScreen.show();
    //Show the button
    b1.show(); //go to level 1
    startButton.show(); //go to rules screen
    b2.show(); //go to level 2
  
  }

  if(currentScreen == rulesScreen){
    currentScreen.show();
    //Show the button
    b11.show(); //go to level 1
    b22.show(); //go to level 2
  
  }

   if(currentScreen == brokenScreen){
    currentScreen.show();
    fill(255,87,51);
    textSize(60);
    textAlign(CENTER, CENTER);
    text("You Broke the Cookie!", 1090, 80);
    textAlign(LEFT, BASELINE);
    tryButton1.show();

  } 

  if(currentScreen == dalgonaWinScreen){
    currentScreen.show();
    //Show the button
   tryButton.show();
  
  }
  
   if(currentScreen == lvl1World){
    currentScreen.show();
    //update other screen elements
    lvl1World.showWorldSprites();
    lvl1GameMechanic();
    //System.out.println("Display Right edge: " + lvl1World.distToRightEdge());
    squidply1.show();
  }

  //UPDATE: Dalgona Level 2 Screen

  //wait to go to level 2
  //if(currentScreen.getScreenTime() > 1000 && currentScreen.getScreenTime() < 2000){
  if(currentScreen == lvl2World){

    lvl2mechanics();
    checkButton.show();
    printResult(isPass);

  }
}

//----------------LEVEL 1 GRID METHODS ------------//

public void lvl1GameMechanic()
{
  populateSprites(3);
  moveSpritesANDcheckCollision();
  playAndPause();
}



public void playAndPause()
{
  if(time % 300 == 0)
  {
    System.out.println("ok");
  }

}



//Method to populate enemies or other sprites on the screen
public void populateSprites(int numPika){
  int multipler = (int)(Math.random()*8);
  int promNight = multipler*100;

  System.out.println("PS: " + pikaSpawn + "\tnumPika: " + numPika);

  if(pikaSpawn < numPika )
  {
    System.out.println("Spawning new Pika at : " + promNight);
    lvl1World.addSpriteCopyTo(popular,width-100, height-promNight); 
    pikaSpawn++;
  }
}


//Method to move around the enemies/sprites on the screen
public void moveSpritesANDcheckCollision() {
  for (int i = lvl1World.getNumSprites() - 1; i >= 0; i--) {
    Sprite sprite = lvl1World.getSprite(i);

    // Move enemies to the left
    if (sprite != squidply1) {
      sprite.move(-20, 0);
    }

    // Erase enemies once they reach the left edge
    if (sprite.getLeft() == 0) {
      System.out.println("Erasing Sprite");
      lvl1World.removeSprite(i);
      pikaSpawn--;
    }

    // Check for collision with squidply1
    if (squidply1.getTop() < sprite.getBottom() 
      && squidply1.getBottom() > sprite.getTop() 
      && squidply1.getRight() > sprite.getLeft() 
      && squidply1.getLeft() < sprite.getRight()) {
      System.out.println("COLLISION: ");

      // Restart level 1 if there is a collision
      restartLevel1();
      return; // Exit the loop after restarting the level
    }
  }
}

// Method to restart level 1
private void restartLevel1() {

  System.out.println("Restarting Level 1");
  //  reset the player's position and re-populate sprites
  squidply1.moveTo(currentX, currentY); // Set initial position
  //lvl1World.removeSprite(); // Clear existing sprites
  populateSprites(3); // Re-populate sprites
  pikaSpawn = 3; // Reset pikaSpawn or other variables if needed
}


//---------------------END GAME METHODS -----------------//

//method to indicate when the main game is over
public boolean isGameOver(){
  
  return false; //by default, the game is never over
}

//method to describe what happens after the game is over
public void endGame(){
    System.out.println("Game Over!");

    //Update the title bar

    //Show any end imagery
    currentScreen = endScreen;

}
  public void printResult(boolean success)
  {
  Float percentage = new Float(isSimiliar);
  String intToStringPER = percentage.toString();
  if(success)
  {
    textSize(60);
    fill(0, 0, 0);
    text(intToStringPER+ " % ", 48, 180, -120);
  }
  success = !success;
}



//------------------ LEVEL 2 CUSTOM METHODS --------------------//

void lvl2mechanics(){
  image(pg, 0, 0); 
  int needleHeight = 277;
  needle.moveTo(mouseX, mouseY - needleHeight);

  if(mousePressed)
  {
    pg.beginDraw();
    pg.stroke(0,255,0);
    pg.strokeWeight(16);
    pg.line(mouseX, mouseY, pmouseX, pmouseY);
    delay.set(10.0,0.0);
    if(!cutting.isPlaying())
    {
      cutting.play();
    }
    pg.endDraw();
    needle.show();
  }
}


//test if statement for carving evaluation
void testDalgona(){
  int matchingPixels = 0;
    int totalOPixels = 0;
    int wrongPixels = totalOPixels - matchingPixels;

    for(int i = 0; i < candydrawing.width; i++){
      for(int y = 0; y < candydrawing.height; y++){
        if((isBrown(candydrawing.get(i,y))) && (isGreen(pg.get(i,y)))){
          matchingPixels++;
    
        }
        if(isBrown(candydrawing.get(i,y))){
          totalOPixels++;
        }
      }
    }

    isSimiliar = (float) matchingPixels / totalOPixels;

    if(isSimiliar >= 0.5)
    {
      System.out.println("Level 2 Done! Carving Successful!");
     statusBar.addScore4Level2(10);  // Increment level 2 score
       currentScreen = dalgonaWinScreen;
    }else{
      System.out.println("Level 2 Failed! Carving Failed!");
      currentScreen = brokenScreen;
      statusBar.addScore4Level2(-10);  // Increment level 2 score
    }

}


//check if it's green
public boolean isGreen(int g){
  Color o = new Color(g);
  if((o.getGreen() == 255) && (o.getRed() == 0) && (o.getBlue() == 0)){
    return true;

  }
  return false;
}


//check if it's brown
public boolean isBrown(int b){
  Color l = new Color(b);
  if((l.getRed() >= 110 && l.getRed() <= 139) && (l.getGreen() >= 53 && l.getGreen() <= 78) && (l.getBlue() >= 13 && l.getBlue() <= 14)){
    return true;
  }
  return false;
}