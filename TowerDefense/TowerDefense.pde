static int tileSize = 20;
//everything else in terms of tileSize
static int width = tileSize * 32;
static int height = tileSize * 25;
static int gameWidth = tileSize * 26;
static int menuXcor = gameWidth + 1;
static int menuWidth = width - menuXcor;

//2D array grid stores tiles
Tile[][] grid = new Tile[26][25];

//store path
Path path;

//array of tower types to be implemented later
int[] towerType = new int[3];

//keep track of tile mouse is on
Tile currentTile = null;

//ArrayList of towers
ArrayList<Tower> towerList = new ArrayList<Tower>();

//ArrayList of enemies
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();

//ArrayList of bullets
ArrayList<Bullet> bulletList = new ArrayList<Bullet>();

//hash table of number of hits done to enemies
HashMap<Enemy,Integer> enemyHits = new HashMap<Enemy,Integer>();

void setup(){
  size(width, height);
  //initialize grid
  for (int r=0; r < grid.length; r++) {
    for (int c=0; c < grid[0].length; c++) {
      grid[r][c]= new Tile(r,c);
    }
  }
  //initialize path
  PathPart [] pathway = new PathPart[]{new PathPart(0,1),
  new PathPart(21,1),
  new PathPart(21,7),
  new PathPart(2,7),
  new PathPart(2,13),
  new PathPart(21,13),
  new PathPart(21,19),
  new PathPart(0,19)};
  path = new Path(pathway);
}

//highlight border of tile mouse is on
void highlightTile() {
  int x = (int) (mouseX / tileSize);
  int y = (int) (mouseY / tileSize);
  //check if mouse within game window
  if (x <grid.length && y < grid[0].length) {
    currentTile = grid[x][y];
    currentTile.highlight();
  }  
}

//build a tower if mouse is clicked
void mousePressed() {
 if (currentTile != null && currentTile.canBuild()) {
   //println("new PathPart (" + currentTile.getX() + "," + currentTile.getY() + "),");
   currentTile.buildTower(new Tower(currentTile.getX(),currentTile.getY()));
 } 
}

void draw() { 
  //green background
  background(0,255,0);
  
  //grey menu
  stroke(0);
  fill(200);
  rect(menuXcor,0,menuWidth,height);
  
  //brown path
  stroke(184,134,11);
  fill(184,134,11);
  int W = gameWidth-6*tileSize;
  for (int k=1; k<=4; k++) {
    rect(2*tileSize,(6*k-5)*tileSize,W,tileSize);
  }
  rect(W+tileSize,20,tileSize,tileSize*6);
  rect(2*tileSize,tileSize*7,tileSize,tileSize*6);
  rect(W+20,tileSize*13,tileSize,tileSize*6);
  rect(0,tileSize,2*tileSize,tileSize);
  rect(0,tileSize*19,2*tileSize,tileSize);
  
  //highlight outline of tile that mouse is on
  highlightTile();
  
  //draw towers
  for (int k = 0; k<towerList.size(); k++) {
    towerList.get(k).drawTower();
    if (Math.random() < .01) {
      towerList.get(k).shoot();
    }
  }
  
  //draw enemies
  for (int i = 0; i<enemyList.size(); i++) {
    enemyList.get(i).move();
  }
  
  //draw bullets
  for (int n = 0; n<bulletList.size(); n++) {
    bulletList.get(n).move();
  }
  updateHits();
  
  for (Enemy E : enemyList) {
    E.setHP(E.getHP() - (int)(enemyHits.get(E)*1.5));
  }
  
  for (int i = 0; i < enemyList.size(); i++) {
    if (enemyList.get(i).getHP() <= 0) {
      enemyList.get(i).die();
      i --;
    }
  }
}

//press a to add enemies
void keyPressed(){
 if (key == 'a') {enemyList.add(new Enemy());}
}


//leak enemies when they get to the end of the path
void leak(Enemy e) {
 enemyList.remove(e);
 //println("Enemy leaked!"); 
}
  
  void updateHits() {
    enemyHits.clear();
    for (Enemy E : enemyList) {
      enemyHits.put(E, new Integer(E.numHits()));
    }
  }



        
   

