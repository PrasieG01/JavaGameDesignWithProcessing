/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 5/29/2024
 */

import processing.sound.*;
PGraphics pg;
PGraphics outlineBuffer;
PImage mask; //extracts the image with darker pixels only
import java.util.Scanner;

//------------------ GAME VARIABLES --------------------//

//VARIABLES: Title Bar
String titleText = "Squid Game Simulator";
String extraText = "Squid Character";

//VARIABLES: Splash Screen

//VARIABLES: scores
int lvl1Score = 0;
int lvl2Score = 0;
String progressBar = "Null";

//VARIABLES: Intro Screen
Screen introScreen;
String introBgFile = "images/SquidGameIntro.jpg";
PImage introBg;

//VARIABLES: Splash 1 Screen
Screen splash1;
String splash1BgFile = "images/SplashOne.png";
PImage splash1Bg;

///VARIABLES: Level 1 Screen
String lvl1File = "images/SquidGame01.jpg";
PImage lvl1Bg;
Grid lvl1Grid;
AnimatedSprite player1;
String player1File = "sprites/squid.png";
String player1Json = "sprites/squid.json";
int player1Row = 0;
int player1Col = 0;
Button b1 = new Button("rect", 400, 500, 100, 50, "GoToLevel2");
AnimatedSprite enemy;
String enemyFile = "images/x_wood.png";
  

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
Button b2 = new Button("rect", 100, 100, 200, 100, "ClickMe");

//outline code test
String outlineImg = "images/dalgona.png";
PImage ogOutline;

//2D Arrays of Both drawings
int[][] blackPixelColors; //from ogOutline
int[][] drawnLineColors; //the drawn outline


//VARIABLES: EndScreen
Screen endScreen;
PImage endBg;
String endBgFile = "images/apcsa.png";

//VARIABLES: Whole Game
//SoundFile song;
Screen currentScreen = introScreen;
World currentWorld;
Grid currentGrid;
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
  splash1Bg = loadImage(splash1BgFile);
  splash1Bg.resize(width, height);
  lvl1Bg = loadImage(lvl1File);
  lvl1Bg.resize(width, height);
  splash2Bg = loadImage(splash2BgFile);
  splash2Bg.resize(width, height);
  lvl2WorldBg = loadImage(lvl2WorldFile);
  lvl2WorldBg.resize(width, height);
  endBg = loadImage(endBgFile);
  endBg.resize(width, height);  

  //SETUP: Screens - setup splash & intro & end
  introScreen = new Screen("intro", introBg);
  splash1 = new Screen("splash1", splash1Bg);
  splash2 = new Screen("splash2", splash2Bg);
  endScreen = new Screen("end", endBg);
  currentScreen = introScreen;

  //SETUP: level1 screen - RLGL
  lvl1Grid = new Grid("levelOneGrid", lvl1Bg , 6, 8);
  //lvl1Grid.startPrintingGridMarks();
  player1 = new AnimatedSprite(player1File, player1Json);
  //player1.resize(200,200);
  lvl1Grid.setTileSprite(new GridLocation(0, 0),player1 );
  player1.resize(200,200);
  lvl1Grid.setTileSprite(new GridLocation(5, 5),enemy);

  //SETUP: level2 screen - Dalgona
  lvl2World = new World("level2", candydrawing);
  //lvl2Grid = new Grid("level2Grid", candydrawing , 6, 8);
  ogOutline = loadImage(outlineImg);
  ogOutline.resize(width, height);
  candydrawing = loadImage("images/dalgona.png");
  candydrawing.resize(width, height);

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

  // Create a separate PGraphics buffer for storing the outline
    outlineBuffer = createGraphics(1500, 800);
    outlineBuffer.beginDraw();
    outlineBuffer.background(candydrawing);
    outlineBuffer.endDraw();
  
    //create a mask of the blackpixelcolors
    blackPixelColors = getBlackPixelColors(ogOutline);

    //get the outline colors from the needle
    drawnLineColors = getOutlineColors(outlineBuffer);


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

  //What to do when a key is pressed?

  //set [W] key to move the player1 up & avoid Out-of-Bounds errors
  if(keyCode == 87){
    testDalgona();
  }
  else if(keyCode == 65){
    //   //Store old GridLocation
    //   GridLocation oldLoc = new GridLocation(player1Row, 0);
    //Erase image from previous location
  }
  else if(keyCode == 83){
    //   //Store old GridLocation
    //   GridLocation oldLoc = new GridLocation(player1Row, 0);
    //Erase image from previous location
  }
  else if(keyCode == 68){
    //   //Store old GridLocation
    //   GridLocation oldLoc = new GridLocation(player1Row, 0);
    //Erase image from previous location
  }

  //CHANGING SCREENS BASED ON KEYS
  //change to level1 if 1 key pressed, level2 if 2 key is pressed
  if(key == '1'){
    currentScreen = lvl1Grid;
  } else if(key == '2'){
    currentScreen = lvl2World;
    //System.out.println("Changing to Level2World");
  }

}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){

  //check if click was successful
  System.out.println("\nMouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  System.out.println( get(mouseX, mouseY));
  //what to do if clicked? (Make player1 jump back?)


  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
  }

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
  if(currentScreen.getBg() != null){
    background(currentScreen.getBg());
  }

  //UPDATE: introScreen
  if(currentScreen == introScreen && introScreen.getScreenTime() > 4000 && introScreen.getScreenTime() < 5000){
    System.out.print("i");
    currentScreen = lvl1Grid;
    lvl1Grid.resetTime();
    // if(song.isPlaying())
    // {
    //   song.pause();
  }

  //UPDATE: level1Grid Screen
  if(currentScreen == lvl1Grid){
    System.out.print("1");
    currentGrid = lvl1Grid;

    //Display the Player1 image
    GridLocation player1Loc = new GridLocation(player1Row , player1Col);
    lvl1Grid.setTileSprite(player1Loc, player1);
      
    //update other screen elements
    lvl1Grid.showGridImages();
    lvl1Grid.showGridSprites();
    lvl1Grid.showWorldSprites();
  }

  //UPDATE: Dalgona Level 2 Screen
  
  //wait to go to level 2
  //if(currentScreen.getScreenTime() > 1000 && currentScreen.getScreenTime() < 2000){
  if(currentScreen == lvl2World){
    currentGrid = null;
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
  for(int r = 0; r <lvl1Grid.getNumRows(); r++){
    for(int c = 1; c <lvl1Grid.getNumCols(); c++){
      GridLocation loc = new GridLocation(r , c);

      if(lvl1Grid.getTileSprite(loc) == enemy){
        //erase squid from current loc to move to next one
        lvl1Grid.clearTileSprite(loc);
        // if(c > 1){
        //   lvl1Grid.clearTileSprite(loc);
        // }
        GridLocation leftLoc = new GridLocation(r, c - 1);
        lvl1Grid.setTileSprite(leftLoc, enemy);
        System.out.println("moving enemies");
      }
    }
  }
}
      //Store the current GridLocation
      //Store the next GridLocation
      //Check if the current tile has an image that is not player1      
        //Get image/sprite from current location
        //CASE 1: Collision with player1
        //CASE 2: Move enemy over to new location
        //Erase image/sprite from old location
        //System.out.println(loc + " " + grid.hasTileImage(loc));
      //CASE 3: Enemy leaves screen at first column

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
    pg.endDraw();
    needle.show();
  }

  if (mousePressed) {
        outlineBuffer.beginDraw();
        outlineBuffer.stroke(0, 255, 0);
        outlineBuffer.strokeWeight(16);
        outlineBuffer.line(mouseX, mouseY, pmouseX, pmouseY);
        outlineBuffer.endDraw();
    }
}

