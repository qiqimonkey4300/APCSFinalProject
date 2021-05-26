Button[] tools;
Square[][] grid;
void setup() {
  background(255);
  size(1280, 720);

  //grid
  stroke(0);
  for (int i = 0; i < 10; i++) {
    if (i % 3 == 0) {
      strokeWeight(4);
    } else {
      strokeWeight(1);
    }
    line(90 + 60 * i, 90, 90 + 60 * i, 630);
    line(90, 90 + 60 * i, 630, 90 + 60 * i);
  }

  //create array of Button
  tools = new Button[11];
  for (int i = 0; i < 11; i++) {
    tools[i] = new Button(i);
  }

  //create array of Square
  grid = new Square[9][9];
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      grid[i][j] = new Square(i, j);
    }
  }
}

void draw() {
  for (Button b : tools)
    b.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i = 0; i < 9; i++) {
      for (Square s : grid[i]) {
        s.click();
      }
    }
    for (Button b : tools){
      b.click();
    }
  }
}
