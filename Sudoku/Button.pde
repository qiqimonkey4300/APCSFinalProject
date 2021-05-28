public class Button {
  boolean selected;
  int value;
  
  Button(int Value) {
    value = Value;
    selected = false;
  }
  
  void display() {
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
       //1
      
     }
     /*if (value == 1 && selected){
         println("1 was selected.");
     }*/
    
  }
  
  void click() {
    //help (0)
    if (value == 0 && mouseX >= 1050 && mouseX <= 1050+50 && mouseY >= 185 && mouseY <= 185+50){
      selected = !selected;
      //println(value);
    }
    else{
      //1-9
      int x1 = 810; int y1 = 95;
      for (int i = 1; i <= 9; i++){
        if (value == i && mouseX >= x1 && mouseX <= x1+50 && mouseY >= y1 && mouseY <= y1+50){
          selected = true;
          //println(value);
        }
        y1 += 60;
        
      }
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
           + "\nnumbers already placed. A puzzle is complete when"
           + "\neach number from 1 to 9 appears only once in each"
           + "\nrow, column, and block.\n"
           + "\nSelect a cell/square, then tap a number to fill in the"
           + "\ncell. The same can be done to erase a square with the"
           + "\nerase tool.\n"
           + "Color Codes:"
           + "Blue - preset/standard numbers"
           + "Black - player filled"
           + "Red - incorrect fill-in resulting from a duplicate"
           + "Purple - provides a contradiction but is preset";
  
}
