import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;
import twitter4j.*;
import twitter4j.conf.*;
import processing.core.*;
import java.lang.reflect.Method;

public class TwitterSimpleSearch extends TimerTask
{
  PApplet parent;
  Method newTweetsMethod;

  TwitterFactory tf;

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

  String query = "beach";

  long sinceId = -1;

  int maxTweetsToReturn = 100;

  Timer twitterPollTimer = new Timer();

  int searchPollInterval = 30 * 1000; // 30 seconds


  TwitterSimpleSearch(PApplet parent, 
  String query,
  int searchPollInterval, 
  String oAuthConsumerKey, 
  String oAuthConsumerSecret, 
  String oAuthAccessToken, 
  String oAuthTokenSecret)
  {
    this.parent = parent;
    this.query = query;
    
    this.searchPollInterval = searchPollInterval;
    this.oAuthConsumerKey = oAuthConsumerKey;
    this.oAuthConsumerSecret = oAuthConsumerSecret;
    this.oAuthAccessToken = oAuthAccessToken;
    this.oAuthTokenSecret = oAuthTokenSecret;
    
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setDebugEnabled(true)
      .setOAuthConsumerKey(oAuthConsumerKey)
        .setOAuthConsumerSecret(oAuthConsumerSecret)
          .setOAuthAccessToken(oAuthAccessToken)
            .setOAuthAccessTokenSecret(oAuthTokenSecret);
    tf = new TwitterFactory(cb.build());

    try {
      newTweetsMethod = parent.getClass().getMethod("newTweets", 
      new Class[] { 
        Class.forName("java.util.Vector")
      }
      );

      twitterPollTimer.schedule(this, 0, searchPollInterval);
    } 
    catch (Exception e) {
      System.out.println("Where is the newTweets method?");
    }
  }

  public void run() {
    Twitter twitter = tf.getInstance();
    Query searchQuery = new Query(query);
    searchQuery.count(maxTweetsToReturn); // num tweets per poll
    searchQuery.sinceId(sinceId); // specify our last tweet, to return only new
    searchQuery.resultType(Query.RECENT); // real time only
    //GeoLocation chicago = new GeoLocation(41.878247, -87.629767);
    //searchQuery.geoCode(chicago, 50, Query.MILES);

    // more about search queries 
    // http://twitter4j.org/javadoc/twitter4j/Query.html
    // http://twitter4j.org/en/code-examples.html

    Vector<Status> tweets = new Vector<Status>();

    try {
      QueryResult result = twitter.search(searchQuery );
      for (Status tweet : result.getTweets()) {
        sinceId = Math.max(sinceId, tweet.getId());
        tweets.add(tweet);
      }

      if (newTweetsMethod != null) {
        newTweetsMethod.invoke(parent, new Object[] { 
          tweets
        } 
        );
      }
    } 
    catch(Exception exc) {
      exc.printStackTrace();
    }
  }
}

