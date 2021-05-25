public class Button {
  boolean selected;
  int value;
  
  Button(int Value) {
    value = Value;
    selected = false;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    int yval = 95;
    for (int i = 1; i < 10; i++){
      rect(810, yval, 50, 50, 7);
      textSize(30);
      fill(0);
      text(i, 825, yval + 35);
      yval += 60;
      fill(255);
    }
    

      
  }
  
  void click(){
    
  }
  
  int getValue(){
    return value;
  }
  
  boolean isSelected(){
    return selected;
  }
  
  
}
