// Lerp example

color firstColor = color(255, 0, 0, 255); // The first color to interpolate from
color secondColor = color(255, 255, 0, 0); // The second color to interpolate to

void setup()
{
  size(400, 400);
}


void draw()
{  
  background(255); // Set a white background

  float normMouseX = norm(mouseX, 0, width); // convert mouse position to a 0-1 range (normalized)

  // Make a lerped project.
  color mouseColor = lerpColor(firstColor, secondColor, normMouseX);

  // Disable the rectangle stroke.
  noStroke();
  // Fill with the interpolated color from the mouse. 
  fill(mouseColor);

  // Create a rectangle with a width that depends on the position of the cursor.
  rect(0, 0, width * normMouseX, height);
}

