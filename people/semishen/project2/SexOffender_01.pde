import processing.opengl.*;
int num=50;
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


class SexOffender{
  String [] p;
  int i;
  SexOffender(int _i){
    i=_i;
    p= dataLoad("Sex_Offenders.csv","header,csv",i);
    
  }
  
  void display(){
  float x, y;
  pushMatrix();
  translate(width/2,600-i*10,0);
  float Height=float(p[7]);
  rotateX(PI/2);
  beginShape();
  for(float angle=0;angle<=360;angle++){
    float rad=radians(angle);
    Height+=(float(p[8]))/1000;
    float noiseInx=50*myNoise(Height);
    x=(int(p[6])*3+noiseInx)*cos(rad);
    y=(int(p[6])*3+noiseInx)*sin(rad);
    if(int(p[3])==1){
    fill(int(p[8])/3,int(p[6])*1.2,255,70);
  } else if(int(p[3])==2){
    fill(255,int(p[6])*1.2,int(p[8])/3,70);
  }
    curveVertex(x,y);
  }
  endShape();
  popMatrix();
  }
  
String [] dataLoad(String filename, String extension, int rowNum){
  String [] newValue;
  Table table;
  table=loadTable(filename, extension);
  TableRow row=table.getRow(rowNum);
  newValue=new String[row.getColumnCount()];
  for(int i=0; i<row.getColumnCount(); i++) {
    String value=row.getString(i);
    newValue[i]=value;
  }
  return newValue;
}

float myNoise(float value){
  float noiseValue=pow(sin(value),3);
  return noiseValue;
}


}

