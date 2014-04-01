// =============================================================================
//
// Copyright (c) 2009-2014 Christopher Baker <http://christopherbaker.net>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// =============================================================================

import processing.video.*;
import processing.serial.*; 
import java.util.Timer;
import java.util.Vector;
import java.io.UnsupportedEncodingException;


TwitterSimpleSearch simpleSearch;

Vector<Vine> vines = new Vector<Vine>();
int currentVine = 0;
int x=0;
int y=0;

Movie mov = null;
int X = 0;

void setup() {
  size(48*3*3, 48*3*3);
  frameRate(30);
  background(0);

  String query = "vine.co/v"; // Search for tweets that include the word "love"
  int searchPollInterval = 30 * 1000; // Search every 30 seconds.

  // To use, go to https://dev.twitter.com/ and register a new application.
  // Call it whatever you like.  Normally people might make an application 
  // for others to use, but this one is just for you.
  //
  // Make sure the application has read AND write settings.  Make sure your
  // tokens and keys also have read AND write settings.  If they don't,
  // regenerate them.

  String oAuthConsumerKey = "eh2impXc14zcGoUhwCgkCd3cS";
  String oAuthConsumerSecret = "XoYrMRn4tJYk3spFVn9HpxHRL2DeVCpoBoq1hLJAe0q0NMRA9i";
  String oAuthAccessToken = "2422499467-rAlX7zfRFu7y1jPlRMk20yjgM0IAoLnI6x4xvhz";
  String oAuthTokenSecret = "ZrFm1QKFdtR2wef9OoOH5iTKbYpYXITYyTeGHQeyTKyAR";

  simpleSearch = new TwitterSimpleSearch(this, query, 30 * 1000, oAuthConsumerKey, oAuthConsumerSecret, oAuthAccessToken, oAuthTokenSecret);
}  

void draw() {
  
  if (mov != null) {
    if (mov.available() || abs(mov.time() - mov.duration()) > 0.01) {
      mov.read();
      tint(128,5);
      image(mov,x,y,48*3,48*3);
    }
    else
    {
      mov = null; // clear movie
      x+=48*3;
      if(x>width-48*3)
      {
        x=0;
        y+=48*3;
        
      }
      if(y>height-48*3)
      {
        x=0;
        y=0;
        background(0);
      }
    }
  }
  else
  {
    if ( vines.size() > currentVine)
    {
      Vine vine = vines.get(currentVine);

      mov = new Movie(this, "media/" + vine.getId() + ".mp4");
      mov.play();

      currentVine++;
    }
  }
}

void newTweets(Vector<Status> tweets) {
  for (Status tweet : tweets)
  {

    if (!tweet.isRetweet())
    {
      Vector<String> urls = Utils.parseUrls(tweet.getText());

      for (String url : urls)
      {

        try
        {
          byte[] rawBytes = loadBytes(url);
          String html = new String(rawBytes, "UTF-8");

          Vine vine = Utils.parseVine(html);

          if (vine != null)
          {
            rawBytes = loadBytes(vine.getImgURL());
            saveBytes("data/media/" + vine.getId() + ".jpg", rawBytes);

            rawBytes = loadBytes(vine.getVidURL());
            saveBytes("data/media/" + vine.getId() + ".mp4", rawBytes);

            vines.add(vine);
          }
        }
        catch(UnsupportedEncodingException exc)
        {
        }
      }
    }
  }
}

