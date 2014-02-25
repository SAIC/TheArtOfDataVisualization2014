import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

import java.util.ArrayList;
import java.util.List;

Table stations;
Table crimes;

List<Location> crimeLoc = new ArrayList<Location>();
List<Marker> crimeMarks = new ArrayList<Marker>();

List<Location> divvyLoc = new ArrayList<Location>();
List<Marker> divvyMarks = new ArrayList<Marker>();

StringList allStops = new StringList();
StringList markedStops = new StringList();

UnfoldingMap map;

float totalCloseSpots;

void setup(){
  size(800, 800, P2D);
  map = new UnfoldingMap(this);
  MapUtils.createDefaultEventDispatcher(this, map);
  Location chicago = new Location(41.8819f, -87.6278f);
  map.zoomAndPanTo(chicago, 10);
  float maxPan = 10;
  map.setPanningRestriction(chicago, maxPan);

  stations = loadTable("Divvy_Stations_2013.csv", "header, csv");
  crimes = loadTable("Crimes-full-narcs-Map.csv", "header, csv");
  
  //crime map
  for (int i=0; i < crimes.getRowCount(); i++){
    TableRow row = crimes.getRow(i);
    float xPos = row.getFloat(14);
    float yPos = row.getFloat(15);
    //fill(255, 49, 49);
    crimeLoc.add(new Location(xPos, yPos));
    crimeMarks.add(new SimplePointMarker(crimeLoc.get(i)));
    crimeMarks.get(i).setColor(color(255, 49, 49));
  }
  //map.addMarkers(crimeMarks);
  
  //divvy map
  for (int j=0; j < stations.getRowCount(); j++){
    TableRow row = stations.getRow(j);
    float xPos = row.getFloat(1);
    float yPos = row.getFloat(2);
    String name = row.getString(0);
    //println(name);
    allStops.append(name);
    divvyLoc.add(new Location(xPos, yPos));
    divvyMarks.add(new SimplePointMarker(divvyLoc.get(j)));
    divvyMarks.get(j).setColor(color(66, 210, 224));
  }
  //map.addMarkers(divvyMarks);

  //test each divvy location for nearby busts
  for (int k = 0; k < divvyLoc.size(); k++){
    float closeCount = 0;
    //check each bust for distance
    for (int l = 0; l < crimeLoc.size(); l++){
      //if (abs(divvyLoc.get(k).x-crimeLoc.get(l).x) <= 0.00001 || abs(divvyLoc.get(k).y-crimeLoc.get(l).y) <= 0.00001)
      if (divvyMarks.get(k).getDistanceTo(crimeLoc.get(l)) <= 0.1)
      {
        closeCount ++;
        //println("divvy: "+k+"; crime: "+l+"; distance: "+ divvyMarks.get(k).getDistanceTo(crimeLoc.get(l)));
        map.addMarker(crimeMarks.get(l));
      }
    }
    if (closeCount >= 10){
      //5 makes 160 spots using abs(), 8 makes 83, 10 makes 51
      //10 makes 85 with <= 0.3
      //10 makes 16 with <= 0.1
      totalCloseSpots++;
      markedStops.append(allStops.get(k));
      map.addMarker(divvyMarks.get(k));
      closeCount = 0;
    }
  }
  println("total close: "+totalCloseSpots);
  println(markedStops);
}

void draw(){
  map.draw();
}
