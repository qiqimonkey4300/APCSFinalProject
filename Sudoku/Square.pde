public class Square {
  int state, value;
  boolean selected;
  
  Square() {
    state = 3;
    value = 0;
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
