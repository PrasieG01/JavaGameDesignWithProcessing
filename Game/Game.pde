/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 5/21/2024
 */

import processing.sound.*;
import java.util.Scanner;

//------------------ GAME VARIABLES --------------------//

//Title Bar
private int msElapsed = 0;
String titleText = "Squid Game Simulator";
String extraText = "Squid Character";
//Scanner scan;


//scores
int lvl1Score = 0;
int lvl2Score = 0;
String progressBar = "Null";

//Current Screens
Screen currentScreen;
World currentWorld;
Grid currentGrid;

//Intro screen Variables
Screen introScreen;
String introBgFile = "images/SquidGameIntro.jpg";
PImage introBg;

//Splash 1 Screen Variables
Screen splashOne;
String oneBgFile = "images/SplashOne.png";
PImage splashOneBg;

///Level 1 Screen Variables
String lvl1File = "images/SquidGame01.jpg";
PImage lvl1Bg;
Grid lvl1Grid;

AnimatedSprite player1;
String player1File = "sprites/squid.png";
String player1Json = "sprites/squid.json";
int player1Row = 0;
int player1Col = 0;

PImage enemy;
// AnimatedSprite enemySprite;


AnimatedSprite exampleSprite;
boolean doAnimation;

//Splash 2 Screen Variables
Screen splashTwo;
String twoBgFile = "images/SplashTwo.png";
PImage splashTwoBg;

//Level 2 Screen Variables
World lvlWorld2;
String lvlWorld2File = "images/SquidGame02.jpg";
PImage lvlWorld2Bg;
Grid worldTwoGrid;

Sprite needle;
// PImage star;
// PImage rectangle;
// PImage circle;
// PImage umbrella;
PImage cookies;

//EndScreen variables
Screen endScreen;
PImage endBg;
String endBgFile = "images/apcsa.png";

//Example Variables
//HexGrid hGrid = new HexGrid(3);
  // SoundFile song;
  

//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(1500,800);
  
  //Set the title on the title bar
  surface.setTitle(titleText);

  //Load BG images used
  introBg = loadImage(introBgFile);
  introBg.resize(1500,800);
  splashOneBg = loadImage(oneBgFile);
  splashOneBg.resize(1500,800);
  lvl1Bg = loadImage(lvl1File);
  lvl1Bg.resize(1500,800);
  splashTwoBg = loadImage(twoBgFile);
  splashTwoBg.resize(1500,800);
  lvlWorld2Bg = loadImage(lvlWorld2File);
  endBg = loadImage(endBgFile);
  endBg.resize(1500,800);

  //setup the screens/worlds/grids in the Game

  ///setup splash & intro & end
  introScreen = new Screen("intro", introBg);
  splashOne = new Screen("splashOne", splashOneBg);
  splashTwo = new Screen("splashTwo", splashTwoBg);
  endScreen = new Screen("end", endBg);
  currentScreen = introScreen;

  ///setup level1 screen
  lvl1Grid = new Grid("levelOneGrid", lvl1Bg , 6, 8);
  player1 = new AnimatedSprite(player1File, player1Json);
  lvl1Grid.setTileSprite(new GridLocation(0, 0),player1 );
  player1.resize(200,200);
  enemy = loadImage("images/x_wood.png");
  enemy.resize(100,100);




  ///setup level2 screen
  lvlWorld2 = new World("levelTwo", lvlWorld2Bg);
  worldTwoGrid = new Grid("levelTwoGrid", lvlWorld2Bg , 6, 8);
  ///sprites
  needle = new Sprite("images/needle.png");
  needle.resize(100,100);
  cookies = loadImage("images/cookies.png");
  cookies.resize(400,400);


  //setup the sprites  
 

  
  exampleAnimationSetup();



  //Adding pixel-based Sprites to the world
  // mainGrid.addSpriteCopyTo(exampleSprite);
  // mainGrid.printSprites();
  System.out.println("Done adding sprites to main world..");
  
  //Other Setup
  // Load a soundfile from the /data folder of the sketch and play it back
   // song = new SoundFile(this, "sounds/Magnetic.mp3");
    //song.play();

  
  imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  println("Game started...");

} //end setup()

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  //currentScreen = lvlWorld2;
  updateScreen();

  updateTitleBar();
  //simple timing handling
  if (msElapsed % 300 == 0) {
    //sprite handling
    populateSprites();
    moveSprites();
  }
  msElapsed +=100;

    stroke(255);
      mouseDragged();

  //check for end of game
  if(isGameOver()){
    endGame();
  }

} //end draw()

