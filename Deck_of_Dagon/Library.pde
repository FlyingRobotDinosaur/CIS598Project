class Library{
  // 
  ArrayList<Card> cardLibrary;
  
  Library(ArrayList<Card> lib){
    this.cardLibrary = lib; 
  }
  
  
  //Give random Card from library
  Card drawLibrary(){
    int index = int(random(cardLibrary.size()));
    return cardLibrary.get(index);
  }
  
}
