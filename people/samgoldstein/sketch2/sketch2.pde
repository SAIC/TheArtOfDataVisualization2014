  float rot= 0.1*PI;
  Table table, table2, table3;

void setup(){
  size(500, 500);
  rectMode(CENTER);
  //noStroke();
  table = loadTable("selfPortrait2.tsv", "header, tsv");
  table2 = loadTable("elevation.csv", "header, csv");
  table3 = loadTable("libhold.csv", "header, csv");

}

void draw(){
  
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot/30);
  data1();
  //fill(13, 150, 99);
  //rect(0, 0, 60, 60);
  translate(-width/2, -height/2);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot/-30);
  data2();
  //fill(199, 45, 80);
  //rect(0, 0, 40, 40);
  translate(-width/2, -height/2);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot/70);
  data3();
  //fill(39, 17, 203);
  //rect(0, 0, 20, 20);
  translate(-width/2, -height/2);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rot/27);
  data4();
  //fill(39, 17, 203);
  //rect(0, 0, 20, 20);
  translate(-width/2, -height/2);
  popMatrix();
  
  rot++;
  
}

void data1(){
  TableRow row = table.getRow(1);
    for (int i = 0; i < row.getColumnCount(); i++){
      float value = row.getFloat(i);
      pushMatrix();
      //translate(width/2, height/2);
      rotate(2*PI*row.getColumnCount() / (float)i);
      float colorBoy1 = map(i, 0, 1, 0, 255);
      stroke(73, 189, colorBoy1);
      line(0, 0, width * value, 0);
      popMatrix();
    }
}

void data2(){
  TableRow row = table2.getRow(2);
    for (int i = 0; i < row.getColumnCount(); i++){
      float value = row.getFloat(i);
      float useVal = map(value, 0, 100, 0, 1);
      pushMatrix();
      //translate(width/2, height/2);
      rotate(2*PI*row.getColumnCount() / (float)i);
      float colorBoy1 = map(i, 0, 1, 0, 255);
      stroke(colorBoy1, 73, 189);
      line(0, 0, width * useVal *0.8, 0);
      popMatrix();
    }
}

void data3(){
  TableRow row = table3.getRow(13);
    for (int i = 0; i < row.getColumnCount(); i++){
      float value = row.getFloat(i);
      float useVal = map(value, 0, 1201, 0, 1);
      pushMatrix();
      //translate(width/2, height/2);
      rotate(2*PI*row.getColumnCount() / (float)i);
      float colorBoy1 = map(i, 0, 1, 0, 255);
      stroke(189, colorBoy1, 73);
      line(0, 0, width * useVal /**0.6*/, 0);
      popMatrix();
    }
}

void data4(){
  TableRow row = table3.getRow(15);
    for (int i = 0; i < row.getColumnCount(); i++){
      float value = row.getFloat(i);
      float useVal = map(value, 0, 18604, 0, 1);
      pushMatrix();
      //translate(width/2, height/2);
      rotate(2*PI*row.getColumnCount() / (float)i);
      float colorBoy1 = map(i, 0, 1, 0, 255);
      stroke(colorBoy1, colorBoy1, 73);
      line(0, 0, width * useVal *0.8, 0);
      popMatrix();
    }
}
