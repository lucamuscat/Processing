class player{
  PVector location= new PVector(300,300);
  int ogy;
  player(PVector location){
    this.location=location;
    ogy=Math.round(location.y);
  }
  public void showPlayer(){
    fill(0);
    rect(location.x,location.y,10,50);
  }
  public void move(int dir){
    location.x+=dir;
  }
  public void jump(){
    location.y+=5;
    if(location.y>ogy){
      location.y-=1;
    }
  }

}