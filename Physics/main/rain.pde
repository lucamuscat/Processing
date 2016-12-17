class rain{
  PVector pos,vel,acc;
  float x,w,h,area;
  rain(){
    x=random(0,width);
    w=random(1,5);
    h=random(1,5);
    area=w*h;
    pos = new PVector(x,0);
    vel=new PVector(0,random(0.0001,5));
    acc=new PVector(0,random(1,20));  
  }
  
  void show(){
    fill(48,136,174);
    rect(pos.x,pos.y,w,h);
  }
  void update(){
    pos.add(vel);
    //vel.add(acc);
  }
  void borderControl(){
    if(pos.y>=height){
      vel.mult(0);
      acc.mult(0);
      acc.add(new PVector(0,1));
      vel=new PVector(0,random(0.0001,5));
      pos.y=-h;
    }
  }

}