int[][] getBlackPixelColors(PImage ogOutline){
  int[][] colors = new int[ogOutline.width][ogOutline.height];
  ogOutline.loadPixels();
  for(int x = 0; x < ogOutline.width; x++){
    for(int y = 0; y < ogOutline.height; y++){
      int pixelColor = ogOutline.pixels[y * ogOutline.width + x];
      if(isBlack(pixelColor)){
        colors[x][y] = pixelColor;
      }
    }
  }
  return colors;
}

int[][] getOutlineColors(PGraphics outlineBuffer){
    int[][] colors = new int[outlineBuffer.width][outlineBuffer.height];
    outlineBuffer.loadPixels();
    for(int x = 0; x < outlineBuffer.width; x++){
    for(int y = 0; y < outlineBuffer.height; y++){
     colors[x][y] = outlineBuffer.pixels[y * outlineBuffer.width + x];
    }
  }
  return colors;
}

// boolean isCarvingSuccess(){

//   int matchingPixels = 0;
//   int totalPixels = blackPixelColors.length * blackPixelColors[0].length;

//   for(int x = 0; x < blackPixelColors.length; x++){
//     for(int y = 0; y < blackPixelColors[x].length; y++){
//       if(blackPixelColors[x][y] != 0 && blackPixelColors[x][y] == drawnLineColors[x][y]){
//         matchingPixels++;
//       }
//     }
    
//   }

//   System.out.println("Matching pixels: " + matchingPixels);
//   System.out.println("Total pixels: " + totalPixels);

//   float similar = (float) matchingPixels / totalPixels;
//   return similar >= 0.3; // Return true if at least 80% of pixels match

// }


//what is black?
boolean isBlack(int colores){  //for some reason couldn't use just "color"
  float[] hsb = rgbToHSB(colores);
  return hsb[2] < 100; //assume brightness less than 50 is black

}

public float[] rgbToHSB(int colores){
  int r = (colores >> 16) & 0xFF;
  int g = (colores >> 8) & 0xFF;
  int b = colores & 0xFF;

  return java.awt.Color.RGBtoHSB(r, g, b, null);
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