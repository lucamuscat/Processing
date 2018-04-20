import processing.sound.*;
FFT fft;
SoundFile file;
PGraphics maskImage;
PImage image;
PImage img2;
PShader blur;
AudioIn in;
color colour;
/*------------------------------------------------------------*/
int bands = 512;
int circleSize=0;
int l=0;
int w=450;
int h=450;
/*------------------------------------------------------------*/
float speed=0;
float i =0;
float timer=0;
float r;
float size;
float changer=1;
float addition=0.1;
float[] spectrum = new float[bands];
/*------------------------------------------------------------*/
ArrayList<PVector> locationHandler = new ArrayList<PVector>();
ArrayList<PVector> locations = new ArrayList<PVector>();
/*------------------------------------------------------------*/
PVector initialLocation;
PVector locationMouse=new PVector(-169, -165);
PVector location=new PVector(0, 0);
/*------------------------------------------------------------*/
Star s [] = new Star [450];
/*------------------------------------------------------------*/
boolean isPressed=false;
boolean isDone=false;
boolean isIntCircleDone=false;
/*------------------------------------------------------------*/


void setup() {
  //Sets the window to full screen size.
  fullScreen();
  //load the mp4 file.
  //loads the song file
  //file =  new SoundFile(this, "beats.mp3");
  //loads the background image.
  image=loadImage("backgroundphoto.jpg");
  image.resize(width,height);
  //image.filter(BLUR,6);
  //loads the front image.
  img2=loadImage("foreground.jpg");
  //resizes the front image and background image.
  img2.resize(w, h);
  maskImage = createGraphics(w, h);
  translate(width/2,height/2);
  maskImage.beginDraw();
  maskImage.ellipse(90, 90, 180, 180);
  maskImage.endDraw();
  img2.mask(maskImage);

  //initialzing background stars
  for (int i = 0; i<s.length; i++) {
    s[i]=new Star();
  }
  //initializing fft for audio analysis
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  in.start();
  //Allow the window to be resizable
  //surface.setResizable(true);
  //This allows both audio channels to be played.
  //file.pan(0);
  //Volume
  //file.amp(0.75);
  // patch the SoundFile
  //fft.input(file);
  //Patch the microphone
  fft.input(in);
  image.filter(BLUR,6);
  frameRate(48);
}
void draw() { 
  image(image, 0, 0);
  starField();
  pushMatrix();
  translate(width/2+75, height/2+50);
  //Uncomment this to rotate middle image.
  //rotate(degrees(i/150));
  image(img2, locationMouse.x, locationMouse.y);
  popMatrix();
  /*
  timer+=changer;
   if (timer>255)changer*=-1;
   if (timer<0)changer*=-1;
   */
  //This time restriction was placed so that the colour territories can be identified.
  if (frameCount>120) {
    fft.analyze(spectrum);
    i+=0.1;
    locationHandler.add(new PVector(location.x, location.y));
    if (isIntCircleDone==false) {
      locations.add(new PVector(location.x, location.y));
    }
    if (locations.size()>4) {
      //println((int)initialLocation.x+", "+(int)initialLocation.y+"\n"+(int)location.x+", "+(int)location.y);
    }
    if (locations.size()>2 && isDone==false) {
      initialLocation = locations.get(1);
      isDone=true;
    }
    if (locations.size()>4 && (int)location.x >= (int)initialLocation.x-20 && (int)location.x<= (int)initialLocation.x+20 && (int)location.y>=(int)initialLocation.y-20 && (int)location.y<=initialLocation.y+20 && isIntCircleDone==false) {
      circleSize=locations.size();
      isIntCircleDone=true;
    }
    println();
    float mapColour=0;
    for (int k=0; k<locations.size(); k++) {
      PVector a = locations.get(k);
      if (location.x>=a.x-10 && location.x<=a.x+10 && location.y>=a.y-10 && location.y<=a.y+10) {
        //This code finds in which section the moving object is. Each section will be associated with a colour.
        //findSector(ArrayList<PVector>a,PVector b)
        switch(findSector(locations, location)) {
        case 0:
          //Red Channel
          mapColour = map(k, 0, (int)locations.size()/3, 100, 200);
          println("red:"+mapColour);
          colour=color(mapColour, 0, mapColour/1.5);
          break;

        case 1:
          //Blue channel
          if (findSector(locations, location)==1) {
            //Red channel
            mapColour = map(k, locations.size()/3, (int)locations.size()*2/3, 100, 200);
            println("blue:"+mapColour);
            colour=color(0, mapColour, mapColour/2);
          }
          break;
        case 2:
          //Green Channel
          if (findSector(locations, location)==2) {
            //Red channel
            mapColour = map(k, locations.size()*2/3, (int)locations.size(), 100, 200);
            println("green:"+mapColour);
            colour=color(mapColour/3, mapColour/2, mapColour);
          }
          break;

        default:
          println("The void of nothingness");
          break;
        }
      }
    }
    for (int i = 0; i<locationHandler.size(); i++) {
      addition=map(spectrum[l], 0, 0.009, 0.01, 0.2);
      PVector c = locationHandler.get(i);
      float test = map(spectrum[l], 0, 0.2, 0, 55);
      /*if(findSector(locations,location)==0){
       colour=color(mapColour+test,mapColour-test*2,0);
       }
       if(findSector(locations,location)==1){
       colour=color(0,mapColour+test,mapColour-test*2);
       }
       if(findSector(locations,location)==2){
       colour=color(mapColour-test*2,0,mapColour+test);
       }*/
      if (colour==0) {
        println("black :/");
        exit();
      }
      
      speed = map(spectrum[l], 0.01,0, 12,4);
      if (l!=locationHandler.size())l++;
      float h = height*spectrum[i]*-5;
      fill(colour);
      rect(c.x, c.y, 5, h);
    }

    location.x=width/2 + cos(i)*200;
    location.y=height/2 + sin(i)*200;

    if (locationHandler.size()>40) {
      locationHandler.remove(0);
    }
  }
}


int findSector(ArrayList<PVector>locations, PVector location) {
  int currentArrayIndex=0;
  for (int c=0; c<locations.size(); c++) {
    PVector a = locations.get(c);
    if (location.x>=a.x-10 && location.x<=a.x+10 && location.y>=a.y-10 && location.y<=a.y+10) {
      currentArrayIndex=c;
      break;
    }
  }
  float sector = ((float)currentArrayIndex/(float)locations.size())/3;
  //println("Size:"+size+", Current index:"+currentArrayIndex + "Current Index/Size="+currentArrayIndex/size);
  if (sector>0 && sector<0.1) {
    return 0;
  }
  if (sector>0.1 && sector <0.2) {
    return 1;
  }
  if (sector>0.2 && sector<0.3) {
    return 2;
  }
  /*
    0/3-A-1/3
   1/3-B-2/3
   2/3-C-3/3
   */

  return 2;
}

void starField() {
  pushMatrix();
  translate(width/2, height/2);
  for (int i =0; i<s.length; i++) {
    s[i].show();
    s[i].update();
    s[i].z-=speed;
    println(speed);
  }
  popMatrix();
}
void mousePressed(){
  /*
  file.play();
  fft.input(file);
  */
}
