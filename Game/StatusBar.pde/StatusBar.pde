//Author: Prasie G
//Date: 06/10/2024

public class StatusBar(){

//score variables
int lvl1Score = 0;
int lvl2Score = 0;
int totalScore = 0;
String plyName = " ";
boolean whatLevel;

public StatusBar(int lvl1Score, int lvl2Score, int totalScore, String plyName, boolean whatLevel){

this.lvl1Score = lvl1Score;
this.lvl2Score = lvl2Score;
this.totalScore = totalScore;
this.plyName = plyName;
this.whatLevel = whatLevel;
}

//level 1 score tracker
public int addScore(int lvl1Score){

    if(squidply1.getGridLocation() != popular.getGridLocation()){
        lvl1Score ++;
    }
}

public int looseScore(int lvl1Score){

    if(squidply1.getGridLocation() == enemy.getGridLocation() && lvl1Score >= 0){
        lvl1Score --;
    }
}

//level 2 score tracker
public int addScore(int lvl2Score){

    if(checkCollision()){
       return lvl2Score ++;
    }else{
        return lvl2Score--;
    }
}

public int looseScore(int lvl2Score){

    if(checkCollision()){
       return lvl2Score ++;
    }else{
        return lvl2Score--;
    }
}

public int totalScore(){
    return lvl1Grid.getScorelvl1() + lvl2World.getScorelvl2();
}

//accessor methods
public int getScorelvl1(){
    return lvl1Score + " is your score for Level 1!";
}

public int getScorelvl2(){
    return lvl2Score + " is your score for Level 2!";
}

public String getName(){
    return plyName;
}

}