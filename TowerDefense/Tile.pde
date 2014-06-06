public class Tile {
  
  private int xcor;
  private int ycor;
  //tower occupying tile (if any)
  private Tower localTower = null;
  //boolean determines if tile is part of path
  public boolean isPath = false;
  
  //constructor
  public Tile (int x, int y) {
    xcor = x;
    ycor = y;
  }
  
  //accessor
  public int getX() {
    return xcor;
  }
  
  //accessor
  public int getY() {
    return ycor;
  }
  
  //highlight outline of tile
  void highlight() {
    noFill();
    if (canBuild()) {stroke(0,110,0);}
    else {stroke(255,0,0);}
    rect(xcor*tileSize,ycor*tileSize,tileSize,tileSize);
  }
  
  //returns true if open space to build
  //only one tower per tile
  //no towers on path
  boolean canBuild() {
    return (localTower == null && !isPath); 
} 

  //adds new tower to towerList
  void buildTower(Tower t) {
    if (canBuild()){
      localTower = t;
      towerList.add(t);
    }
  }
}
