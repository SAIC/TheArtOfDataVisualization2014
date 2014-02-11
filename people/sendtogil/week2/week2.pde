Table table;
color firstColor = color(255,0,0,255);
color secondColor = color(255,255,0,0);

void setup() 
{
  size(1204, 740);
  background(20);
  stroke(0);

  text("feels right", 60, 40);
  text("feels wrong", 60, 60);
  fill(12, 138, 178);
  rect(45, 30, 7, 10);
  fill(178, 168, 21);

  rect(45, 50, 7, 10);

  table = loadTable("truthiness.tsv", "header, tsv");

  // get column 1
  //println(table.getStringColumn(1));
  // or we can get column 2 by it's name
  //println(table.getStringColumn("feels wrong"));
  //this is how to get row count
  //println(table.getRowCount());


  //for (int i = 0; i < 100; ++i)
  for (int i = 0; i < table.getRowCount(); ++i)

  {
    int value1 = table.getInt(i, 1);
    int value2 = table.getInt(i, 2);

    pushMatrix();

    translate(width / 2, height / 2);
    rotate(TWO_PI * table.getRowCount()/i);
    noStroke();
    fill(20, 50);
    ellipse(0, 0, 100, 100);

    fill(178, 168, 21, i/5);
    strokeWeight(1.5);
    stroke(178, 168, 21, i/5);
    ellipse(value2 * 12, 0, 5, 5);
    line(50, 0, value2*12, 0);
    textSize(10);
    text("wrong", value2 * 12 +7, 3);


    fill(12, 138, 178, i/2);
    stroke(12, 138, 178, i/2);
    ellipse(value1 * 6, 0, 7, 7);
    line(200, 0, value1*6, 0);
    textSize(9);
    fill(255, 68, 199, i/2);
    text("right", value1 * 6 +7, 3);
    popMatrix();
  }
}

void draw()
{
  float normMouseX = norm(mouseX, 0, width);
  float normMouseY = norm(mouseY, 0, height);
  
  color mouseColor = lerpColor(firstColor, secondColor, normMouseX);
  fill(mouseColor);
  rect(width-100,height-100,50,50);

}


