---
layout: post
title:  "Live Data Vis examples"
date:   2014-03-25 00:00:00
categories: post
author: garhodes
---

</br></br>
<b>An ongoing list of Live Data examples, techniques, code sharing</b>
</br></br></br></br>
Here are two examples sited in the project description, a twitter visualizer that collects the top ten trends, then turns those trend terms into image icons via Google Image search, then places them around the smartphone viewer via the AR platform Layar.
</br></br></br></br>
Here is it on Layar (you can download the app and try it out): 
https://www.layar.com/layers/twittar
</br></br></br></br>
It is similar to spotCrime, which takes local crime data and geolocates it around the viewer based on their position:
https://www.layar.com/layers/spotcrime
</br></br></br></br>
The basis of twittar is two functions written in PHP-- one gets the current twitter trends for a location and the second runs those terms through Google Image search and collects the corresponding images.  For the application, these terms and images are stored in a SQL database and then accessed from the app, along with their GPS coordinates relative to the phone.
</br></br></br></br>
The two basic PHP functions can be seen here in this webversion-- note that the twitter trend grabbing is for the old API, to make it work now you would need to create an authorized account (see here, https://dev.twitter.com/docs/api/1.1/get/trends/place ):
</br></br></br></br>
<a href="http://saic.github.io/TheArtOfDataVisualization/people/garhodes/data/twittar_web.txt" target="_new">PHP code for trend-getting and image-getting</a>

</br></br></br></br>
Here's an openprocessing example of the original live visualization, the music visualizer.  In this case, the input is just the computer microphone.  With a little modification, this same code could be used to visualize any sort of data that could potentially be sensed through sound:
</br></br></br></br>
http://www.openprocessing.org/sketch/104067

</br></br></br></br></br></br></br></br>


