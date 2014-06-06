public class Lane extends Path {
 //endPos denotes the end of a lane
  private int endPos;
  //dir denotes the direction an enemy travels down a lane
 private String dir;
 
 //constructor 
 //lanes are pieces of the path that enemies travel on
 //an enemy turns at the end of a lane
 public Lane(String d, PathPart p) {
   dir = d;
   if (dir.equals("up") || dir.equals("down")) {
     endPos = (tileSize*p.getY());
   }
  else {endPos = (tileSize*p.getX());}
 }
 
 //accessor
 public String getDir() {
   return dir;
 }
 
 //determine if an enemy needs to turn
 boolean needTurn(PathPart p) {
   if (dir.equals("up")) {return (endPos > p.getY());}
   if (dir.equals("down")) {return (endPos < p.getY());}
   if (dir.equals("left")) {return (endPos > p.getX());}
   else {return (endPos < p.getX());} //if dir.equals("right")
 }
}
