class Board {
  float dx, dy, ofx, ofy, d;
  int cntx, cnty, bwidth, bheight, win;
  boolean turn;
  int[][] mass;
  
  Board(int nx, int ny, int x, int y) {
    cntx = nx;
    cnty = ny;
    bwidth = x;
    bheight = y;
    mass = new int[cntx + 4][cnty + 4];
    turn = false;
    dx = bwidth/cntx;
    dy = bheight/cnty;
    ofx = (width - bwidth)/2;
    ofy = (height - bheight)/2;
    d = min(dy, dx) - 5;
    win = 0;
  }
  
  void show() {
    if (win != 0) {
      if (win == 1) fill(0, 255, 0, 150);
      else if (win == 2) fill(255, 0, 0, 150);
      else fill(0, 204, 255, 150);
      noStroke();
      rect(ofx, ofy, bwidth, bheight);
    } else {
      if (turn) stroke(255, 0, 0);
      else stroke(0, 255, 0);
      strokeWeight(2);
      noFill();
      rect(ofx, ofy, bwidth, bheight);
    }
    
    for (int i = 0; i < cntx; i++) {
      for (int j = 0; j < cnty; j++) {
        stroke(51);
        fill(100);
        if (mass[i][j] == 1) fill(0, 255, 0);
        if (mass[i][j] == 2) fill(255, 0, 0);
        circle(ofx + i*dx + dx/2, ofy + j*dy + dy/2, d);
      }
    }
  }
  
  void add(float x, float y) {
    if (win == 0 && x >= ofx && x <= ofx + bwidth && y >= ofy && y <= ofy + bheight) {
      int i = int((x - ofx)/dx), j;
      for (j = cnty - 1; j >= 0; j--) {
        if (mass[i][j] == 0) break;
        if (j == 0) return;
      }
      if (turn) mass[i][j] = 2;
      else mass[i][j] = 1;
      if (!check()) {
        turn = !turn;
      }
    }
  }
  
  boolean check() {
    int cnt = 0;
    for (int i = 0; i < cntx; i++) {
      for (int j = 0; j < cnty; j++) {
        if (mass[i][j] == 0) {
          cnt++;
          continue;
        }
        boolean f1 = true, f2 = true, f3 = true, f4 = true;
        for (int k = 1; k <= 3; k++) {
          if (mass[i][j] != mass[i][j+k]) f1 = false;
          if (mass[i][j] != mass[i+k][j]) f2 = false;
          if (mass[i][j] != mass[i+k][j+k]) f3 = false;
          if (i < k || mass[i][j] != mass[i-k][j+k]) f4 = false;
        }
        if (f1 || f2 || f3 || f4) {
          win = mass[i][j];
          return true;
        }
      }
    }
    if (cnt == 0) {
      win = 3;
      return true;
    }
    return false;
  }
  
}
