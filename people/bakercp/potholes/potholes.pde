import processing.pdf.*;

Table table; // This is a store of our data.

PFont font;

// We will simply load the data and make a static image.
// Consider rendering the image to a PDF 
// (see http://processing.org/reference/libraries/pdf/)
void setup() 
{
  // Size is width, height.
  size(600, 600);

  //print to PDF
//  size(1200, 1200, PDF, "potholes_filled_select.pdf");

  // set the background color to black.
  background(0);

  font = createFont("Menlo Bold", 18);

  table = loadTable("POTHOLES_2.tsv", "header, tsv");

  for (int r = 0; r < table.getRowCount(); ++r)
  {

    TableRow row = table.getRow(r); //this is number of potholes filled

    float number = row.getFloat(0); // number collected
    int ward   = row.getInt(1); // our ward.
    float lat    = row.getFloat(2); // lat
    float lon    = row.getFloat(3); // lon

    float normNumber = norm(number, 0, 80);

    float normLat = norm(lat, 41.8673147, 41.9123159);
    float normLon = norm(lon, -87.685371, -87.611579);

    color normColor = lerpColor(color(255, 255, 0, 80), color(255, 0, 0, 200), normNumber);

    noFill();
    stroke(normColor);

    ellipse(normLon * width, 
    normLat * height, 
    normNumber * 40, 
    normNumber * 40);

    fill(255); // colored text

    textSize(normNumber * 18);
    text("" + ward, normLon * width + 6, normLat * height - 6);
  }
}

