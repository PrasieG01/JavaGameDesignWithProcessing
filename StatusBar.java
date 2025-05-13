//Author: Prasie G
//Date: 06/10/2024

public class StatusBar{

    //score variables
    int lvl1Score = 0;
    int lvl2Score = 0;
    String plyName = " ";
    boolean whatLevel;

    public StatusBar(int lvl1Score, int lvl2Score, String plyName, boolean whatLevel){

    this.lvl1Score = lvl1Score;
    this.lvl2Score = lvl2Score;
    this.plyName = plyName;
    this.whatLevel = whatLevel;
    }

 // Level 1 score tracker
    public void addScore4Level1(int numPoints) {
        lvl1Score += numPoints;


        // if (squidply1.getSprite() != popular.getTileSprite()) {
        //     lvl1Score++;
        // }
    }
    

//level 2 score tracker
    public void addScore4Level2(int numPoints2) {
        lvl2Score += numPoints2;
    }



public int getTotalScore() {
        return lvl1Score + lvl2Score;
    }


//accessor methods
    public String getScorelvl1() {
        return lvl1Score + " is your score for Level 1!";
    }

    public String getScorelvl2() {
        return lvl2Score + " is your score for Level 2!";
    }

    public String getName() {
        return plyName;
    }

}