public class Tower {
 int xcor;
 int ycor;

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
  
  //shoot bullet
  void shoot() {
    bulletList.add(new Bullet(this));
  }
}
