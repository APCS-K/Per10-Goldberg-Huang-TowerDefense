public class Tower {
 int xcor;
 int ycor;
 //towerType to be implemented later
 int towerType;

  //constructor
  public Tower(int x, int y) {
    xcor=x;
    ycor=y;
  }
  
  //accessor
  public int getX() {
    return xcor;
  }
  
  //accessor
  public int getY() {
    return ycor;
  }
  
  //draw tower
  void drawTower() {
    fill(0,0,255);
    stroke(0);
    rect(xcor*tileSize,ycor*tileSize,tileSize,tileSize);
  }
  
  void shoot() {
    bulletList.add(new Bullet(this));
  }
}
