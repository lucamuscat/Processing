import javax.swing.JOptionPane;
rain rain []= new rain[Integer.parseInt(JOptionPane.showInputDialog(null,"Insert amount of rain drops"))];
boolean isMousePressed=false;
void setup(){
    fullScreen();
    for(int i =0;i<rain.length;i++){
      rain[i]=new rain();
    }
    println("Rainy");
  }

void draw(){
    background(0);
    for(int i = 0;i<rain.length;i++){
      rain[i].show();
      rain[i].update();
      rain[i].borderControl();
  }
} //<>//
void mousePressed(){
  isMousePressed=true;
  frameRate(1000);
}
void mouseReleased(){
  frameRate(60);
}
