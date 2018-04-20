class player{
  PVector location,velocity,acceleration,gravity;
  float w,h;
  player(float Width, float Height){
    this.w=16;
    this.h=64;
    this.location= new PVector(width/2,height-h);
    this.gravity = new PVector(0,2);
    this.velocity= new PVector(0,0);
    this.acceleration=new PVector(0,0);
  }
  void show(){
    fill(255);
    rect(location.x,location.y,w,h);
  }
  void update(){
    velocity.add(gravity);
    location.add(velocity);
  }
  void borderControl(){
    if(location.x>width-w)location.x=width-w;
    if(location.x<0)location.x=0+w;
    if(location.y>height-h)location.y=height-h;
    if(location.y<0+h)location.y=0+h; 
  } 
  void jump(){
    velocity.y=-25;
  }
  void move(float dir){
    velocity.x=dir;
  }
  boolean onGround(){
    if(location.y>=height-h){
      return true;
    }else{
      return false;
    }
  }
}