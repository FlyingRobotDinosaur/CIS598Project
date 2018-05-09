/*
  Deck of Dagon
  By Adam Herting
*/
import android.app.Activity;
import android.content.Context;

Game_Model game = new Game_Model();
boolean gameState = false;

void setup()
{
  orientation(PORTRAIT);
  size(displayWidth, displayHeight);
 
}

void draw(){
  background(100);
 
  if(gameState){
    game.runGame();
  }
  else{
    textSize(64);
    fill(255);
    text("Deck of Dagon", width*0.35, height*0.33);
    textSize(45);
    text("Start Game", width*0.35, height*0.5);
  }
  
}

void touchStarted(){
  if(gameState){
    
    ///Cards in Hand
    for(int i = 0; i < 5; i++){
      if(touches[0].x > width*0.1+180*i && touches[0].x < width*0.1+180*i+150 && touches[0].y > height*0.65 && touches[0].y < height*0.65+150)
        game.playCard(i);
    }
    //Cards in Trade Row
    for(int i = 1; i <= 3; i++){
      for(int j = 1; j <= 2; j++){
        if(touches[0].x > width*0.1+220*(i-1) && touches[0].x < width*0.1+220*(i-1)+200 && touches[0].y > height*0.35+220*(j-1) && touches[0].y < height*0.35+220*(j-1)+200)
          game.buyCard(i*j-1);
      }
    }
    
    if(touches[0].x > width*0.45 && touches[0].x < width*0.45+250 && touches[0].y > height*0.1 && touches[0].y < height*0.1+250){
      game.attackEnemy();
      game.nextTurn();
    }
    
  }
  else
    gameState = true;
  
}
