/* Game Class Starter File
 * Authors: Carey & Prasie
 * Last Edit: 06/11/2024
 */

import processing.sound.*;
PGraphics pg;
import java.util.Scanner;

//------------------ GAME VARIABLES --------------------//

//VARIABLES: Title Bar
String titleText = "Squid Game Simulator";
String extraText = "Squid Character";

//VARIABLES: Intro Screen
Screen introScreen;
String introBgFile = "images/SquidGameIntro.jpg";
PImage introBg;

//VARIABLES: Splash 1 Screen
Screen splash1;
String splash1BgFile = "images/SplashOne.png";
PImage splash1Bg;

///VARIABLES: Level 1 Screen
String lvl1File = "images/start-to-finish-line-racing-track-success-concept-for-life-racing-for-bigger-goals-illustration-template-layout-from-top-view-vector.jpg";
PImage lvl1Bg;
Grid lvl1Grid;
AnimatedSprite player1;
String player1File = "sprites/squid.png";
String player1Json = "sprites/squid.json";
int player1Row = 0;
int player1Col = 0;
Button updateButton = new Button("rect", 400, 500, 100, 50, "Go To Level2->");
Button resetButton = new Button("rect", 400, 500, 100, 50, "Try Again!");

AnimatedSprite enemy;
String squidgirl = "images/squidgirl.jpg";
String squidchar = "sprites/squidchar1.png";
Sprite squidply1;
float currentX;
float currentY;


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
Button dalgonaButton = new Button("rect", 100, 100, 200, 100, "ClickMe");
AnimatedSprite popular;

//VARIABLES: EndScreen
Screen endScreen;
Screen endScreen1;
PImage endBg;
PImage endBg1;
String endBgFile = "images/apcsa.png";

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

  splash1Bg = loadImage(splash1BgFile);
  splash1Bg.resize(width, height);

  lvl1Bg = loadImage(lvl1File);
  lvl1Bg.resize(width, height);

  splash2Bg = loadImage(splash2BgFile);
  splash2Bg.resize(width, height);

  lvl2WorldBg = loadImage(lvl2WorldFile);
  lvl2WorldBg.resize(width, height);

  endBg = loadImage(endBgFileLoose);
  endBg.resize(width, height); 

  endBg1 = loadImage(endBgFileWin);
  endBg1.resize(width, height); 
  
  //SETUP: Screens - setup splash & intro & end
  introScreen = new Screen("intro", introBg);
  splash1 = new Screen("splash1", splash1Bg);
  splash2 = new Screen("splash2", splash2Bg);
  endScreen = new Screen("end", endBg);
  endScreen1 = new Screen("end2", endBg1);
  currentScreen = introScreen;

  //SETUP: level1 screen - RLGL
  lvl1Grid = new Grid("levelOneGrid", lvl1Bg , 6, 8);
 squidply1 = new Sprite("sprites/chick_walk.png");
 squidply1.resize(10,10);
 currentX = squidply1.getCenterX();
 currentY =  squidply1.getCenterY();
 lvl1Grid.addSprite(squidply1);

  // player1 = new AnimatedSprite(player1File, player1Json);
  // player1.resize(200,200);
  // lvl1Grid.setTileSprite(new GridLocation(0, 0),player1 );
  // player1.resize(200,200);
  // lvl1Grid.setTileSprite(new GridLocation(5, 5),enemy);


  //SETUP: level2 screen - Dalgona
  lvl2World = new World("level2", candydrawing);
  candydrawing = loadImage("images/dalgona.png");
  candydrawing.resize(width, height);
  cutting = new SoundFile(this,"sounds/chop.mp3" );
  delay = new Delay(this);

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

  // //check for end of game
  // if(isGameOver()){
  //   endGame();
  // }

  currentScreen.pause(100);

} //end draw()



//------------------ USER INPUT METHODS --------------------//

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("\nKey pressed: " + keyCode); //key gives you a character for the key pressed

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
  if(currentScreen == lvl2World && dalgonaButton.isMouseOverButton()){
    System.out.println("Clicked!");
  }

}


//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

//   if(!isGameOver()) {
//     //set the title each loop
//     surface.setTitle(titleText + "    " + extraText + " " );
  
