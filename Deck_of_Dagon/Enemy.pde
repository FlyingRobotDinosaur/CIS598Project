class Enemy{
  int health;
  
  //Enemy effets
  int damage;
  
  String Enemyname;
  
  String Name(){
    return Enemyname;
  }
  
  int Health(){
    return health;
  }
  
  Enemy(String name, int health, int damage){
    this.Enemyname = name;
    this.health = health;
    this.damage = damage;
  }
  
  //Different monster would have different effects based on madness
  //For right now, the Deep One enemy deals extra damage based on madness
  
  int attack(int madness){
    return damage + madness;
  }
  
  void damageEnemy(int damage){
    health -= damage;
  }
  
}
