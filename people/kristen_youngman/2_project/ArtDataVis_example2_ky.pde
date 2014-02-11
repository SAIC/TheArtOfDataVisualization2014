import processing.pdf.*;

Table table; // This is a store of our data.

// We will simply load the data and make a static image.
// Consider rendering the image to a PDF 
// (see http://processing.org/reference/libraries/pdf/)
void setup() 
{
  // Size is width, height.
  //size(1000, 1000);

  //print to PDF
    size(1200, 1200, PDF, "potholes_filled_select.pdf");

  // set the background color to black.
  background(0);

  // Set the stroke (line) color two white.
  //  stroke(random(255), random(255),random(255));



  // Load our inverted table data.  The header, tsv flags tell 
  // loadTable() how to interpret the data.
 // table = loadTable("potholes_inverted.csv", "header, csv");
  
    table = loadTable("potholes_inverted_select.csv", "header, csv");

  for (int r = 0; r < 5; ++r)
  {
    // Get row number 2 (you can get other rows)
    TableRow row = table.getRow(r); //this is number of potholes filled
    // TableRow row = table.getRow(11); //this is number of potholes filled

    // Cycle through all of the columns in the row above.
    for (int i = 0; i < row.getColumnCount(); ++i)
    {
      // Get the floating point value at row, and column i
      float value = row.getFloat(i);


      stroke(255, 255/(r+1), r*33);




      // Push a matrix to allow easy rotation.
      // See http://processing.org/tutorials/transform2d/
      pushMatrix();

      // Move yoru draw position to the center.
      translate(width / 2, height / 2);

      // Rotate around that draw position in equal increments.
      rotate(2 * PI * row.getColumnCount() / (float)i);

      // Draw a horizontal line scaled by the value.  
      // No need to worry about the trig.  It will be rotated
      // by the transformation matrix.
      line(0, 0, (width / 2 + 40)* value, 0);

      // Pop the matrix.
      popMatrix();
    }
  }
}

