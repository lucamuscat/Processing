//Testing inputs

import javax.swing.JOptionPane;

//i = testing counter
boolean a=false;
boolean b=false;
boolean isPressed=false;
int i=0;
int j=0;
int timer=0;
int NegTimer=255;
//Location of box

PVector location =new PVector(300,300);
//Movement of box

PVector push=new PVector(0,0);
float percentage =(255*100/600)/100;//42.0%
//Code that runs on initialization of the Screen (This only happens once)
void setup(){
  System.out.println(percentage);
  size(600,600);
  try{
    push.x= Integer.parseInt(JOptionPane.showInputDialog(null,"X:","0"));
  }catch(Exception e){
    push.x=0;
  }
  try{
    push.y= Integer.parseInt(JOptionPane.showInputDialog(null,"Y:","0"));
  }catch(Exception e){
    push.y=0;
  }
}
//Main code
void draw(){
  background(51);
  fill(timer,NegTimer,timer);
  
  
  
  //What these conditions do is that they invert the increment of timer or NegTimer
  if(timer==255){
    a=true;
  }
  if(timer==0){
    a=false;
  }
  if(NegTimer==0){
    a=true;
  }
  if(NegTimer==255){
    a=false;
  }
  if(a==false){
    timer++;
  }
  if(a==true){
    timer--;
  }
  if(b==true){
    NegTimer++;
  }
  if(b==false){
    NegTimer--;
  }
  stroke(255/8,255/4,255/2);
  rect(location.x,location.y,32,32);
  //Makes sure that the box doesnt exit the screen.
  borderControl();
  //Moves the box
  move();
  //Pushes the box away from the mouse.
  //if(!isMouseInCenter()){
    repel();
  //}
}
void moveLocation(){
  System.out.println();
  try{
    location = new PVector(Integer.parseInt(JOptionPane.showInputDialog(null,"X:","X")),Integer.parseInt(JOptionPane.showInputDialog(null,"Y:","Y")));
  }catch(Exception e){
    System.out.println("No value was inserted");
  }
}
void mousePressed(){
  //moveLocation();
  isPressed=true;
  /*if(isMouseInCenter() && isPressed==true){
    location.x=mouseX;
    location.y=mouseY;
  }*/
}
void mouseReleased(){
  isPressed=false;
}
void borderControl(){
  if(location.x>=width-35){
    location.x=width-35;
    push.x = push.x*-1;
    rotate(25);
  }
  if(location.x<=10){
    location.x=10;
    push.x=push.x*-1;
    rotate(PI/3);
  }
  if(location.y>=height-35){
    location.y=height-35;
    push.y = push.y*-1;
    rotate(25);
  }
  if(location.y<=10){
    location.y=10;
    push.y=push.y*-1;
    rotate(PI/3);
  }
}
//Moves the box according to the given velocity.
void move(){
  location.x = location.x+push.x;
  location.y = location.y+push.y;
}

void repel(){
  //Top part of the box
    if(mouseY==location.y && mouseX>=location.x && mouseX<=location.x+32){
        System.out.println("\fIn the box:"+i);
        i++;
        location.y = location.y +32;
    }
   //Lower Part
    if(mouseY==location.y+32 && mouseX>=location.x && mouseX<=location.x+32){
      System.out.println("\fIn the box:"+i);
      i++;
      location.y = location.y -32;
    }
  //Left Part
  if(mouseX==location.x && mouseY>=location.y && mouseY<=location.y+32){
      System.out.println("\fIn the box:"+i);
      i++;
      location.x = location.x +32;
    }
    //Right Part
    if(mouseX==location.x+32 && mouseY>=location.y && mouseY<=location.y+32){
      System.out.println("\fIn the box:"+i);
      i++;
      location.x = location.x -32;
    }
    if(mouseX<=location.x && mouseX>=location.x && mouseY<=location.y && mouseY>=location.y){
      location = new PVector(mouseX,mouseY);
    }
    
  }
  //In the center of the box.
  /*boolean isMouseInCenter(){
    if(mouseX>=location.x && mouseX<=location.x+32 && mouseY>=location.y && mouseY<=location.y+32){
      System.out.println("In center"+j);
      j++;
      return true;
      
    }else{
      return false;
    }
    
  }
  */