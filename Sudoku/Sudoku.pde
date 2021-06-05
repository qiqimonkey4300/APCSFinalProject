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

                if (button.getValue() > 0 && button.getValue() < 10) { //is a number button
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
  //make a random row;
  int[] oneRow = new int[]{1, 2, 3, 4, 5, 6, 7, 8, 9};
  Random a = new Random();

  for (int i = 0; i < 9; i++) {
    int rand = a.nextInt(oneRow.length);
    int temp = oneRow[i];
    oneRow[i] = oneRow[rand];
    oneRow[rand] = temp;
  }

  //make the other eight rows
  int[][] orig = new int[9][9];
  orig[0] = oneRow;

  for (int i = 1; i < orig.length; i++) {
    if (i % 3 == 0) {
      for (int j = 0; j < 8; j++) {
        orig[i][j] = orig[i - 1][j + 1];
      }
      orig[i][8] = orig[i - 1][0];
    } else {
      for (int j = 0; j < 6; j++) {
        orig[i][j] = orig[i - 1][j + 3];
      }
      for (int j = 0; j < 3; j++) {
        orig[i][j + 6] = orig[i - 1][j];
      }
    }
  }

  for (int[] i : orig) {
    System.out.println(Arrays.toString(i));
  }

  System.out.println();

  //insert for loop of however many times to change around rows and col sections (so randomizing boxes basically - hopefully)
  //helpCreate(orig);


  for (int i = 0; i < 20; i++) {
    int[][] origFinal = helpCreate(orig);

    for (int j = 0; j < 9; j++) {
      orig[j] = origFinal[j].clone();
    }
  }

  for (int[] i : orig) {
    System.out.println(Arrays.toString(i));
  }







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

int[][] helpCreate(int[][] orig) {
  //random 0 - 2 sections
  int[] rowSec = new int[]{0, 3, 6};
  Random y = new Random();

  for (int i = 0; i < 3; i++) {
    int rand = y.nextInt(3);
    int temp = rowSec[i];
    rowSec[i] = rowSec[rand];
    rowSec[rand] = temp;
  }

  //switch up 3-row sections & within each 3-row section
  int[][] origRowSecMix = new int[9][9];
  int[][] origRowMix = new int[9][9];
  for (int i = 0; i < 3; i++) {
    origRowSecMix[i * 3] = orig[rowSec[i]];
    origRowSecMix[i * 3 + 1] = orig[rowSec[i] + 1];
    origRowSecMix[i * 3 + 2] = orig[rowSec[i] + 2];

    //random 0 - 2 rows within 3-row section
    int[] rowNum = new int[]{0, 1, 2};
    Random y2 = new Random();

    for (int j = 0; j < 3; j++) {
      int rand = y2.nextInt(3);
      int temp = rowNum[j];
      rowNum[j] = rowNum[rand];
      rowNum[rand] = temp;
    }

    for (int j = 0; j < 3; j++) {
      origRowMix[i * 3 + j] = origRowSecMix[i * 3 + rowNum[j]];
    }
  }

  //switch rows and cols
  int[][] origSwitch = new int[9][9];
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      origSwitch[j][i] = origRowMix[i][j];
    }
  }

  //random 0 - 2 sections
  int[] colSec = new int[]{0, 3, 6};
  Random x = new Random();

  for (int i = 0; i < 3; i++) {
    int rand = x.nextInt(3);
    int temp = colSec[i];
    colSec[i] = colSec[rand];
    colSec[rand] = temp;
  }

  //switch up 3-col sections & within each 3-col section
  int[][] origColSecMix = new int[9][9];
  int[][] origColMix = new int[9][9];
  for (int i = 0; i < 3; i++) {
    origColSecMix[i * 3] = origSwitch[colSec[i]];
    origColSecMix[i * 3 + 1] = origSwitch[colSec[i] + 1];
    origColSecMix[i * 3 + 2] = origSwitch[colSec[i] + 2];

    //random 0 - 2 cols within 3-col section
    int[] colNum = new int[]{0, 1, 2};
    Random x2 = new Random();

    for (int j = 0; j < 3; j++) {
      int rand = x2.nextInt(3);
      int temp = colNum[j];
      colNum[j] = colNum[rand];
      colNum[rand] = temp;
    }

    for (int j = 0; j < 3; j++) {
      origColMix[i * 3 + j] = origColSecMix[i * 3 + colNum[j]];
    }
  }

  return origColMix;
}
