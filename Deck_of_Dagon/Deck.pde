class Deck{
  ArrayList<Card> cards;
  
  Discard discardPile;
  
  int Count(){
    return cards.size();
  }
  
  int DiscardCount(){
    return discardPile.Count();
  }
  
  Deck(ArrayList<Card> startingCards, Discard discard){
    this.cards = startingCards;
    //this.count = cards.size();
    this.discardPile = discard;
  }
  
  //Draw Card
  Card drawCard(){
    Card c;
    if(cards.size() == 0)
      shuffleDeck();
    
      c = cards.get(cards.size()-1); //get from "top" of the Deck
      cards.remove(cards.size()-1);
    return c;
  }
  
  //Put cards back in deck
  void shuffleDeck(){
    cards = discardPile.returnToDeck();
  }
  
  //Add to Top of Deck
  void reboundCard(Card c){
    cards.add(c);
  }
  
  //Add card to deck
  //Newly acquire cards are first added to the discard pile
  void addCard(Card c){
    discardPile.addCard(c);
  }
  
}
