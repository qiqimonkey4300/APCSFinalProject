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
    if (value == 0 && selected){
      fill(255, 100);
      rect(89, 89, 542, 542);
      fill(0);
      text("Here's how you play:", 95, 120);
      textSize(20);
      //scroll all the way down
      text(t, 95, 170);
    }
   }
    
  }
  
  void click(){
    //help (0)
    if (mouseX >= 1050 && mouseX <= 1100 && mouseY >= 185 && mouseY < 185+50){
      selected = !selected;
    }
   
  }
  
  int getValue(){
    return value;
  }
  
  boolean isSelected(){
    return selected;
  }
  
  //instructions text
  String t = "Sudoku starts off with a puzzle grid in which some" 
           + "\nnumbers already placed. A puzzle is complete when"
           + "\neach number from 1 to 9 appears only once in each"
           + "\nrow, column, and block.\n"
           + "\nSelect a cell/square, then tap a number to fill in the"
           + "\ncell. The same can be done to erase a square with the"
           + "\nerase tool";
  
}
