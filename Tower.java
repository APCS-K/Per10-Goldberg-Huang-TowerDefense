public class Tower{

    private int damage;
    private int range;
    private int speed;

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

}