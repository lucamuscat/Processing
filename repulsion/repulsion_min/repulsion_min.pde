import javax.swing.JOptionPane;
int timer=0;
int NegTimer=255;
boolean a,b=false;
PVector location =new PVector(300,300);
PVector push=new PVector(0,0);
void setup(){
  size(600,600);
  try{push.x= Integer.parseInt(JOptionPane.showInputDialog(null,"X:","0"));}catch(Exception e){push.x=0;}
  try{push.y= Integer.parseInt(JOptionPane.showInputDialog(null,"Y:","0"));}catch(Exception e){push.y=0;}
}
void draw(){
  background(51);
  fill(timer,NegTimer,timer);
  if(timer==255)a=true;
  if(timer==0)a=false;
  if(NegTimer==0)b=true;
  if(NegTimer==255)b=false;
  if(a==false)timer++;
  if(a==true)timer--;
  if(b==true)NegTimer++;
  if(b==false)NegTimer--;
  rect(location.x,location.y,32,32);
  borderControl();
  move();
  repel();
}
void moveLocation(){
  try{location = new PVector(Integer.parseInt(JOptionPane.showInputDialog(null,"X:","X")),Integer.parseInt(JOptionPane.showInputDialog(null,"Y:","Y")));}
  catch(Exception e){System.out.println("No value was inserted");}
}
void borderControl(){
  if(location.x>=width-35){
    location.x=width-35;
    push.x = push.x*-1;
  }
  if(location.x<=10){
    location.x=10;
    push.x=push.x*-1;
  }
  if(location.y>=height-35){
    location.y=height-35;
    push.y = push.y*-1;
  }
  if(location.y<=10){
    location.y=10;
    push.y=push.y*-1;
  }
}
void move(){
  location.x = location.x+push.x;
  location.y = location.y+push.y;
}
void repel(){
    if(mouseY==location.y && mouseX>=location.x && mouseX<=location.x+32)location.y = location.y +32;
    if(mouseY==location.y+32 && mouseX>=location.x && mouseX<=location.x+32)location.y = location.y -32;
    if(mouseX==location.x && mouseY>=location.y && mouseY<=location.y+32)location.x = location.x +32;
    if(mouseX==location.x+32 && mouseY>=location.y && mouseY<=location.y+32)location.x = location.x -32;
    if(mouseX<=location.x && mouseX>=location.x && mouseY<=location.y && mouseY>=location.y)location = new PVector(mouseX,mouseY); 
 } 