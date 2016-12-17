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
    noStroke();
    fill(48,136,174);
    //fill(0,255,0);
    rect(pos.x,pos.y,w,h);
  }
  void show2(){
    noStroke();
    fill(random(255),random(255),random(255));
    rect(pos.x,pos.y,w,h);
  }
  
  void update(){
    pos.add(vel);
    if(vel.y<1){
      vel=new PVector(0,random(0.0001,5));
      w=random(2,5);
      h=random(2,5);
    }
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