Button[] tools;
Square[][] grid;
boolean title = true;
boolean finish = false;
boolean puzzleFinish = false;
ArrayList<Integer> puzzles = new ArrayList<Integer>();

void setup() {
  for (int i = 0; i < 10; i++) {
    puzzles.add(i);
  }

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
  } else if (puzzleFinish) {
    textAlign(CENTER);
    fill(0);
    textSize(90);
    text("Migraine My Brain", 640, 250);

    textSize(30);
    fill(#E815DE);
    text("Congratulations! You were able to complete this sudoku!", 640, 345);

    rectMode(CENTER);
    fill(255);
    rect(640, 460, 350, 100);

    textSize(60);
    fill(#0326FF);
    text("NEW GAME", 640, 480);

    textSize(20);
    fill(0);
    text("Created by:"
      + "\nThe Last Two Brain Cells at 2 AM" 
      + "\nShyne Choi and Annabel Zhang", 640, 600);
  } else if (!finish) {
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
    
    if (checkFinished()) {
      if (puzzles.size() > 0) {
        puzzleFinish = true;
      } else {
        finish = true;
      }
    }
  } else {
    //finish screen
    textAlign(CENTER);
    fill(0);
    textSize(90);
    text("Migraine My Brain", 640, 250);

    textSize(30);
    fill(#E815DE);
    text("Congratulations! You were able to complete all the puzzles."
      + "\nYou've drained our reservoir."
      + "\n"
      + "\nThanks for playing!", 640, 370);

    textSize(20);
    fill(0);
    text("Created by:"
      + "\nThe Last Two Brain Cells at 2 AM" 
      + "\nShyne Choi and Annabel Zhang", 640, 600);
  }
}

boolean checkFinished() {
  for (Square[] a : grid) {
    for (Square b : a) {
       if (b.getValue() == 0 || b.getState() == 2){
        return false;
      }
    }
  }
  System.out.println("finished");
  return true;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (title) {
      //center mode, rect: 640, 460, 200, 100
      //click play --> title = false;
      if (mouseX < 740 && mouseX > 540 && mouseY < 510 && mouseY > 410) {
        title = false;
      }
    } else if (puzzleFinish) {
      if (mouseX < 815 && mouseX > 465 && mouseY < 510 && mouseY > 410) {
        puzzleFinish = false;
        create();
        for (int i = 0; i < 9; i++) {
          for (Square s : grid[i]) {
            if (s.getState() == 0 && s.getValue() == 0) {
              s.setValue(0);
              s.setState(3);
            }
          }
        }
      }
    } else {
      for (Button button : tools) {
        button.click();
        if (button.isSelected()) {

          //new game
          if (button.getValue() == 11) {
            if (puzzles.size() > 0) {
              //create();
              for (int i = 0; i < 9; i++) {
                for (Square s : grid[i]) {
                  /*if (s.getState() == 0 && s.getValue() == 0) {
                    //s.setValue(0);
                    s.setState(3);
                  }
                }*/
                  s.setValue(0);
                  s.setState(3);
              }
            } 
            create();}
            else {
              finish = true;
            }
            button.setSelected(false);
          }

          //resetting
          if (button.getValue() == 12) {
            for (int i = 0; i < 9; i++) {
              for (Square s : grid[i]) {
                if (s.getState() == 1 || s.getState() == 2) {
                  s.setValue(0);
                  s.setState(3);
                }
              }
            }
            button.setSelected(false);
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
                  
                //newgame
                if (button.getValue() == 11) {
                    //create();
                    for (int j = 0; j < 9; j++) {
                      for (Square s1 : grid[j]) {
                        s1.setState(3);
                      }
                    }
                    create();
                }

                if (button.getValue() > 0 && button.getValue() < 10 && s.getState() != 4) { //is a number button
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
  int rand = (int)(Math.random() * puzzles.size());
  int x = puzzles.remove(rand);

  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      grid[i][j].setValue(allPuzzles[x][i][j]);
      if (grid[i][j].getValue() != 0) {
        grid[i][j].setState(0);
      }
    }
  }
}


//puzzles
int[][] grid1 = new int[][] { //easy
  {6, 8, 0, 0, 0, 7, 1, 0, 0}, 
  {0, 2, 0, 9, 1, 5, 8, 0, 7}, 
  {9, 0, 0, 6, 0, 3, 5, 2, 0}, 
  {0, 5, 6, 0, 0, 2, 0, 0, 0}, 
  {3, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 9, 2, 0, 6, 0, 0, 5, 8}, 
  {7, 0, 0, 0, 5, 6, 0, 8, 1}, 
  {0, 0, 8, 3, 4, 9, 0, 0, 6}, 
  {0, 0, 0, 8, 0, 1, 4, 3, 0}};

int[][] grid2 = new int[][] { //medium
  {0, 0, 4, 8, 0, 7, 1, 0, 3}, 
  {0, 0, 3, 0, 0, 9, 5, 0, 0}, 
  {0, 0, 0, 5, 3, 0, 8, 0, 4}, 
  {4, 0, 0, 0, 6, 2, 0, 3, 0}, 
  {7, 0, 6, 0, 8, 5, 0, 0, 0}, 
  {9, 8, 0, 0, 0, 0, 0, 5, 0}, 
  {0, 0, 5, 0, 0, 6, 3, 0, 2}, 
  {0, 0, 0, 0, 0, 8, 0, 7, 0}, 
  {0, 0, 0, 7, 0, 0, 0, 0, 0}};

int[][] grid3 = new int[][] { //easy
  {9, 2, 0, 3, 4, 0, 0, 8, 0}, 
  {4, 7, 3, 8, 0, 1, 0, 0, 5}, 
  {8, 0, 0, 7, 0, 6, 0, 3, 4}, 
  {0, 8, 5, 0, 0, 9, 2, 0, 0}, 
  {0, 0, 9, 0, 0, 0, 4, 7, 0}, 
  {7, 3, 0, 0, 6, 0, 8, 0, 9}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 2}, 
  {3, 4, 0, 0, 0, 0, 0, 0, 1}, 
  {0, 0, 7, 2, 5, 4, 3, 6, 0}};

int[][] grid4 = new int[][] { //easy
  {9, 8, 0, 0, 0, 2, 3, 0, 0}, 
  {0, 0, 3, 5, 4, 9, 0, 7, 0}, 
  {0, 5, 0, 8, 3, 0, 4, 9, 6}, 
  {8, 0, 2, 0, 0, 0, 0, 0, 4}, 
  {7, 0, 5, 3, 0, 0, 1, 0, 2}, 
  {1, 9, 6, 0, 8, 0, 5, 0, 0}, 
  {0, 0, 9, 0, 6, 3, 8, 5, 1}, 
  {3, 7, 8, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 1, 0, 0, 0, 0, 0, 0}};

int[][] grid5 = new int[][] {  //medium
  {0, 0, 8, 1, 9, 6, 7, 0, 3}, 
  {1, 0, 0, 0, 3, 0, 0, 0, 0}, 
  {0, 6, 0, 0, 0, 0, 2, 0, 0}, 
  {0, 0, 0, 2, 0, 0, 6, 0, 0}, 
  {0, 0, 7, 0, 8, 4, 5, 0, 0}, 
  {0, 0, 0, 0, 1, 0, 0, 2, 0}, 
  {4, 5, 0, 3, 0, 0, 0, 0, 2}, 
  {0, 3, 0, 0, 0, 9, 0, 8, 0}, 
  {9, 8, 2, 0, 6, 0, 0, 0, 4}};

int[][] grid6 = new int[][] { //easy
  {6, 1, 0, 0, 0, 0, 0, 5, 4}, 
  {3, 0, 8, 0, 0, 4, 0, 0, 7}, 
  {0, 0, 0, 0, 2, 0, 0, 1, 0}, 
  {0, 8, 0, 0, 0, 0, 0, 0, 3}, 
  {5, 0, 1, 2, 7, 0, 0, 0, 0}, 
  {0, 0, 0, 8, 0, 1, 0, 7, 0}, 
  {0, 0, 0, 0, 5, 0, 6, 3, 0}, 
  {9, 5, 3, 1, 0, 6, 7, 4, 0}, 
  {1, 7, 0, 4, 3, 2, 8, 9, 0}};

int[][] grid7 = new int[][] { //easy
  {0, 6, 0, 0, 0, 0, 4, 2, 0}, 
  {3, 0, 0, 0, 0, 8, 9, 0, 0}, 
  {0, 0, 7, 2, 4, 5, 6, 0, 0}, 
  {9, 0, 6, 3, 0, 4, 0, 0, 0}, 
  {0, 7, 3, 0, 1, 0, 2, 0, 0}, 
  {8, 5, 0, 0, 6, 2, 3, 4, 9}, 
  {0, 0, 4, 1, 2, 0, 0, 9, 8}, 
  {0, 0, 9, 0, 0, 3, 0, 6, 0}, 
  {6, 0, 0, 4, 0, 0, 1, 3, 0}};

int[][] grid8 = new int[][] { //medium
  {5, 7, 3, 0, 0, 0, 0, 9, 6}, 
  {0, 0, 6, 1, 0, 0, 0, 0, 0}, 
  {0, 2, 0, 3, 6, 0, 0, 4, 5}, 
  {0, 0, 0, 4, 0, 0, 3, 0, 0}, 
  {8, 0, 0, 0, 0, 6, 4, 2, 0}, 
  {0, 0, 4, 0, 0, 2, 0, 6, 0}, 
  {0, 5, 1, 6, 2, 7, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {4, 0, 0, 8, 0, 0, 2, 0, 7}};

int[][] grid9 = new int[][] { //easy
  {5, 0, 0, 1, 0, 6, 0, 0, 4}, 
  {0, 8, 0, 0, 4, 5, 3, 9, 0}, 
  {0, 0, 0, 8, 3, 2, 0, 5, 0}, 
  {3, 1, 0, 0, 8, 4, 6, 0, 2}, 
  {4, 0, 0, 0, 0, 0, 0, 3, 1}, 
  {2, 7, 0, 0, 0, 0, 0, 0, 9}, 
  {6, 2, 0, 0, 0, 8, 4, 0, 5}, 
  {8, 5, 1, 0, 0, 0, 7, 0, 3}, 
  {0, 4, 0, 5, 0, 0, 0, 2, 0}};

int[][] grid10 = new int[][] { //easy
  {0, 0, 4, 0, 0, 0, 0, 3, 9}, 
  {5, 1, 0, 0, 0, 3, 0, 0, 6}, 
  {0, 0, 0, 7, 9, 1, 5, 4, 2}, 
  {0, 7, 8, 6, 0, 9, 4, 5, 0}, 
  {0, 4, 3, 0, 0, 8, 2, 0, 0}, 
  {0, 5, 2, 0, 7, 0, 0, 0, 8}, 
  {2, 3, 0, 5, 0, 0, 0, 0, 0}, 
  {0, 9, 0, 0, 0, 7, 0, 2, 1}, 
  {4, 0, 7, 9, 0, 0, 3, 0, 0}};

int[][][] allPuzzles = new int[][][]{grid1, grid2, grid3, grid4, grid5, grid6, grid7, grid8, grid9, grid10};