//------------------ USER INPUT METHODS --------------------//


//Known Processing method that automatically will run whenever a key is pressed
void mouseDragged() {
    line(mouseX, mouseY, pmouseX, pmouseY);
  // line(120, 80, 350, 400);
    //System.out.println("drawing");
}







void keyPressed(){


  //check what key was pressed
  System.out.println("Key pressed: " + key); //keyCode gives you an integer for the key

  //What to do when a key is pressed?

  
  //set [W] key to move the player1 up & avoid Out-of-Bounds errors
  if(keyCode == 87){
   
  //   //Store old GridLocation
  //   GridLocation oldLoc = new GridLocation(player1Row, 0);

    //Erase image from previous location
    
  // exampleSprite.moveTo()
  }
  if(keyCode == 65){
   
  //   //Store old GridLocation
  //   GridLocation oldLoc = new GridLocation(player1Row, 0);

    //Erase image from previous location
    

  }

  if(keyCode == 83){
   
  //   //Store old GridLocation
  //   GridLocation oldLoc = new GridLocation(player1Row, 0);

    //Erase image from previous location
    

  }

   if(keyCode == 68){
   
  //   //Store old GridLocation
  //   GridLocation oldLoc = new GridLocation(player1Row, 0);

    //Erase image from previous location
    

  }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){

  //check if click was successful
  System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  System.out.println( get(mouseX, mouseY));
  //what to do if clicked? (Make player1 jump back?)

  //Toggle the animation on & off
  // doAnimation = !doAnimation;
  // System.out.println("doAnimation: " + doAnimation);
  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
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

  //Update the Background
  currentScreen.getBg().resize(1500,800);
  background(currentScreen.getBg());


  // Intro Screen update
  if(currentScreen.getScreenTime() > 3000 && currentScreen.getScreenTime() < 5000){
    currentScreen = lvl1Grid;
      // if(song.isPlaying())
      // {
      //   song.pause();
  }

  //level1 Screen Updates
  if(currentScreen == lvl1Grid){

    //Display the Player1 image
    GridLocation player1Loc = new GridLocation(player1Row , player1Col);
    lvl1Grid.setTileSprite(player1Loc, player1);
      
    //update other screen elements
    lvl1Grid.showSprites();
    lvl1Grid.showImages();
    lvl1Grid.showGridSprites();

  //   s+=0.1;
  //   checkExampleAnimation(s);
  }

  //Other screens?

  //Dalgona Level 2 Screen Updates
  if(currentScreen == lvlWorld2){

    needle.show();
    image(cookies, 100, 100);
    int needleHeight = 277;
    needle.moveTo(mouseX, mouseY - needleHeight);

  }


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  

  //Loop through all the rows in the last column

    //Generate a random number


    //10% of the time, decide to add an enemy image to a Tile
    

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

//Loop through all of the rows & cols in the grid

      //Store the current GridLocation

      //Store the next GridLocation

      //Check if the current tile has an image that is not player1      


        //Get image/sprite from current location
          

        //CASE 1: Collision with player1


        //CASE 2: Move enemy over to new location


        //Erase image/sprite from old location

        //System.out.println(loc + " " + grid.hasTileImage(loc));

          
      //CASE 3: Enemy leaves screen at first column

}

//Method to check if there is a collision between Sprites on the Screen
public boolean checkCollision(GridLocation loc, GridLocation nextLoc){

  //Check what image/sprite is stored in the CURRENT location
  // PImage image = grid.getTileImage(loc);
  // AnimatedSprite sprite = grid.getTileSprite(loc);

  //if empty --> no collision

  //Check what image/sprite is stored in the NEXT location

  //if empty --> no collision

  //check if enemy runs into player

    //clear out the enemy if it hits the player (using cleartTileImage() or clearTileSprite() from Grid class)

    //Update status variable

  //check if a player collides into enemy

  return false; //<--default return
}

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

//example method that creates 1 horse run along the screen
public void exampleAnimationSetup(){  
  int i = 2;
  exampleSprite = new AnimatedSprite(player1File, player1Json , 50.0, i*75.0);
  exampleSprite.resize(200,200);
}

//example method that animates the horse Sprites
public void checkExampleAnimation(float s){
  if(doAnimation){
    exampleSprite.animate(s);
    System.out.println("animating!");
  }
}
