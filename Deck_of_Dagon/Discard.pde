class Discard{
  ArrayList<Card> cards;
  
  //int count;
  int Count(){
    return cards.size(); 
  }
  
  Discard(){
    cards = new ArrayList<Card>();
  }
  
  //add to discard
  void addCard(Card c){
    cards.add(c);
  }
  
  //return cards in random order
 ArrayList<Card> returnToDeck(){
    ArrayList<Card> newDeck = new ArrayList<Card>();
    
    while(cards.size() != 0){
      int index = int(random(cards.size()));
      Card c = cards.get(index);
      cards.remove(index);
      newDeck.add(c);
    }
    
    return newDeck;
  }
  
  //clear discard
  
}
