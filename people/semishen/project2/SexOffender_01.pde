import processing.opengl.*;
int num=2;
SexOffender [] people=new SexOffender[num];

void setup(){
  size(1400,720,OPENGL);
  background(0);
  //noStroke();
  frameRate(24);
  for(int j=1; j<num;j++){
    people[j]=new SexOffender(j);
  }
}

void draw(){
  background(0);
  float camZ=(height/2.0)/tan(PI*60.0/360.0);
  camera(mouseX,mouseY,camZ,
          width/2.0,height/2.0,0,
          0,1,0);
  for(int j=1; j<num;j++){
    people[j].display();
  }
  
}


