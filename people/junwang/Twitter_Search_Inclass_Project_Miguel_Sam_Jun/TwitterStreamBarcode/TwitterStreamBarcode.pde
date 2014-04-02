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


//SPECIAL THANKS TO MR.BAKER FOR PROVDING SUCH GREAT CODES:

import java.util.concurrent.*;
import java.util.*;

TwitterSimpleStream simpleStream;

PFont font;

String[] terms = new String[] { 
  "life", "death"
};

int x = 0;
int y = 0;

int w= 1;
int h = 100;

Vector<Status> tweets = new Vector<Status>(); 
String currentTweet = "";

void setup() {
  size(800, 500);
  frameRate(20);
  background(0);
  smooth();

  ArrayList<String> queryTerms = new ArrayList<String>(); 

  for (String term : terms) 
  {
    queryTerms.add(term);
  }

  // To use, go to https://dev.twitter.com/ and register a new application.
  // Call it whatever you like.  Normally people might make an application 
  // for others to use, but this one is just for you.
  //
  // Make sure the application has read AND write settings.  Make sure your
  // tokens and keys also have read AND write settings.  If they don't,
  // regenerate them.

  String oAuthConsumerKey = "yQnILq7Nxrdf9xql4Z5QK9iip";
  String oAuthConsumerSecret = "h10C5ufwyMQHGYI4lWhrKzdYjE3uoYkJUUcBC6am6wvRZrec8J";
  String oAuthAccessToken = "84650453-J7ePmZrcnCMbgnU4i4xEQ9jqADpEzTw51kqsUB6oN";
  String oAuthTokenSecret = "nt38fdW4pzP3X2uJO36Ml19JgF0J3bGdtcEExHswfOUWK";

  simpleStream = new TwitterSimpleStream(this, queryTerms, oAuthConsumerKey, oAuthConsumerSecret, oAuthAccessToken, oAuthTokenSecret);

  font = createFont("Sans-Serif", 80);
  textFont(font);
}  

void draw() {
  fill(255);

  if (tweets.size() > 0 || currentTweet.length() > 0)
  {
    if (currentTweet.length() <= 0)
    {
      Status status = tweets.remove(0);
      currentTweet = status.getText();
    }

    Character c = currentTweet.charAt(0); // first

    if (currentTweet.length() > 1)
    {
      currentTweet = currentTweet.substring(1);
    }     
    else
    {
      currentTweet = "";
    } 


    if (c >=32 && c <=127)

    {
      x = x + w;

      if ( x > width)
      { 
        y = y+h;

        if (y > height)
        {
          y = 0;
        }

        x=0;
      }

      int f = (int)map (c, 32, 127, 0, 255);
      println(f);
      noStroke();
      fill(f/2,f/2, f);

      rect(x, y, w, h);
    }
  }
}

// Collections of new tweets arrive here and are added to the "tweets" vector
// The TwitterSearchApi delivers tweets here.
void newTweets(Vector<Status> newTweets) {
  tweets.addAll(newTweets);
}

