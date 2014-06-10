import java.util.Stack;

static int tileSize = 20;
//everything else in terms of tileSize
static int width = tileSize * 32;
static int height = tileSize * 25;
static int gameWidth = tileSize * 26;
static int menuXcor = gameWidth + 1;
static int menuWidth = width - menuXcor;
//int wave = 1;
int money = 200;
int lives = 10;

//2D array grid stores tiles
Tile[][] grid = new Tile[26][25];

//store path
Path path;

//keep track of tile mouse is on
Tile currentTile = null;

//ArrayList of towers
ArrayList<Tower> towerList = new ArrayList<Tower>();

//ArrayList of nodes of enemies
ArrayList<Node<Enemy>> enemyList = new ArrayList<Node<Enemy>>();

//ArrayList of bullets
ArrayList<Bullet> bulletList = new ArrayList<Bullet>();

//hash table of number of hits done to enemies
HashMap<Enemy,Integer> enemyHits = new HashMap<Enemy,Integer>();

//stack of enemies in order to be sent out
Stack<Node<Enemy>> enemyStack = new Stack<Node<Enemy>>();

void setup(){
  size(width, height);
  //initialize grid
  for (int r=0; r < grid.length; r++) {
    for (int c=0; c < grid[0].length; c++) {
      grid[r][c]= new Tile(r,c);
    }
  }
  //initialize path
  /*allows for easy creation of new path:
  set appropriate background colors
  uncomment println line in mousePressed()
  select corners (turning points) of path, including start and end
  copy and paste output text below
  */
  PathPart [] pathway = new PathPart[]{new PathPart(0,1),
  new PathPart(21,1),
  new PathPart(21,7),
  new PathPart(2,7),
  new PathPart(2,13),
  new PathPart(21,13),
  new PathPart(21,19),
  new PathPart(0,19)};
  path = new Path(pathway);
  //create enemy tree
 createEnemyTree(16,5,4);
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
   money = money - 10;
 } 
}

void draw() {
  //if positive number of lives and all enemies dead, you win
 if (lives > 0 && enemyStack.empty() && enemyList.isEmpty()) {
  background(102);
  textSize(32);
  fill(0,255,0);
  text("YOU WIN!!!",tileSize*12,tileSize*12);
} 
  //if some enemies still alive, keep playing
  else if (lives > 0) {
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
  
  //shoot out enemy every 60 frames
  if (frameCount % 60 == 0 && !enemyStack.empty()) {enemyList.add(enemyStack.pop());};
  
  //draw towers
  for (int k = 0; k<towerList.size(); k++) {
    towerList.get(k).drawTower();
    if (Math.random() < .03) {
      towerList.get(k).shoot();
    }
  }
  
  //draw enemies
  for (int i = 0; i<enemyList.size(); i++) {
    enemyList.get(i).data.move(enemyList.get(i));
  }
  
  //draw bullets
  for (int n = 0; n<bulletList.size(); n++) {
    bulletList.get(n).move();
  }
  
  //update hash table of enemy hits
  updateHits();
  
  //update enemy scores
  //if child is hit, also decrease HP of parent and grandparent
  //extra damage done if multiple hits on one turn
  for (Node<Enemy> E : enemyList) {
    E.data.setHP(E.data.getHP() - (int)(enemyHits.get(E.data)*1.5));
    if (E.parent != null) {E.parent.data.setHP(E.parent.data.getHP() - (int)(enemyHits.get(E.data)*1.5));}
    if (E.parent != null && E.parent.parent != null) {E.parent.parent.data.setHP(E.parent.parent.data.getHP() - (int)(enemyHits.get(E.data)*1.5));}
  }
  
  //if enemy HP less than or equal to zero, enemy dies and money gained
  for (int i = 0; i < enemyList.size(); i++) {
    if (enemyList.get(i).data.getHP() <= 0) {
      money = money + enemyList.get(i).data.getPrice();
      enemyList.remove(i);
      i = i - 1;
    }
  }
  
  //display money and lives
  fill(0);
  textSize(16);
  //text("Wave: " + wave, menuXcor + tileSize, height - 6*tileSize);
  text("Money: " + money, menuXcor + tileSize, height - 4*tileSize);
  text("Lives: " + lives, menuXcor + tileSize, height - 2*tileSize);
}

//if lives less than or equal to zero, you lose
else {
  background(102);
  textSize(32);
  fill(255);
  text("YOU LOSE",tileSize*12,tileSize*12);
}
}

//press a to add enemies (for testing)
void keyPressed(){
 //if (key == 'a') {enemyList.add(new Enemy());}
 //if (key == 'a' && !enemyStack.empty()) {enemyList.add(enemyStack.pop());}
}


//leak enemies when they get to the end of the path, decrease lives by HP of enemy
void leak(Node<Enemy> e) {
  int hpLeft = e.data.getHP();
 enemyList.remove(e);
 //println("Enemy leaked!"); 
 lives = lives - hpLeft;
}
  
 
 //keep hash table of enemy hits each turn
 //allows tracking of multiple hits in one turn
  void updateHits() {
    enemyHits.clear();
    for (Node<Enemy> E : enemyList) {
      enemyHits.put(E.data, new Integer(E.data.numHits()));
    }
  }
 
 //create depth 2 tree of enemies
 //damage to parents will cause damage to parents and grandparents as well
 //higher generations are more powerful (have more HP)
 void createEnemyTree(int rootHP, int numChild, int divHP) {
   Tree<Enemy> enemyTree = new Tree(new Enemy(rootHP));
   enemyStack.push(enemyTree.root);
   int count = numChild;
   while (count > 0) {
     enemyTree.root.childList.add(new Node(new Enemy(rootHP / divHP), enemyTree.root));
     enemyStack.push(new Node(new Enemy(rootHP / divHP), enemyTree.root));
     count--;
   }
   count = numChild;
   for (Node<Enemy> child : enemyTree.root.childList) {
     while (count > 0) {
       child.childList.add(new Node(new Enemy(rootHP /divHP /divHP), child));
       enemyStack.push(new Node(new Enemy(rootHP / divHP / divHP), child));
       count--;
     }
   }
 }
   



        
   

