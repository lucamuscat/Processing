class platform{
  PVector location,speed;
  float w,h;
  
  platform(){
    this.w=64;
    this.h=64;
    this.speed=new PVector(1,0);
    this.location=new PVector(700-w,700-h);
  }
  
  void show(){
    fill(#FC2448);
    stroke(255);
    rect(location.x,location.y,w,h);
  }
  void update(){
    location.sub(speed);
  }
  void borderControl(){
    if(location.x<0){
      location.x=width;
      speed.x+=random(0.01,1);
    }
  }
}