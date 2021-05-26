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
    //1-9
    int yval = 95;
    for (int i = 1; i < 10; i++){
      fill(255);
      rect(810, yval, 50, 50, 7);
      textSize(30);
      fill(0);
      text(i, 825, yval + 35);
      yval += 60;
      fill(255);
    //help
    rect(1050, 185, 50, 50, 7);
    fill(0);
    text("?", 1070, 222);
    //erase
    fill(255);
    rect(1050, 465, 50, 50, 7);
    fill(0);
    text("E", 1067, 503);
    //help
    if (value == 0 && selected)
      text("Here's how you play", 95, 95);
   }
    
  }
  
  void click(){
    //help (0)
    if (overHelp())
      selected = true;
   
  }
  
  boolean overHelp(){
    if (mouseX >= 1050 && mouseX <= 1100 &&
        mouseY >= 185 && mouseY < 185+50)
      return true;
    else
      return false;
  }
  
  int getValue(){
    return value;
  }
  
  boolean isSelected(){
    return selected;
  }
  
}
