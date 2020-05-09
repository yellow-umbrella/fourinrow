import processing.net.*;

final int x = 630, y = 330;
Client c;
Board board;
boolean turn;

void setup() {
  size(640, 360);
  c = new Client(this, "127.0.0.1", 1818);
  while(c.available() == 0) {
    delay(500);
  }
  turn = c.read()==1;
  board = new Board(7, 6, x, y);
}

void draw() {
  background(51); 
  board.show(turn);
  if (c.available() > 0) {
    int t = c.read();
    if (t == 100) {
      board = new Board(7, 6, x, y);
    } else {
      board.add(t);
    }
  }
}


void mousePressed() {
  if (turn == board.turn) {
    int t = board.getColumn(mouseX, mouseY);
    if (t > -1) {
      board.add(t);
      c.write(t);
    }
  }
}

void keyPressed() {
  if (keyCode == 32 && board.win != 0) {
    c.write(100);
    board = new Board(7, 6, x, y);
  }
}
