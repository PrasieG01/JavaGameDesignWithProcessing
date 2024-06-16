/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 5/29/2024
 */

import processing.sound.*;
PGraphics pg;
PImage mask; 
PFont font; //extracts the image with darker pixels only

//------------------ GAME VARIABLES --------------------//

//VARIABLES: Title Bar
String titleText = "Squid Game Simulator";
String extraText = "Squid Character";

//VARIABLES: Splash Screen

//VARIABLES: scores
int lvl1Score = 0;
int lvl2Score = 0;
String progressBar = "Null";
String playerName = "";

//VARIABLES: Intro Screen
Screen introScreen;
String introBgFile = "images/SquidGameIntro.jpg";
PImage introBg;

//VARIABLES: Rules Screen
Screen rulesScreen;
String rulesBgFile = "images/rules.png";
PImage rulesBg;

//VARIABLES: Splash 1 Screen
Screen splash1;
String splash1BgFile = "images/SplashOne.png";
PImage splash1Bg;

///VARIABLES: Level 1 Screen
String lvl1File = "images/start-to-finish-line-racing-track-success-concept-for-life-racing-for-bigger-goals-illustration-template-layout-from-top-view-vector.jpg";
PImage lvl1Bg;
World lvl1World;

Button b1 = new Button("rect", 400, 500, 100, 50, "GoToLevel2");
Button startButton = new Button("rect", 650, 300, 150, 100, "Game Rules");


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
Button b2 = new Button("rect", 100, 100, 200, 100, "Level 2");
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


//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //SETUP: Match the screen size to the background image size
  size(1500,800);  //these will automatically be saved as width & height
  imageMode(CORNER);    //Set Images to read coordinates at corners  

  //SETUP: Set the title on the title bar
  surface.setTitle(titleText);

  //SETUP: Load BG images used in all screens
  introBg = loadImage(introBgFile);
  introBg.resize(width, height);

  rulesBg = loadImage(rulesBgFile);
  rulesBg.resize(width, height);

  splash1Bg = loadImage(splash1BgFile);
  splash1Bg.resize(width, height);

  lvl1Bg = loadImage(lvl1File);
  lvl1Bg.resize(width, height);

  splash2Bg = loadImage(splash2BgFile);
  splash2Bg.resize(width, height);

  lvl2WorldBg = loadImage(lvl2WorldFile);
  lvl2WorldBg.resize(width, height);

  // endBg = loadImage(endBgFile);
  // endBg.resize(width, height); 
  
  //SETUP: Screens - setup splash & intro & end
  introScreen = new Screen("intro", introBg);
  rulesScreen = new Screen("rules", rulesBg);
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
  
  //SETUP: User Input for Name
  font = createFont("Arial", 16, true);
  textFont(font);

  playerName = "";
  Button startButton = new Button("rect", 400, 500, 100, 50, "Game Rules");
  
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


// if(currentScreen == introScreen){

//   textAlign(LEFT);
//   textSize(32);
//   fill(255);
//   text("Enter Your Name:", width / 2, height / 2 - 100);
//   textSize(24);
//   text(playerName, width / 2, height / 2);

// startButton.show();

// if (startButton.isMouseOverButton() && mousePressed) {
//       currentScreen = splash1;
//       splash1.resetTime();
//     }


// }
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

  currentScreen.pause(100);

} //end draw()



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
    //System.out.println("Changing to Level2World");
  }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){

  //check if click was successful
  System.out.println("\nMouse was clicked at (" + mouseX + "," + mouseY + ")");

  System.out.println( get(mouseX, mouseY));
  //what to do if clicked? (Make player1 jump back?)


  //Identify when button is clicked
  if(currentScreen == lvl2World && b2.isMouseOverButton()){
    System.out.println("Clicked!");
  }

}


//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText + " " );

    //adjust the extra text as desired
  
  }
}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //UPDATE: Background of the current Screen
  currentScreen.show();

  //UPDATE: introScreen
  if(currentScreen == introScreen){

    textAlign(LEFT);
    textSize(32);
    fill(255);
    text("Enter Your Name:", width / 2, height / 2 - 100);
    textSize(24);
    text(playerName, width / 2, height / 2);

  startButton.show();

  if (startButton.isMouseOverButton() && mousePressed) {
    currentScreen = rulesScreen;
    rulesScreen.resetTime();
  }

}

  //UPDATE: introScreen
  if(currentScreen == rulesScreen){
    


  }

  // if(currentScreen == introScreen && introScreen.getScreenTime() > 4000 && introScreen.getScreenTime() < 5000){
  // if(currentScreen == introScreen){
  //   //System.out.print("i");
  //   currentScreen = lvl1World;
  //   lvl1World.resetTime();
  //   // if(song.isPlaying())
  //   // {
  //   //   song.pause();
  // }

  //UPDATE: level1Grid Screen
  if(currentScreen == lvl1World){
    
    //Display the Player1 image
      
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
    //lvl2World.resetTime();
    System.out.println("2");
     
    image(pg, 0, 0); 
    b2.show();
    int needleHeight = 277;
    needle.moveTo(mouseX, mouseY - needleHeight);

    lvl2mechanics();

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
    lvl1World.addSpriteCopyTo(popular,width-100,height-promNight); 
    pikaSpawn++;
  }
}


//Method to move around the enemies/sprites on the screen
public void moveSpritesANDcheckCollision(){

  for(int i = lvl1World.getNumSprites()-1; i >= 0; i--)
  for(int i = lvl1World.getSprites().size() - 1; i > 0; i--)
  {

    Sprite sprite = lvl1World.getSprite(i);

    //move enemies to the left
    if(sprite != squidply1)
    {
      sprite.move(-20,0);
    }

    //erase enemies once they reach the left edge
    if(sprite.getLeft() == 0)
    {
      System.out.println("Erasing Sprite");
      lvl1World.removeSprite(i);
      pikaSpawn--;
    }

    //End level if there is a collision
    if(squidply1.getTop() < sprite.getBottom() 
      && squidply1.getBottom() > sprite.getTop() 
      && squidply1.getRight() > sprite.getLeft() 
      && squidply1.getLeft() < sprite.getRight())
    {
      System.out.println("COLLISION: ");
    }

    // //add more Pikas once the original 3 have gone??
    // if(sprite.getLeft() == height/2)

    // if(lvl1World.getSprites().get(i).getLeft() == height/2)
    // {
    //   pikaSpawn = 0;
    //   populateSprites(3);
    // }
    
    //System.out.println("Pikaspawn: " + pikaSpawn);
  }
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

    float similar = (float) matchingPixels / totalOPixels;

    if(similar >= 0.5)
    {
      System.out.println("Level 2 Done! Carving Successful!");
    }else{
      System.out.println("Level 2 Failed! Carving Failed!");
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