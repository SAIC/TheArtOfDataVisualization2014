Table table;
int dataMin, dataMax;
int[] data = new int[25];
float normalizedData;
int i = 0;
String[] theYear = new String[25];
PFont font;

void setup() {
  size(900, 700);
  background(255);
  smooth();
  font = loadFont("HelveticaNeue-32.vlw");
  textFont(font, 13);
  dataMin = MAX_INT;
  dataMax = MIN_INT;
  table = loadTable("CTA_-_Ridership_-_Annual_Boarding_Totals.csv", "header");
  for (TableRow row : table.rows()) {    
    //get the yearly boarding total for rail only
    int id = row.getInt("rail");
    //get the years
    String year = row.getString("year");
    //set the data into separate arrays.        
    data[i] = id;
    theYear[i] = year;
    //make it an indexable for loop
    i++;
    //println(i);
  }
  //figure out the data minumum and maximum
  for (int j = 0; j < data.length; j++)
  {
    if (data[j] < dataMin)
      dataMin = data[j];

    if (data[j] > dataMax)
      dataMax = data[j];
  }
  radialGraph();
}

void draw() {
}
void radialGraph() {
  //visualize the data 
  for (int j = 0; j < data.length; j++) {
    normalizedData = map(data[j], dataMin, dataMax, 100, width/3);
    float angle = map( j, 0, data.length, 0, 2*PI);
    //println(normalizedData);    
    pushMatrix();
    translate(width / 2, height / 2);    
    rotate(angle);
    fill(0);
    //text(j, normalizedData, 0);
    textSize(13);
    text(theYear[j] + ":  $ "+ data[j], normalizedData + 10, 0);    
    stroke(0, 100, 125, 200);    
    strokeWeight(2);
    line(0, 0, normalizedData, 0);
    popMatrix();
  }
  //title
  textSize(32);
  text("Anual Train Boarding Total Since 1983", width/2.6, height-30);
  line(0, height-20, width, height-20);
}

