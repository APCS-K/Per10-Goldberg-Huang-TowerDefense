public class Enemy {
  private int xcor;
  private int ycor;
  int onLane = 0;
  String dir;
  int speed = 1;
  private int hp = 1;
  int price = (int)random(10);
  
  //default constructor
  public Enemy() {
    //create enemy at start of path
    PathPart p = path.getStart();
    xcor = p.getX();
    ycor = p.getY();
    dir = path.getDir(0);
  }
  
  //constructor
  public Enemy(int HP) {
    PathPart p = path.getStart();
    xcor = p.getX();
    ycor = p.getY();
    dir = path.getDir(0);
    hp = HP;
  }
  
  void setHP(int k) {
    hp = k;
  }
  
  //accessor
  public int getHP() {
    return hp;
  }
  
  //accessor
  public int getPrice(){
    return price;
  }
  
  //move enemy
  void move(Node<Enemy> E) {
    Enemy e = E.data;
    //set pathStatus to know what to do next
    String pathStatus = path.checkPos(new PathPart(e.xcor,e.ycor),e.onLane);
    //leak enemy if it makes it to the end of the path
    if (pathStatus.equals("done")) {
      leak(E);
      return;
    }
    //change direction if enemy needs to turn
    else if (pathStatus.equals("next")) {
      e.onLane ++;
      e.dir = path.getDir(e.onLane);
    }
    //move and draw enemy
    if (e.dir.equals("up")) {e.ycor -= e.speed;}
    else if (e.dir.equals("down")) {e.ycor += e.speed;}
    else if (e.dir.equals("left")) {e.xcor -= e.speed;}
    else {e.xcor += e.speed;} //if (dir.equals("right"))
    fill(255,0,0);
    stroke(0);
    ellipse(e.xcor+tileSize/2,e.ycor+tileSize/2,tileSize/2,tileSize/2);
    fill(0);
    textSize(12);
    text("" + e.hp, e.xcor, e.ycor);
  }

  
  int numHits() {
    int retInt = 0;
    for (int i = 0; i < bulletList.size(); i++) {
      if (dist(this.xcor,this.ycor,bulletList.get(i).getX(),bulletList.get(i).getY()) < 5) {
        retInt ++;
        bulletList.remove(bulletList.get(i));
        i--;
      }
    }
    return retInt;
  }
 
}
