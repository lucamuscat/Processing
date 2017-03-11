player player = new player(width/2,height-64);
platform platform = new platform();
float fps=60;
float framesPassed=0;
float prevFrames=0;
float seconds=0;
float movementSpeed=5;
int timesHit=0;
boolean isSet=false;
ArrayList <Float> jumpPeek = new ArrayList<Float>();
boolean isHit=false;
boolean isDPressed=false;
boolean jumped=false;
boolean isKeyPressed=false;
boolean isAPressed=false;
float jumpDistance=0;
PVector stickyLocation;
void setup() {
  size(700, 700);
  frameRate(fps);
}
void draw() {
  framesPassed++;
  background(51);
  player.show();
  player.update();
  player.borderControl();
  //Platform
  platform.show();
  platform.update();
  platform.borderControl();
  //Nightmare
  if (/*Min:X*/player.location.x >= platform.location.x &&/*Max:X*/ player.location.x <= platform.location.x+platform.w && /*Min:Y*/ player.location.y >= platform.location.y && /*Max:Y*/ player.location.y <= platform.location.y+platform.h) {
    if(!isHit){
    timesHit++;
    }
    isHit=true;
  } else {
    isHit=false;
  }
  float secondsToArrive=secondsToArrival(distance(player.location.x, platform.location.x), platform.speed.x);

  if(secondsToArrive<=secondsToArrival(514,24) && secondsToArrive>0){
    if(player.onGround()){
    player.jump();
    }
  }

  if(!player.onGround()){
    seconds=framesPassed/frameRate; //<>//
    prevFrames=framesPassed;
    player.move(5);
  }else{
    if(!isSet){
      stickyLocation=new PVector(player.location.x,player.location.y);
    }
    isSet=true;
    player.move(0);
    if(player.location.x>stickyLocation.x){
      player.move(platform.speed.x*-1);
    }else{
      seconds=0;
    }
  }
  textSize(48);
  text("Seconds to arrive:"+secondsToArrive+"\nTimes Hit:"+timesHit,0, height/2);
}
float distance(float x1, float x2) {
  return x2-x1;
}
float movementPerSecond(float speed) {
  return speed*frameRate;
}
float secondsToArrival(float distance, float speed) {
  //speed=distance/time
  float time = distance/movementPerSecond(speed);
  return time;
}
void keyPressed() {
  if (key=='w' && player.location.y>=height-player.h) {
    isAPressed=true;
    isKeyPressed=true;
  }
  isKeyPressed=true;   
  if (key=='a') {
    isAPressed=true;
  }
  if (key=='d') {
    isDPressed=true;
  }
}
void keyReleased() {
  if (key==' ' || key=='w') {
    isAPressed=false;
  }
  if (key=='a') {
    isAPressed=false;
    player.move(0);
  }
  if (key=='d') {
    isDPressed=false;
    player.move(0);
  }
}