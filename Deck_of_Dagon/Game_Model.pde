//Game Models
class Game_Model{
  
  ///Player's Stats
  public int playerHealth = 100;
  public int playerMadness = 1;
  int deckCount;
  int discardCount;
  //Player's Resources and effets
  //Resets at end of turn
  boolean reboundCard = false; //rebound next card
  boolean exhaustCard = false; //exhaust next card
  int attackResource = 0; //use for attacking enemy
  int tradeResource = 0; //use to acquire new cards off trade row
  int exhaustCount = 0; //Number of Cards exhausted
  boolean gameOver = false;
  boolean gameWin = false;
  
  //Starting Cards
  Card srike = new Card("Srike", "", 0, 5, 0, 0, 0, false, false, #FC0307);
  Card hunch = new Card("Hunch", "", 0, 0, 1, 0, 0, false, false, #03FC1D);
  //New Cards
  Card Clue = new Card("Clue", "", 3, 0, 2, 0, 0, false, false, #067912);
  Card Focus = new Card("Focus", "", 5, 0, 2, -1, 0, false, false, #1798E5);
  Card Bleed = new Card("Bleed", "", 4, 15, 0, 2, 5, false, false, #FA6400);
  Card Back = new Card("Back", "", 4, 5, 1, 0, 0, true, false, #FAD500);
  Card Consume = new Card("Consume", "", 6, 7, 0, 1, 0, false, true, #000000);
  
  
  //Game's Models
  Card[] startingCards = {srike, srike, srike, hunch, hunch, hunch, hunch, hunch, hunch, hunch}; 
  Card[] lib = {Clue, Focus, Bleed, Back, Consume};
  Card[] hand = new Card[5];
  boolean[] played = new boolean[5];
  Deck deck;
  Discard discard;
  Library gameLibrary;
  TradeRow traderow;
  Enemy enemy;
  
  
  Game_Model(){
    //Starting Deck
    ArrayList<Card> sdeck = new ArrayList<Card>();
    for(int i = 0; i < 10; i++){
      sdeck.add(startingCards[i]);
    }
    //Library
    ArrayList<Card> libList = new ArrayList<Card>();
    for(int i = 0; i < 5; i++){
      libList.add(lib[i]);
    }
    
    
    this.discard = new Discard();
    this.deck = new Deck(sdeck, discard);
    this.enemy = new Enemy("Deep One", 100, 5);
    
    this.gameLibrary = new Library(libList);
    this.traderow = new TradeRow(gameLibrary);
    
     drawHand();
    
  }
  
  void runGame(){
    DrawGame();
  }
  
  
  //Move to next turn
  void nextTurn(){
    drawHand();
    for(int i = 0; i < 5; i++)
      played[i] = false;
      
    attackResource = 0;
    tradeResource = 0;
    reboundCard = false;
    exhaustCard = false;
    
    //Enemy Attacks
    playerHealth -= enemy.attack(playerMadness);
    
    //Take Insanity damage
    if(playerMadness > 10){
      playerHealth -= 25;
      playerMadness = 1;
    }
    
    //Check if player loses
    if(playerHealth <= 0)
      gameOver = true;
      
     //Check if enemy defeated
    if(enemy.Health() <= 0)
      gameWin = true;
      
  }
  
  void attackEnemy(){
     enemy.damageEnemy(attackResource);
     attackResource = 0;
  }
  
  //Play card effets
  void playCard(int slot){
    if(!played[slot])
    {
      played[slot] =true;
    Card c = hand[slot];
    //Check if rebound or exhaust effets applies
      boolean isRebounded = reboundCard;
      boolean isExhausted = exhaustCard;
      //Gain Resources
      attackResource += c.attack;
      tradeResource += c.trade;
      playerHealth += c.healeffet;
      playerMadness += c.madness;
      
      if(c.rebound){
        reboundCard = true;
      }
      
      if(c.exhaust){
        exhaustCard = true;
      }
      
      // discard, rebound or exhaust this card
      if(isExhausted){
        //Card is not return to deck
        exhaustCount++;
      }
      else if(isRebounded){
        //Card added to top of deck
        deck.reboundCard(c);
      }
      else{
        //Card added to discard
        deck.addCard(c);
      }
    }
  }
  
  void drawHand(){
    for(int i = 0; i < 5; i++){
      drawCard(i);
    }
  }
 
 void drawCard(int slot){
   hand[slot] = deck.drawCard();
 }
  
  void buyCard(int slot){
    int buyCost = traderow.cardCost(slot);
    if(tradeResource >= buyCost){
      Card c = traderow.buyCard(slot);
      deck.addCard(c);
      tradeResource -= buyCost;
    }
  }
  
  void DrawGame(){
    rectMode(CORNER);
    //Player Stats
    fill(#FF0D0D);
    rect(width*0.3, height*0.8, (float) playerHealth * 5, 50); //Display player Health
    fill(#25A75F);
    rect(width*0.3, height*0.82, (float) playerMadness * 100, 50); //Display player Madness
    fill(0);
    textSize(25);
    text(playerHealth, width*0.25, height*0.8);
    text(playerMadness, width*0.25, height*0.82);
    textSize(40);
    fill(#FF0D15);
    text(attackResource, width*0.1, height*0.8);
    fill(#F6FF0D);
    text(tradeResource, width*0.1, height*0.83);
    
    textSize(35);
    //Enemy Stats
    fill(#120464);
    rect(width*0.45, height*0.1, 250, 250);
    fill(255);
    text(enemy.Name(), width*0.45, height*0.1);
    //Cards in Hand
    for(int i = 0; i < 5; i++){
      fill(hand[i].Color());
      rect(width*0.1+180*i, height*0.65, 150, 150);
      fill(255);
      text(hand[i].Name(), width*0.1+180*i, height*0.65);
    }
    //Cards in Trade Row
    for(int i = 1; i <= 3; i++){
      for(int j = 1; j <= 2; j++){
        fill(traderow.Color(i*j-1));
        rect(width*0.1+220*(i-1), height*0.35+220*(j-1), 200, 200);
        fill(255);
        text(traderow.Name(i*j-1), width*0.1+220*(i-1), height*0.35+220*(j-1));
      }
    }
    
    //Win or Lose State
    textSize(64);
    fill(0);
    if(gameOver)
      text("Game Over", width*0.1, height*0.30);
    if(gameWin)
      text("You Win", width*0.1, height*0.30);
    
    //Description of selected card
    //rectMode(CORNERS);
    //text("Card Name", width*0.1, height*0.88, width*0.5, height*0.9);
   // text(testtext, width*0.1, height*0.91, width*0.9, height*0.99);
    
    
    
  }
}
