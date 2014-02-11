import processing.pdf.*;

Table table; // This is a store of our data.
float[] population, elecAccess; 
float popMax;
int outputWidth, outputHeight;

// We will simply load the data and make a static image.
// Consider rendering the image to a PDF 
// (see http://processing.org/reference/libraries/pdf/)
void setup() 
{
  // Size is width, height. Deactivate for PDF export
  size(1200, 600);
  ellipseMode(CENTER);
  noStroke();
  noCursor();
  //print to PDF

  background(125);   // set the background color to white.
  textSize(16);   // set text to 16 px


  // Load our inverted table data.  The header, tsv flags tell 
  // loadTable() how to interpret the data.
  table = loadTable("World_Pop_Em_Elec.csv", "header");
  population = new float[table.getRowCount()]; // empty float array size of number of rows in table
  elecAccess = new float[table.getRowCount()]; // empty float array size of number of rows in table

  //Cycle through all rows
  for (int r = 0; r < table.getRowCount(); ++r) 
  {
    population[r] = table.getFloat(r, "Population"); // store population column into array
    elecAccess[r] = table.getFloat(r, "Elec Acc"); // store elecAccess column into array
  }

  for (int r = 0; r < table.getRowCount(); ++r) {// r is column
    population[r] = map(population[r], min(population), max(population), 10, height/2);
  }

 
}

void draw() {
  background(125);
 float maxPop = max(population); // get the maximum population
  float minPop = min(population); // get the minimum population
  float col= width/table.getRowCount()+20; // divide the canvas by numer of rows + 20 for margin

  for (int r = 0; r < population.length; r++) // r is column
  {

    fill(255, 50);
    ellipse(col, height/2, population[r], population[r]);


    col = col + width/table.getRowCount();


    if (dist(mouseX, 0, col, 0)<3) {
      fill(0);
      text(table.getString(r, "Country"), 100, 80);
      text(String.valueOf(table.getFloat(r, "Population")), 100+200, 80);
      text(String.valueOf(elecAccess[r])+" %", 100+400, 80);
      ellipse(col, height/2, population[r], population[r]);
      fill(255, 255, 0);
      ellipse(col, height/2, (table.getFloat(r, "Elec Acc")*population[r])/100, (table.getFloat(r, "Elec Acc")*population[r])/100);
    }
  }

  fill(90);  
  text("2010 | Source: World Data Bank", 100, height-40);
}



// println(max(elecAccess));
// Exit the program for PDF print
//println("Finished.");
//exit();

