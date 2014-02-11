import processing.pdf.*;

Table table; // This is a store of our data.

// We will simply load the data and make a static image.
// Consider rendering the image to a PDF 
// (see http://processing.org/reference/libraries/pdf/)
void setup() 
{
  // Size is width, height. Deactivate for PDF export
  size(1000, 800);

//print to PDF
 //size(1200, 1200, PDF, "ufo.pdf");

  // set the background color to white.
  background(0);
  


  // Load our inverted table data.  The header, tsv flags tell 
  // loadTable() how to interpret the data.
  table = loadTable("ufo4.tsv", "header, tsv");

//Cycle through all rows
  for (int r = 0; r < 5; ++r)
  {

  // Get row number 2 (you can get other rows)
  TableRow row = table.getRow(2);

  // Cycle through all of the columns in the row above.
  for (int i = 0; i < row.getColumnCount(); ++i)
  {
    // Get the floating point value at row, and column i
    float value = row.getFloat(i);
    
    


  stroke(55 * r, 200*(r+1), (r * 100));
    
    // Push a matrix to allow easy rotation.
    // See http://processing.org/tutorials/transform2d/
    pushMatrix();
  
    // Move yoru draw position to the center.
    translate(width / 2, height / 2);
      
    // Rotate around that draw position in equal increments.
    rotate(2 * row.getColumnCount() / (float)i + r);
    
    // Draw a horizontal line scaled by the value.  
    // No need to worry about the trig.  It will be rotated
    // by the transformation matrix.
    line(0, 250, (width / 2 * r + 40) * (value/120000000), 2);
    
    // Pop the matrix.
    popMatrix();
  }
  }
  
  // Exit the program for PDF print
  //println("Finished.");
  //exit();

}
