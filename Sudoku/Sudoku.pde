Button[] tools;
Square[][] grid;
void setup() {
  size(1280, 720);

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

  create();
}

void draw() {
  background(255);
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

  for (Square[] a : grid) {
    for (Square s : a) {
      s.display();
    }
  }
  for (Button b : tools) {
    b.display();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    for (int i = 0; i < 9; i++) {
      for (Square s : grid[i]) {
        s.click();
        if (s.isSelected()) {
          for (Square[] a : grid) {
            for (Square b : a) {
              if (b != s) s.setSelected(false);
            }
          }
        }
      }
    }
    for (Button b : tools) {
      b.click();
    }
  }
}

boolean check() {
  //for compile
  return true;
}

void create() {
  //preset
  grid[0][0].setValue(6);
  grid[0][1].setValue(8);
  grid[0][5].setValue(7);
  grid[0][1].setValue(1);
  grid[1][1].setValue(2);
  grid[1][3].setValue(9);
  grid[1][4].setValue(1);
  grid[1][5].setValue(5);
  grid[1][6].setValue(8);
  grid[1][8].setValue(7);
  grid[2][0].setValue(9);
  grid[2][3].setValue(6);
  grid[2][5].setValue(3);
  grid[2][6].setValue(5);
  grid[2][7].setValue(2);
  grid[3][1].setValue(5);
  grid[3][2].setValue(6);
  grid[3][5].setValue(2);
  grid[4][0].setValue(3);
  grid[5][1].setValue(9);
  grid[5][2].setValue(2);
  grid[5][4].setValue(6);
  grid[5][7].setValue(5);
  grid[5][8].setValue(8);
  grid[6][0].setValue(7);
  grid[6][4].setValue(5);
  grid[6][5].setValue(6);
  grid[6][7].setValue(8);
  grid[6][8].setValue(1);
  grid[7][2].setValue(8);
  grid[7][3].setValue(3);
  grid[7][4].setValue(4);
  grid[7][5].setValue(9);
  grid[7][8].setValue(6);
  grid[8][3].setValue(8);
  grid[8][5].setValue(1);
  grid[8][6].setValue(4);
  grid[8][7].setValue(3);

  //setting states to original
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (grid[i][j].getValue() != 0) {
        grid[i][j].setState(0);
      }
    }
  }
}
