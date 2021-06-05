import java.util.*;

Button[] tools;
Square[][] grid;
boolean title = true;
void setup() {
  size(1280, 720);
  //create array of Button
  tools = new Button[13];
  for (int i = 0; i < 13; i++) {
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
  //title page
  if (title) {
    textAlign(CENTER);
    fill(0);
    textSize(90);
    text("Migraine My Brain", 640, 250);

    textSize(25);
    text("Have an enmity against numbers?" 
      + "\nHere’s a chance to put them in their place!", 640, 320);

    rectMode(CENTER);
    fill(255);
    rect(640, 460, 200, 100);

    textSize(60);
    fill(#0326FF);
    text("PLAY", 640, 480);

    textSize(20);
    fill(0);
    text("Created by:"
      + "\nThe Last Two Brain Cells at 2 AM" 
      + "\nShyne Choi and Annabel Zhang", 640, 600);
  } else {
    textAlign(LEFT);
    rectMode(CORNER);

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

    check();

    for (Button b : tools) {
      b.display();
    }
  }
}
/*
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
 if (b.isSelected()) {
 //setValue(b.getValue());
 for (Button c : tools) {
 if (b != c){
 b.setSelected(false);
 }
 }
 }
 }
 }*/


void mousePressed() {
  if (mouseButton == LEFT) {
    if (title) {
      //center mode, rect: 640, 460, 200, 100
      //click play --> title = false;
      if (mouseX < 740 && mouseX > 540 && mouseY < 510 && mouseY > 410) {
        title = false;
      }
    } else {
      for (Button button : tools) {
        button.click();
        if (button.isSelected()) {

          //resetting (only works for state 1 atm)
          if (button.getValue() == 12) {
            for (int i = 0; i < 9; i++) {
              for (Square s : grid[i]) {
                if (s.getState() == 1 || s.getState() == 2)
                  s.setState(3);
              }
            }
          }

          for (int i = 0; i < 9; i++) {
            for (Square s : grid[i]) {

              s.click();
              if (s.isSelected() && s.getState() != 0) {

                for (Square[] a : grid) {
                  for (Square b : a) {
                    if (b != s) s.setSelected(false);
                  }
                }

                if (button.getValue() != 0 && button.getValue() != 10) { //not help or erase
                  s.setValue(button.getValue());
                  s.setState(1);
                } else if (button.getValue() == 10 && s.getState() != 4) {
                  s.setValue(0);
                  s.setState(3);
                }
              }
            }
          }
          for (Button c : tools) {
            if (button != c) {
              c.setSelected(false);
            }
          }
        }
      }
    }
  }
}

boolean check() {
  //change everything to original + player filled
  for (Square[] a : grid) {
    for (Square b : a) {
      if (b.getState() == 2) {
        b.setState(1);
      } else if (b.getState() == 4) {
        b.setState(0);
      }
    }
  }

  //check for duplicates
  for (int a = 0; a < 9; a++) {
    for (int b = 0; b < 9; b++) {
      //loop through the whole grid again, this time
      //specifically checking row/column/box
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (grid[a][b].getValue() != 0 && grid[i][j].getValue() != 0) {            
            //row
            if (a == i && b != j && grid[a][b].getValue() == grid[i][j].getValue()) {
              if (grid[a][b].getState() != 0 && grid[a][b].getState() != 4) {
                grid[a][b].setState(2);
              } else {
                grid[a][b].setState(4);
              }
              if (grid[i][j].getState() != 0 && grid[i][j].getState() != 4) {
                grid[i][j].setState(2);
              } else {
                grid[i][j].setState(4);
              }
            }

            //column
            if (b == j && a != i && grid[a][b].getValue() == grid[i][j].getValue()) {
              if (grid[a][b].getState() != 0 && grid[a][b].getState() != 4) {
                grid[a][b].setState(2);
              } else {
                grid[a][b].setState(4);
              }
              if (grid[i][j].getState() != 0 && grid[i][j].getState() != 4) {
                grid[i][j].setState(2);
              } else {
                grid[i][j].setState(4);
              }
            }
          }
        }
      }
    }
  }

  //boxes
  for (int a = 0; a < 9; a++) {
    for (int b = 0; b < 9; b++) {
      //
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          int r = a - a % 3;
          int c = b - b % 3;
          if (grid[r + i][c + j].getValue() != 0 
            && grid[a][b].getValue() == grid[r + i][c + j].getValue() 
            && r + i != a && c + j != b) {
            if (grid[a][b].getState() != 0 && grid[a][b].getState() != 4) {
              grid[a][b].setState(2);
            } else {
              grid[a][b].setState(4);
            }
            if (grid[r + i][c + j].getState() != 0 && grid[r + i][c + j].getState() != 4) {
              grid[r + i][c + j].setState(2);
            } else {
              grid[r + i][c + j].setState(4);
            }
          }
        }
      }
      //
    }
  }

  return true;
}

void create() {
  //preset
  grid[0][0].setValue(6);
  grid[0][1].setValue(8);
  grid[0][5].setValue(7);
  grid[0][6].setValue(1);
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
        //System.out.println(grid[i][j].row + ", " + grid[i][j].col);
        grid[i][j].setState(0);
      }
    }
  }
}
