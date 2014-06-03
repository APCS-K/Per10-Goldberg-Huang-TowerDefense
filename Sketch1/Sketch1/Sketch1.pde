void setup() {
 background(102); 
 size(360,640);
}

void draw() {
  if (mousePressed) {
    rect(mouseX,mouseY, 24, 48);
  }
}


