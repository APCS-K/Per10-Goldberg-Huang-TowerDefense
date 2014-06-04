import java.util.ArrayList;

public class Tower{

    private int damage;
    private int range;
    private int speed;
    private int price;
    private int xcor;
    private int ycor;

    public Tower(){
	    //Standard Tower
	    damage = 1;
	    range = 3; //tiles
	    speed = 1;
    }

    public Tower(int d, int r, int s){
	    //Modified Tower
	    damage = d;
	    range = r;
	    speed = s;
    }
    
    public int getPrice() {
        return price;
    }
    
    public ArrayList<Enemy> getEnemies() {
      //return enemies within range
	ArrayList<Enemy> retList = new ArrayList<Enemy>();
	return retList;
    }

    public void shoot() {
      for (Enemy e: getEnemies()) {
      //subtract health from enemies within range
      }
    }
}
