player player1=new player(new PVector(0, 300)); //<>// //<>// //<>//
FOmethods methods = new FOmethods();
boolean isDPressed=false;
boolean isAPressed=false;
ArrayList <functionObject> functionTimeline = new ArrayList<functionObject>();
long startTime;
long endTime;
boolean tick=false;
boolean tick2=false;
int frCount=0;
int speed=3;
int i =0;
/*
  *0:LEFT
 *1:RIGHT
 */
functionObject timeline[];
void setup() {
  size(600, 600);

  try {
    timeline=methods.loadFromTextFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}
void draw() {

  background(255);
  loadReplay();
  //recordReplay();
  /*
  
   */
}
void recordReplay() {
  player1.showPlayer();
  if (isAPressed) {
    player1.move(-speed);
  }
  if (isDPressed)player1.move(speed);
}
void loadReplay() {
  functionObject c = timeline[i];
  player1.showPlayer(); //<>//
  switch(c.getFunctionID()) {
    //id = 0
  case functionObject.A:
    if (frCount<framesRequired(c.getFunctionDuration())) {
      player1.move(-speed); //<>//
    } 
    else{
      if (i<timeline.length-1) {
        try { //<>//
          i++;
          frCount=0;
        }
        catch(Exception e) {
          e.printStackTrace();
        }
      }else{player1.move(0);}
    }

      //frameCount=0;
      
      break;
//id = 1
  case functionObject.D:
    println("ID:"+c.getFunctionID());
    int framesRequired = framesRequired(c.getFunctionDuration());
    println(framesRequired);
    if (frCount<framesRequired) {
      player1.move(speed); //<>//
    } else {
      if (i<timeline.length-1) {
        try {
          i++;
          frCount=0;
        }
        catch(Exception e) {
          e.printStackTrace();
        }
      }else{player1.move(0);}
      //frameCount=0;
      
    }
    break;
  }
  frCount++;
}

void keyPressed() {
  switch(key) {
  case 'a':
    isAPressed=true;
    if (!tick)
      startTime = currentTime();
    tick=true;
    break;

  case 'd':
    isDPressed=true;
    if (!tick)
      startTime =currentTime();
    tick=true;
    break;
  case 'e':
    try {
      methods.saveObject(functionTimeline);
    }
    catch(Exception e) {
      e.printStackTrace();
    } 
    exit();
    break;
  }
}
void keyReleased() {
  switch(key) {
  case 'a':
    tick=false;
    isAPressed=false;
    endTime=currentTime();
    pushTimeline(endTime-startTime, 0);
    break;

  case 'd':
    tick=false;
    isDPressed=false;
    endTime=currentTime();
    pushTimeline(endTime-startTime, 1);
    break;
  }
}
long currentTime() {
  return System.currentTimeMillis();
}
void pushTimeline(long duration, int functionID) {
  functionTimeline.add(new functionObject(duration, functionID));
}
int framesRequired(long duration) {
  System.out.println("fr working:"+Math.round(60f*(duration/1000f)));
  return Math.round(60f*(duration/1000f));
}