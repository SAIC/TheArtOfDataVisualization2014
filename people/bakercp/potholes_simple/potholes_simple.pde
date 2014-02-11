PFont font;

void setup() 
{
  // Size is width, height.
  size(600, 600);

  // set the background color to black.
  background(0);

  font = createFont("Menlo Bold", 18);

  String[] lines = loadStrings("POTHOLES_2.tsv");

  for (int r = 1; r < lines.length; ++r) // we start with 1, because 0 is our header
  {
    String[] tokens = split(lines[r], "\t");
    
    float number = float(tokens[0]); // number collected
    int ward   = int(tokens[1]); // our ward.
    float lat    = float(tokens[2]); // lat
    float lon    = float(tokens[3]); // lon

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

