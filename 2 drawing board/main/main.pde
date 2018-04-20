import javax.swing.JColorChooser;
import java.awt.Color;
import java.awt.event.*;
//RClickMenu menu;
boolean isPressed=false;
boolean isPipetteActive=false;
color penColor = color(0);
color backgroundColor = color(255);
Color javaColor;
PVector location,toolLocation,box1,box2,box3,lineLocation,draggerLocation,pipetteLocation;
PImage img, pipette;
float r = 10;
float h = 100;
float radius=15;
int i =0;

color box1Color=  color(0);
void setup() {
  size(600, 600);
  img=loadImage("eraser.png");
  pipette=loadImage("pipette.jpg");
  background(backgroundColor);
  surface.setResizable(true);
  draggerLocation=new PVector(width/2.5+radius/2, height-50);
  //menu = new RClickMenu(150, 250, 0);
  //Build the first menu.
}

void draw() {
  //right click menu menu.draw();
  initializeLocations();
  i++;
  stroke(penColor);
  strokeWeight((distance(lineLocation.x, draggerLocation.x)*58)/338);
  fill(255);
  if (isPressed && mouseY<height-h &&  !isPipetteActive && mouseX>100 ) {
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  strokeWeight(1);

  secondaryControlPanel();
  primaryControlPanel();
}
void initializeLocations(){
  pipetteLocation=new PVector (0,height/10+10);
  toolLocation=new PVector(0, 0);
  draggerLocation = new PVector(draggerLocation.x, height-50);
  location=new PVector(0, height-h);
  box1=new PVector(width/10+10, height-75);
  box2=new PVector(width/4.5+10, height-75);
  box3=new PVector(width/3+10, height-75);
  lineLocation=new PVector(width/2+10, height-50);
}
void primaryControlPanel() {
  //Primary  control Panel box
  fill(255);
  stroke(0);
  rect(location.x, location.y, width, h);

  //Pen Colour box
  stroke(0);
  fill(penColor);
  rect(box1.x, box1.y, 45, 45);
  //Background Colour box
  fill(backgroundColor);
  rect(box2.x, box2.y, 45, 45);
  //Rubber Box
  stroke(0);
  image(img, box3.x, box3.y, 45, 45);
  //clickEvent
  if (isMouseInObject(box3, 45, 45) && isPressed) {
    penColor=backgroundColor;
  }

  //Scale line
  stroke(0);
  line(lineLocation.x, lineLocation.y, lineLocation.x+(width-lineLocation.x-10), lineLocation.y);
  //Beginning and end of line design
  //Beginning line
  stroke(0);
  line(lineLocation.x, lineLocation.y+10, lineLocation.x, lineLocation.y-10);
  //End of line
  stroke(0);
  line(lineLocation.x+(width-lineLocation.x-10), lineLocation.y+10, lineLocation.x+(width-lineLocation.x-10), lineLocation.y-10);
  if (draggerLocation.x<lineLocation.x) {
    draggerLocation.x=lineLocation.x+radius/2;
  }
  //Dragable circle
  if (isPressed && mouseX>lineLocation.x+radius/2 && mouseX<lineLocation.x+(width-lineLocation.x-radius/2) && mouseY>lineLocation.y-10 && mouseY<lineLocation.y+10) {
    draggerLocation.x=mouseX;
  }
  fill(255);
  stroke(0);

  ellipse(draggerLocation.x, draggerLocation.y, radius, radius);
  //Distance: Min:6 -- Max:338
}
void secondaryControlPanel() {
  fill(255);
  stroke(0);
  rect(toolLocation.x, toolLocation.y, 100, height);

  //Pipette
  stroke(0);
  image(pipette, pipetteLocation.x+45/2, pipetteLocation.y, 45, 45);
  //pipette clickEvent
  if (isMouseInObject(new PVector(pipetteLocation.x+45/2,pipetteLocation.y), 45, 45) && isPressed) {
    isPipetteActive=true;
    isPressed=false;
  }
  if (isPipetteActive) {
    //fill(get(mouseX,mouseY));
    noFill();
    noStroke();
    penColor=get(mouseX, mouseY);
    if (isPressed) {
      isPipetteActive=false;
    }
  }
}
boolean isMouseInObject(PVector location, float boxWidth, float boxHeight) {
  boolean isTrue=false;
  if (mouseX>location.x && mouseX<location.x+boxWidth && mouseY>location.y && mouseY<location.y+boxHeight) {
    isTrue=true;
  } else {
    isTrue=false;
  }
  return isTrue;
}
float distance(float x1, float x2) {
  float answer;
  if (x1>x2) {
    answer=x1-x2;
  } else {
    answer=x2-x1;
  }


  return answer;
}
void mousePressed() {
  isPressed=true;
  if (isMouseInObject(box1, 45, 45)) {
    javaColor= JColorChooser.showDialog(null, "Java Color Chooser", Color.white);
    if (javaColor!=null) 
      penColor = color(javaColor.getRed(), javaColor.getGreen(), javaColor.getBlue());
    isPressed=false;
  }

  if (isMouseInObject(box2, width/15, height/15)) {
    javaColor= JColorChooser.showDialog(null, "Choose you colour.", Color.white);
    if (javaColor!=null) {
      backgroundColor = color(javaColor.getRed(), javaColor.getGreen(), javaColor.getBlue());
    }
    isPressed=false;
    background(backgroundColor);
  }
  if (mouseButton == LEFT) { 
    //menu.hideMenu();
  } else if (mouseButton == RIGHT) { 
    //menu.showMenu( mouseX, mouseY );
  }
}
void mouseReleased() {
  isPressed=false;
}