import processing.net.*;

Server s;
Client c1, c2;
int clients = 0;

void setup() {
    surface.setVisible(false);
    s = new Server(this, 1818);
}

void draw() {
    if (clients < 2) return;
    if (c1.available() > 0) {
        c2.write(c1.readString());
    }
    if (c2.available() > 0) {
        c1.write(c2.readString());
    }
}

void serverEvent(Server s, Client c) {
    println("We have a new client: " + c.ip());
    clients++;
    if (clients == 1) {
      c1 = c;
    }
    else {
      c2 = c;
      c1.write(1);
      c2.write(2);
    }
}
