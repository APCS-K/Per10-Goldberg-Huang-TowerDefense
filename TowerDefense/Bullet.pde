public class Bullet {
  private int xcor;
  private int ycor;
  String dir;
  int speed = 1;
  
  public Bullet(Tower t) {
    xcor = t.getX()*tileSize;
    ycor = t.getY()*tileSize;
    int num = (int) (Math.random() * 4);
    if (num == 0) {dir = "up";}
    else if (num == 1) {dir = "down";}
    else if (num == 2) {dir = "left";}
    else {dir = "right";}
  }
  
  //accesor
  public int getX() {
    return xcor;
  }
  
  //accessor
  public int getY() {
    return ycor;
  }
  
  void move() {
    if (dir.equals("up")) {
      if (ycor <= 0) {bulletList.remove(this);}
      else {ycor -= speed;}
  }
    else if (dir.equals("down")) {
      if (ycor >= height-5) {bulletList.remove(this);}
      else {ycor += speed;}
    }
    else if (dir.equals("left")) {
      if (xcor <= 0) {bulletList.remove(this);}
    else {xcor -= speed;}
    }
    else {
    if (xcor >= gameWidth-5) {bulletList.remove(this);}
    else {xcor += speed;} //if (dir.equals("right"))
    }
    fill(0);
    stroke(0);
    ellipse(xcor+tileSize/4,ycor+tileSize/4,tileSize/4,tileSize/4);
  }
}
