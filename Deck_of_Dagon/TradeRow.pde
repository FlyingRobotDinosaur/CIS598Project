class TradeRow{
 Card[] trade = new Card[6]; 
 Library library;
 
 TradeRow(Library lib){
   this.library = lib;
   for(int i = 0; i < 6; i++){
     trade[i] = lib.drawLibrary();
   }
 }
 
 String Name(int slot){
   return trade[slot].Name();
 }
 
 color Color(int slot){
   return trade[slot].Color();
 }
 
 int cardCost(int slot){
   return trade[slot].Cost(); 
 }
 
 
 Card buyCard(int slot){
   Card newCard = trade[slot];
   addNewTrade(slot);
   return newCard;
 }
 
 void addNewTrade(int slot){
   //draw from Library
   trade[slot] = library.drawLibrary();
 }
}
