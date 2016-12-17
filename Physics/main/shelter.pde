class shelter{
  float w,h;
  PVector mouse;
  PVector pos;
  shelter(){
    this.w=100;
    this.h=100;
    this.pos = new PVector(0,0);
  }

  void setPos(float x,float y){
    pos=new PVector(x,y);
  }
  void build(){
    
    rect(pos.x,pos.y,w,h);
  }
  public float getW(){
    return w;
  }
  public float getH(){
    return h;
  }
  PVector getPos(){
    return pos;
  }
}