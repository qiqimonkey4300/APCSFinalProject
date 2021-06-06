public class Button {
  private boolean selected;
  private int value;
  private boolean clicked;

  Button(int Value) {
    value = Value;
    selected = false;
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    //1-9
    int x1 = 810;
    int y1 = 95;
    for (int i = 1; i <= 9; i++) {
      colorFill(x1, y1);
      rect(810, y1, 50, 50, 7);
      textSize(30);
      fill(0);
      text(i, 825, y1 + 35);
      y1 += 60;
      fill(255);

      //help
      colorFill(1050, 155);
      rect(1050, 155, 50, 50, 7);
      fill(0);
      text("?", 1070, 192);
      //instructions
      if (value == 0 && selected) {
        fill(255, 100);
        rect(89, 89, 542, 542);
        fill(0);
        text("Here's how you play:", 95, 120);
        textSize(18);
        //scroll all the way down
        text(t, 95, 170);
      }

      //erase
      colorFill(1050, 275);
      rect(1050, 275, 50, 50, 7);
      fill(0);
      text("E", 1067, 312);
      
      //pencil
      colorFill(1050, 395);
      rect(1050, 395, 50, 50, 7);
      fill(0);
      text("P", 1067, 433);
      
      //restart
      colorFill(1050, 515);
      rect(1050, 515, 50, 50, 7);
      fill(0);
      text("R", 1067, 551);
    }
  }

  void click() {
    //help (0)
    if (value == 0 && mouseX >= 1050 && mouseX <= 1050+50 && mouseY >= 155 && mouseY <= 155+50) {
      selected = !selected;
    }
    //erase (10)
    if (value == 10 && mouseX >= 1050 && mouseX <= 1050+50 && mouseY >= 275 && mouseY <= 275+50) {
      selected = true;
    } 
    //pencil (11)
    if (value == 11 && mouseX >= 1050 && mouseX <= 1050+50 && mouseY >= 395 && mouseY <= 395+50) {
      selected = true;
    } 
    //restart (12)
    if (value == 12 && mouseX >= 1050 && mouseX <= 1050+50 && mouseY >= 515 && mouseY <= 515+50) {
      selected = true;
    } 
    else {
      //1-9
      int x1 = 810; 
      int y1 = 95;
      for (int i = 1; i <= 9; i++) {
        if (value == i && mouseX >= x1 && mouseX <= x1+50 && mouseY >= y1 && mouseY <= y1+50) {
          selected = true;
          
        }
        y1 += 60;
      }
    }
  }

  void colorFill(int x, int y) {
    if (mouseX >= x && mouseX <= x+50 && mouseY >= y && mouseY <= y+50) {
      fill(200);
    }
    else {
      fill(255);
    }
  }

  int getValue() {
    return value;
  }

  boolean isSelected() {
    return selected;
  }

  boolean setSelected(boolean newSelected) {
    boolean temp = selected;
    selected = newSelected;
    return temp;
  }

  //instructions text
  String t = "Sudoku starts off with a puzzle grid in which some" 
    + "\nnumbers already placed. A puzzle is complete when each"
    + "\nnumber from 1 to 9 appears only once in each row,"
    + "\ncolumn, and block.\n"

    + "\nSelect a number, then tap a square to fill it in."
    + "\nChange the number being filled in by clicking a different #."
    + "\nThe same can be done to erase a square with the erase tool.\n"

    + "\nColor Codes:"
    + "\nBlue - preset/standard numbers"
    + "\nBlack - player filled"
    + "\nRed - incorrect fill-in resulting from a duplicate"
    + "\nPurple - a preset # that provides a contradiction";
}
