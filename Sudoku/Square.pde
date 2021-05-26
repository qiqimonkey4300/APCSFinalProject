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
    
  }
  
  void click() {
    
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
