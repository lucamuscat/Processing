class ball{
  float w,h;
  float dampning=0.75;
  float windPower;
  PVector mouse = new PVector(mouseX,mouseY);
  PVector loc,vel,acc;
  ball(float x,float y){
    this.w=32;
    this.h=32;
    this.loc = new PVector(x,y);
    this.vel = new PVector(0,1);
    this.acc = new PVector(0,1);
  }
  ball(){
  
  }
  void update(){
    loc.add(vel);
    vel.add(acc);

  }
  void velLimit(float yspeed){
    if(vel.y>yspeed){
      vel.y=yspeed;
      acc.y=yspeed/10;
    }    
  }
  void show(){
    fill(255);
    noStroke();
    ellipse(loc.x,loc.y,w,h);
  }
  //This code prevents an object from exiting the screen
void borderControl(){
  if(loc.x>=width-35){
    loc.x=width-35;
    vel.x = vel.x*-dampning;
  }
  if(loc.x<=10){
    loc.x=10;
    vel.x=vel.x*-dampning;
  }
  if(loc.y>=height-35){
    loc.y=height-35;
    vel.y = vel.y*-dampning;
  }
  if(loc.y<=10){
    loc.y=10;
    vel.y=vel.y*-dampning;
    
  }
}
void applyForce(PVector force){
  acc.add(force);
}
void followMouse(){
  loc.x=mouseX;
  loc.y=mouseY;
}
void releaseMouse(){
  loc.x=mouse.x;
  loc.y=mouse.y;
}
void wind(float f){
  windPower=f;
  applyForce(new PVector(windPower,0.0));
}
PVector getLoc(){
  return loc;
}
}