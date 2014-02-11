import processing.pdf.*;

Table table; // This is a store of our data.

// We will simply load the data and make a static image.
// Consider rendering the image to a PDF 
// (see http://processing.org/reference/libraries/pdf/)
void setup() 
{
  // Size is width, height. Deactivate for PDF export
  size(1200, 1200);
  
  
  //print to PDF
  //size(1200, 1200, PDF, "sexOffenderspectrum.pdf");

  // set the background color to white.
  background(0);
  


  // Load our inverted table data.  The header, tsv flags tell 
  // loadTable() how to interpret the data.
  table = loadTable("transposed_caveins-graffiti.tsv", "tsv");

//Cycle through all rows
  for (int r = 0; r < 2; ++r)
  {

  // Get row number 2 (you can get other rows)
  TableRow row = table.getRow(r);

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
    rotate(2 * PI * row.getColumnCount() / (float)i + r);
    
    // Draw a horizontal line scaled by the value.  
    // No need to worry about the trig.  It will be rotated
    // by the transformation matrix.
    line(0, 0, (width / 2 + 40)* value/12, 0);
    
    // Pop the matrix.
    popMatrix();
  }
  }
  
  // Exit the program for PDF print
  //println("Finished.");
  //exit();

}
