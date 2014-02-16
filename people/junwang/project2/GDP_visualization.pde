PFont titleFont;
Table table; 
float zoom = 1;
float angle = 0.0;

void setup() 
{
  size(1400, 800);
  smooth();
  rectMode(CENTER);
  strokeWeight(4);
  titleFont = loadFont("AdobeArabic-Bold-30.vlw");
}

void draw() {
  background(#1D353D);
  gdp();
  textAlign(CENTER);
  textFont(titleFont);
  text("Gross Domestic Product (GDP) by Countries in 2012", width/2, 80);
}

void gdp() {
  table = loadTable("GDP.tsv", "header, tsv");
  TableRow row = table.getRow(3);

  // Cycle through all of the columns in the row above.
  for (int i = 0; i < row.getColumnCount(); ++i)
  {
    // Get the floating point value at row, and column i
    float value = row.getFloat(i);

    // Push a matrix to allow easy rotation.
    // See http://processing.org/tutorials/transform2d/
    pushMatrix();

    // Move yoru draw position to the center.
    translate(width / 6*5, height / 6*4.5);
    
    // Rotate around that draw position in equal increments.
    rotate(3 * PI * row.getColumnCount() / (float)i);
    scale(zoom);
    rotate(angle);
    // Draw a horizontal line scaled by the value.  
    // No need to worry about the trig.  It will be rotated
    // by the transformation matrix.
    stroke((value % 255), (value % 155), (value % 155));
    line(0, 0, width*value/5000, 0);
    // Pop the matrix.
    popMatrix();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      zoom += .01;
    } 
    else if (keyCode == DOWN) {
      zoom -= .01;
    }else if (keyCode == RIGHT) {
      angle += .01;
    } else if (keyCode == LEFT) {
      angle -= .01;
    }
  }
  if (key == ' ') {
    zoom = 1;
  }
}

