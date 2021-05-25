Button[] toolbar;
void setup() {
  background(255);
  size(1280, 720);
  
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
  
  //create arrays of Button and Square
  toolbar = new Button[11];
  for (int i = 0; i < 11; i++){
    toolbar[i] = new Button(i);
  }
}

void draw() {
  for (Button b : toolbar)
    b.display();
}

void mousePressed(){
}
