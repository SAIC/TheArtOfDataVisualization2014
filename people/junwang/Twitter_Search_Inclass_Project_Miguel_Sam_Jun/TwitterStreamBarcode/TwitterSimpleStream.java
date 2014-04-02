import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;
import java.util.ArrayList;
import twitter4j.*;
import twitter4j.conf.*;
import processing.core.*;
import java.lang.reflect.Method;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.Status;
import twitter4j.StatusDeletionNotice;
import twitter4j.StatusListener;
import twitter4j.TwitterStream;
import twitter4j.TwitterStreamFactory;
import twitter4j.User;
import twitter4j.conf.ConfigurationBuilder;
import twitter4j.auth.AccessToken;
import twitter4j.auth.Authorization;
import twitter4j.auth.AuthorizationFactory;
import twitter4j.auth.OAuthAuthorization;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationContext;

public class TwitterSimpleStream extends StatusAdapter
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

  String oAuthConsumerKey = "";
  String oAuthConsumerSecret = "";
  String oAuthAccessToken = "";
  String oAuthTokenSecret = "";

  String query = "";

  long sinceId = -1;

  int maxTweetsToReturn = 100;

  TwitterStream twitterStream;

  int searchPollInterval = 30 * 1000; // 30 seconds

  TwitterSimpleStream(PApplet parent, 
  ArrayList<String> queryTerms, 
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

    twitterStream = new TwitterStreamFactory().getInstance();

    twitterStream.setOAuthConsumer(oAuthConsumerKey, oAuthConsumerSecret);

    AccessToken accessToken = new AccessToken(oAuthAccessToken, oAuthTokenSecret);

    twitterStream.setOAuthAccessToken(accessToken);


    try {
      newTweetsMethod = parent.getClass().getMethod("newTweets", 
      new Class[] { 
        Class.forName("java.util.Vector")
      }
      );
    } 
    catch (Exception e) {
      System.out.println("Where is the newTweets method?");
    }

    twitterStream.addListener(this);

    if (queryTerms.size() > 0) {
      String[] queries = new String[queryTerms.size()];
      for (int i = 0; i < queryTerms.size(); ++i)
      {
        queries[i] = queryTerms.get(i);
        System.out.println(queries[i]);
      }

      FilterQuery fq = new FilterQuery();
      fq = fq.track(queries);
      twitterStream.filter(fq);
    }
    else {
      // no query terms so just sample
      twitterStream.sample();
    }
  }

  public void onStatus(Status status) {
    Vector<Status> tweets = new Vector<Status>();

    tweets.add(status);

    try {
      if (tweets.size() > 0) {
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

