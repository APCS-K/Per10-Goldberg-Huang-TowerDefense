public class Path {
  PathPart [] path;
  Lane [] laneList;
  PathPart startPos;
  
  public Path() {
  }
  
 public Path (PathPart[] p) {
  path = p;
  //array to keep track of directions of each piece of the path
  String [] directions = new String[p.length-1];
  startPos = new PathPart(p[0].getX()*tileSize,p[0].getY()*tileSize);
  
  //trace through the tiles on the path, setting isPath to true
  //keep track of directions (could be optimized later)
  for (int i =0; i < p.length - 1; i++) {
    grid[p[i].getX()][p[i].getY()].isPath = true;
    int diff = p[i].getX() - p[i+1].getX();
    
    if (diff != 0) {//diff is in x values
      for (int k = 0; k<abs(diff); k++) {
        
        if (diff < 0) {//path goes right
          grid[p[i].getX()+k][p[i].getY()].isPath = true;
          directions[i] = "right";          
          }
          
        else {//path goes left
          grid[p[i].getX()-k][p[i].getY()].isPath = true;
          directions[i] = "left";
        }
      }
    }
    
    else {//diff is in y values
      diff = p[i].getY() - p[i+1].getY();
      
      for (int n = 0; n<abs(diff); n++) {
        if (diff < 0) {//path goes down         
          grid[p[i].getX()][p[i].getY()+n].isPath = true;
          directions[i] = "down";
        }
              
        else {//path goes up
          grid[p[i].getX()][p[i].getY()-n].isPath = true;
          directions[i] = "up";              
        }
      }
    }
  }
  
  if (p.length > 0) {
    grid[p[p.length-1].getX()][p[p.length-1].getY()].isPath = true;
  }
 
  //create array of lanes and corresponding directions 
  laneList = new Lane[directions.length];  
  for (int i = 0; i < laneList.length; i++) {
      laneList[i] = new Lane(directions[i], p[i+1]);
  }
} 

  //accessor
  public PathPart getStart() {
     return startPos;   
  }
  
  //return direction of lane
  String getDir(int i) {
    if (i < laneList.length) {return laneList[i].getDir();}
    else {return laneList[laneList.length - 1].getDir();}
  }

  //check if enemy is at end of lane or path
  String checkPos(PathPart p, int lane) {
   if (lane > laneList.length-1) {return "done";} //finished path
   boolean check = laneList[lane].needTurn(p);
   if (check) {return "next";} //turn
   else {return "stay";} //keep going
  }
}
