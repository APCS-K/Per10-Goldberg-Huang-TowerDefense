import java.util.ArrayList;

ArrayList<Tile> grid = new ArrayList<Tile>();

void setup() {
  size(360,640);
  fill(126);
  background(102);
}

void draw() {
  if (mousePressed) {
    rect(mouseX,mouseY,24,48);
  }
}


