import processing.pdf.*;

Table table; 


void setup() 
{
  size(800, 800);
  //size(800, 800, PDF, "output.pdf");
  background(0);

  table = loadTable("DailyBoarding_busandL.tsv", "header, tsv");

  for (int r = 0; r < 4; ++r)
  {
    TableRow row = table.getRow(r);
    for (int i = 0; i < row.getColumnCount(); ++i)
    {
      float value = row.getFloat(i);
      strokeWeight(1);
      stroke(255/(r+1), r*50, r*80);
      pushMatrix();
      translate(width / 2, height / 2);
      rotate(2 * PI * row.getColumnCount() / (float)i + r);
      line(0, 0, (width / 2 + 200)* value/3000000, 0);
      popMatrix();
    }
  }
  
}

