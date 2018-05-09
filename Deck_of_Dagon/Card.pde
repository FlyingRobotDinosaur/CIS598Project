class Card{
  int cost; //Cost to acquire card
  color c;
  
  //Card effets
  int attack; //Attack damage
  int trade; //resource to acquire new cards
  int madness; //madness pealty of card
  
  int healeffet; //get back health
  boolean rebound; //Next played card go to top of deck
  boolean exhaust; //Next played card go to Exhaust pile
  
  String cardName;
  String description;
  
  String Name(){
    return cardName;
  }
  
  int Cost(){
    return cost;
  }
  
  color Color(){
    return c; 
  }
  
  Card(String name, String des, int cost, int attack, int trade, int madness, int healeffet, boolean rebound, boolean exhaust, color c){
    this.cardName = name;
    this.description = des;
    this.cost = cost;
    this.madness = madness;
    this.attack = attack;
    this.trade = trade;
    this.healeffet = healeffet;
    this.rebound = rebound;
    this.exhaust = exhaust;
    this.c = c;
  }
  
}
