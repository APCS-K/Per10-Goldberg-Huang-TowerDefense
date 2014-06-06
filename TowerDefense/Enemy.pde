public class Enemy {
  int xcor;
  int ycor;
  int onLane = 0;
  String dir;
  int speed = 1;
  
  public Enemy() {
    //create enemy at start of path
    PathPart p = path.getStart();
    xcor = p.getX();
    ycor = p.getY();
    dir = path.getDir(0);
  }
  
  void move() {
    //set pathStatus to know what to do next
    String pathStatus = path.checkPos(new PathPart(xcor,ycor),onLane);
    //leak enemy if it makes it to the end of the path
    if (pathStatus.equals("done")) {
      leak(this);
      return;
    }
    //change direction if enemy needs to turn
    else if (pathStatus.equals("next")) {
      onLane ++;
      dir = path.getDir(onLane);
    }
    //move/draw enemy
    if (dir.equals("up")) {ycor -= speed;}
    else if (dir.equals("down")) {ycor += speed;}
    else if (dir.equals("left")) {xcor -= speed;}
    else {xcor += speed;} //if (dir.equals("right"))
    fill(255,0,0);
    stroke(0);
    ellipse(xcor+tileSize/2,ycor+tileSize/2,tileSize/2,tileSize/2);
  }
  
  void die(){
    enemyList.remove(this);
  }
 
}
