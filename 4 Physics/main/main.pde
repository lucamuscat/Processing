ball ball;
rain rain []= new rain[1500];

int i,j;
int seconds;
boolean isMousePressed=false;

final int SUNNY = 0;
final int CLOUDY = 1;
final float CLOUDY_WIND=0.0005;
final int RAINY = 2;
final float RAINY_WIND=0.005;
int weather= 0;
void setup(){
  size(800,800);
  switch(/*(int)random(0,3)*/RAINY){
    case SUNNY :
      weather = SUNNY;
      println("Sunny");
    break;
    case CLOUDY :
      weather=CLOUDY;
      for(int i =0;i<15;i++){
      rain[i]=new rain();
    }
      println("Cloudy");
    break;
    case RAINY :
      frameRate(60);
      weather=RAINY;
    for(int i =0;i<rain.length;i++){
      rain[i]=new rain();
    }
    println("Rainy");
  }

  ball = new ball(width/2,height/2);
  background(51);
}
shelter shelter = new shelter();
void draw(){
  if(/*Min*/ball.loc.x >= shelter.pos.x && /*Max*/ball.loc.x <= shelter.pos.x+shelter.getW() && ball.loc.y >= shelter.pos.y && ball.loc.y <= shelter.pos.y+shelter.getH()){
    ball.vel.normalize();
  }
  background(51);
  ball.update();  
  ball.show();
  ball.borderControl();

  if(isMousePressed==true){
    shelter.build(/*img*/);
  }
  if(weather==RAINY){
    for(i = 0;i<rain.length;i++){
      rain[i].show();
      rain[i].update();
      rain[i].borderControl();
     
    }
     ball.wind(RAINY_WIND);
  }
  if(weather==CLOUDY){
     for(i=0;i<15;i++){
      rain[i].show();
      rain[i].update();
      rain[i].borderControl();
     }
    ball.wind(CLOUDY_WIND);
  }
} //<>//
void mousePressed(){
  isMousePressed=true;
  shelter.setPos(mouseX,mouseY);
}