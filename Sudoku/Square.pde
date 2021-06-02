public class Square {
  int state, value, row, col;
  boolean selected;

  Square(int Row, int Col) {
    state = 3;
    value = 0;
    row = Row;
    col = Col;
    selected = false;
  }

  void display() {
    strokeWeight(3);
    if (state == 0) {
      fill(#000EFF);
      textSize(30);
      text(value, 110 + col * 60, 130 + row * 60);
    } else if (state == 1) {
      fill(#000000);
      textSize(30);
      text(value, 110 + col * 60, 130 + row * 60);
    } else if (state == 2) {
      fill(#FF0505);
      textSize(30);
      text(value, 110 + col * 60, 130 + row * 60);
    } else if (state == 4) {
      fill(#C20CF5);
      textSize(30);
      text(value, 110 + col * 60, 130 + row * 60);
    }
  }

  void click() {
    if (mouseY < 90 + 60 * (row + 1)
      && mouseY > 90 + 60 * row
      && mouseX < 90 + 60 * (col + 1)
      && mouseX > 90 + 60 * col) {
      selected = !selected;
    }
    //if (selected == true)System.out.println(row + ", " + col);
  }

  boolean isSelected() {
    return selected;
  }

  int getValue() {
    return value;
  }

  int getState() {
    return state;
  }
  
  boolean setSelected(boolean newSelected) {
    boolean temp = selected;
    selected = newSelected;
    return temp;
  }

  int setValue(int newValue) {
    int temp = value;
    value = newValue;
    return temp;
  }

  int setState(int newState) {
    int temp = state;
    state = newState;
    return temp;
  }
}
