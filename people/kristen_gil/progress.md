#plan & thoughts




#links

	https://www.mapbox.com/tutorial-sherlock/

	http://www.washingtonpost.com/wp-srv/special/local/dc-recovered-guns/

	http://pmsol3.wordpress.com/2009/10/10/world-of-averages-populations-of-the-americas/

#idea

- dataset - sex offender list
	
	we may can use those columns : 
	
	block(geolocation), race, date of birth(zodiac)..
	
	
	- detail
	
		in block column, if there are many rows that have same st name -> normalize it
			
			e.g) many of 060XX S.ABC st -> 06000 S.ABC st, 06010 S.ABC st, 06020...


#progress

Feb/14 --- Gill

[download code](http://gillpark.com/sex_hole.zip)

I think we need better data set for either sexoffenders or pot holes.

thoese two data sets doesn't get along each other... :(

I'm thinking about chicagoan's average income or broken window report kinda stuff to correspond with the sexoffender one.

e.g) https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2

or do you have any better idea?

let me know, I will keep looking for interesting data sets.

---------------------

Feb/16 ---- Gill

Boundary data from geojason file is working

Code

```
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.data.*;

import java.util.List;

UnfoldingMap map;
float x, x1, y, y1, s, r;
Table sex_table, 
hole_table;

//coloring

color sex = color(255, 0, 0, 100);
color hole = color(0, 0, 255, 5);
List<Marker> countryMarkers;

void setup() 
{
  size(800, 600, P2D);

  //load tables and initialize map
  sex_table = loadTable("data/sex.tsv", "header, tsv");
  hole_table = loadTable("data/hole.tsv", "header, tsv");
  String mbTilesString = sketchPath("data/chicago.mbtiles");

  // map = new UnfoldingMap(this, x, y, its'width ,it's height, new MBTilesMapProvider(mbTilesString));
  map = new UnfoldingMap(this, new MBTilesMapProvider(mbTilesString));

  MapUtils.createDefaultEventDispatcher(this, map);
  map.setZoomRange(11, 15);
  map.zoomAndPanTo(new Location(41.875, -87.623), 12); // chicago location
  r = 5.0;


  //Load boundaries polygons and adds them as markers
  List<Feature> countries = GeoJSONReader.loadData(this, "nb2.geo.json");
  countryMarkers = MapUtils.createSimpleMarkers(countries);

  map.addMarkers(countryMarkers);
}


void draw()
{
  background(240);
  map.draw();

  // text for left conner
  text("sex offenders", 60, 40);
  text("pot holes", 60, 60);
  fill(sex);
  rect(45, 30, 7, 10);
  fill(hole);
  rect(45, 50, 7, 10);

  fill(sex);
  noStroke();

  s = map.getZoom()*0.001;

  for (int i = 0; i < sex_table.getRowCount(); ++i)
  {

    x = sex_table.getFloat(i, "latitude");
    y = sex_table.getFloat(i, "longitude");
    ScreenPosition loc = map.getScreenPosition(new Location(x, y));
    ellipse(loc.x, loc.y, r, r);
    //println(s);
  }
  /*
  fill(hole);
   for (int i = 0; i < hole_table.getRowCount(); ++i)
   {
   
   x = hole_table.getFloat(i, "LATITUDE");
   y = hole_table.getFloat(i, "LONGITUDE");
   int size = hole_table.getInt(i, "NUMBER OF POTHOLES FILLED ON BLOCK");
   
   ScreenPosition loc = map.getScreenPosition(new Location(x, y));
   ellipse(loc.x, loc.y, size, size);
   //println("ok");
   }
   */

  //this is how we get current info
  //println("Zoom : " + map.getZoomLevel()+ "  Geocode  :  "+map.getCenter());
}
```
