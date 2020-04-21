Board board;

void setup() {
  size(640, 360);
  board = new Board(7, 6, 630, 350);
}

void draw() {
  background(51); 
  board.show();
}


void mousePressed() {
  board.add(mouseX, mouseY);
}

void keyPressed() {
  if (keyCode == 32) {
    board = new Board(7, 6, 630, 350);
  }
}
