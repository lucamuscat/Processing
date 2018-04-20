import java.util.ArrayList; //<>//
import javax.swing.JOptionPane;
PGraphics circleLayers;
PGraphics lineLayers;
boolean isPressed=false;
boolean isViewable=false;
ArrayList <circles> circleArrayList = new ArrayList <circles>();
ArrayList <circles> lines = new ArrayList<circles>();
void setup() {
  size(600, 600);
  circleLayers=createGraphics(width,height);
  lineLayers = createGraphics(width,height);
  
  for(int i =0;i<22;i++){
   circleArrayList.add(new circles(random(0,width),random(0,height)));
   }
}
void draw() {
  background(51);
  println(lines.size());
  circleLayers.beginDraw();
  circleConnector();
  circleLayers.endDraw();
}
void circleConnector(){
  //This loop will go through all of the current circles
  for (int i = 0; i < circleArrayList.size(); i++) {
    circles circleEach = circleArrayList.get(i);
    //Show the circles
    circleEach.showCircles();
    //Makes the circles move
    circleEach.update();
    //Checks if they ran out of the border
    circleEach.borderControl();
    //If a circle is out of the border, the following code will execute
    if (circleEach.borderControl()) {
      //Will remove a circle to save memory and space in the arraylist
      circleArrayList.remove(i);
      //Replace it with a new one in a random location.
      circleArrayList.add(new circles(random(0, width), random(0, height),new PVector(random(0.01,3),random(0.01,3)),isViewable));
    }
    //Another loop to check if the circles are 2r range away from each other.
    for (int j =0; j<circleArrayList.size(); j++) {
      circles circleItterated = circleArrayList.get(j);
      if (j==i) {
        continue;
      }
      //Checks the distance between them
      float d = dist(circleEach.location.x, circleEach.location.y, circleItterated.location.x, circleItterated.location.y);
      //If the mouse hovers over the circles, they change colour, the algorithm used is super accurate.
      //This will only work if they are viewable
      if (circleEach.isViewable==true&&mouseX<circleEach.location.x+circleEach.r/2 && mouseX>circleEach.location.x-circleEach.r/2
          && mouseY<circleEach.location.y+circleEach.r/2 && mouseY>circleEach.location.y-circleEach.r/2
          ) {
            circleEach.spaz();
          } else {
            circleEach.originalColour();
          }
      if (d<circleEach.r+circleItterated.r) {
        lines.add(new circles());
        //Controlls the lines created so that the program wouldnt be full of left over lines when they arent being used
        for (int x =0; x<lines.size(); x++) {
          circles lineController=lines.get(x);
          lineLayers.beginDraw();
          lineController.createLine(circleEach.location, circleItterated.location, color(255));
          lineLayers.endDraw();
          //Instantly remove the line, a new line is going to be generated instead of it anyway, might seem CPU intesive
          //But if this is inverted, the arraylist will clog up and it will heavily jam(ArrayList limits could be applied)
          
          if ((d<circleEach.r+circleItterated.r)) {
            lines.remove(x);
          }
          if (d<circleEach.r && circleEach.isViewable==true) {
            lineController.createLine(circleEach.location, circleItterated.location, color(random(0, 255), random(0, 255), random(0, 255)));
          }
          
        }
      }
    }
  }

  if (circleArrayList.size()>50) {
    circleArrayList.remove(0);
  }
}
void mousePressed() {
  isPressed=true;
}
void mouseReleased() {
  isPressed=false;
}
void keyPressed() {
  if (key==' ') {
    circleArrayList.add(new circles(random(0, width), random(0, height), new PVector(random(0.01, 3), random(0.01, 3)),isViewable));
  }
  if(key=='c'){
    for(int i =0;i<circleArrayList.size();i++){
      circleArrayList.remove(i);
    }
  }
  if(key=='v'){
    for(circles circ:circleArrayList){
      circ.changeViewable();
    }
    isViewable=!isViewable;
  }
}
void keyReleased() {
  //isPressed=false;
}