//   }
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
    currentScreen = lvl1World;
    lvl1World.resetTime();
    // if(song.isPlaying())
    // {
    //   song.pause();
  }

  //UPDATE: level1Grid Screen
  if(currentScreen == lvl1World){
    System.out.print("1");
    
    //Display the Player1 image
    GridLocation player1Loc = new GridLocation(player1Row , player1Col);
    lvl1Grid.setTileSprite(player1Loc, player1);
      
    //update other screen elements
    lvl1Grid.showGridImages();
    lvl1Grid.showGridSprites();
    lvl1Grid.showWorldSprites();
  //  squidply1.show();
  }

  //wait to go to level 2
  //if(currentScreen.getScreenTime() > 1000 && currentScreen.getScreenTime() < 2000){
  if(currentScreen == lvl2World){
    //lvl2World.resetTime();
    System.out.println("2");
    image(pg, 0, 0); 
    int needleHeight = 277;
    needle.moveTo(mouseX, mouseY - needleHeight);
    lvl2mechanics();

  }
}

//----------------LEVEL 1 GRID METHODS ------------//

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

//AnimatedSprite obstacle = new AnimatedSprite()
  //What is the index for the last column?



  //Loop through all the rows in the last column

    //Generate a random number


    //10% of the time, decide to add an enemy image to a Tile
    

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

  for(int i = lvl1World.getSprites().size()-1; i > 0; i--)
  {
    if(lvl1World.getSprites().get(i) != squidply1)
    {
      lvl1World.getSprites().get(i).move(-15,0);
    }

    if(lvl1World.getSprites().get(i).getLeft() == 0)
    {
      lvl1World.removeSprite(lvl1World.getSprites().get(i));
    }

    if(lvl1World.getSprites().get(i).getLeft() == 500)
    {
      totalPikaSpawn = 800;
      populateSprites();
      System.out.println("ir RAN");
    }
      System.out.println("moveLEFT: " + lvl1World.getSprites().get(i).getLeft());

  }




  // //Loop through all of the rows & cols in the grid
  // for(int r = 0; r <lvl1World.getNumRows(); r++){
  //   for(int c = 1; c <lvl1World.getNumCols(); c++){
  //     GridLocation loc = new GridLocation(r , c);

      if(lvl1Grid.getTileSprite(loc) == enemy){
        
        GridLocation leftLoc = new GridLocation(r, c - 1);





        //erase squid from current loc to move to next one
        lvl1Grid.clearTileSprite(loc);
       
        GridLocation leftLoc = new GridLocation(r, c - 1);
        lvl1Grid.setTileSprite(leftLoc, enemy);
        System.out.println("moving enemies");
      }
    }
  }
}

// //Method to check if there is a collision between Sprites on the Screen
public boolean checkCollision(GridLocation loc, GridLocation nextLoc){

  //check current location first
  PImage image = lvl1Grid.getTileImage(loc);
  Sprite obstacle1 = lvl1Grid.getTileSprite(loc);
  if(image == null && obstacle1 == null){
    return false;
  }

  //check next location
  PImage nextImage = lvl1Grid.getTileImage(nextLoc);
  Sprite nextSprite = lvl1Grid.getTileSprite(nextLoc);
  if(nextImage == null && nextSprite == null){
    return false;
  }


  //check if enemy runs into player
  if(obstacle1.equals(popular) && squidply1.equals(nextImage)){
    System.out.println("EnemySprite hits Squid");

    //clear out the enemy if it hits the player
    lvl1Grid.clearTileSprite(loc);

    //lose score
    //lvl1Score--;
  }

  //check if a player collides into enemy
  if(squidply1.equals(image) && popular.equals(nextSprite)){
    System.out.println("EnemySprite ran into Squid!");

    //Remove the image at that original location using the clearTileImage() or clearTileSprite() method from the Grid class.
    lvl1Grid.clearTileSprite(nextLoc);

    //Lose 1 scopre
    //lvl1Score--;
  }

  return true;
}

    // //Show any end imagery
    // currentScreen = endScreen;
    // currentScreen = endScreen1;

    
//------------------ LEVEL 2 CUSTOM METHODS --------------------//
void lvl2mechanics(){
  image(pg, 0, 0); 
  dalgonaButton.show();
  int needleHeight = 277;
  needle.moveTo(mouseX, mouseY - needleHeight);

  if(mousePressed)
  {
    pg.beginDraw();
    pg.stroke(0,255,0);
    pg.strokeWeight(16);
    pg.line(mouseX, mouseY, pmouseX, pmouseY);
    delay.set(10.0,0.0);
    cutting.play();
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
