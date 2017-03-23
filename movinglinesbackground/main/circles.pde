class circles{
boolean isBordered=false;
boolean isViewable=false;
PVector location=new PVector(200,200);
PVector velocity=new PVector(random(0.01,3),random(0.01,3));
float r=64;
color c = 51;
circles(){}
circles(float x,float y){
  this.location.x=x;
  this.location.y=y;
}
circles(float x, float y, PVector velocity,boolean isViewable){
  this.location.x=x;
  this.location.y=y;
  this.velocity=velocity;
  this.isViewable=isViewable;
}
circles(float x,float y,boolean isViewable){
  this.location.x=x;
  this.location.y=y;
  this.isViewable=isViewable;
}
void createLine(PVector shapeA,PVector shapeB,color c){
  stroke(c);
  //stroke(random(255),random(255),random(255));
  line(shapeA.x,shapeA.y,shapeB.x,shapeB.y);
}
void randomVel(){
  velocity=new PVector(random(0.01,3),random(0.01,3));
}
void spaz(){
  c=color(random(0,255),random(0,255),random(0,255));
}
void originalColour(){
  c=color(51);
}
void showCircles(){
  fill(c);
  if(isViewable==true){
  stroke(255);
  }else{
    stroke(51);
  }
  ellipse(location.x,location.y,r,r);
}
void update(){
  this.location.add(this.velocity);
}
void oppositeDirection(){
  this.velocity.mult(-1);
}
void changeViewable(){
  isViewable=!isViewable;
}
boolean borderControl(){
  isBordered=false;
  if(location.x>width){
    isBordered=true;
  }
  if(location.x<0){
    isBordered=true;
  }
  if(location.y>height){
    isBordered=true;
  }
  if(location.y<0){
    isBordered=true;
  }
  return isBordered;
}

}