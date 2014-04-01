import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.Vector;
import java.io.UnsupportedEncodingException;

public class Utils 
{
  static Pattern idPattern = Pattern.compile("<meta property=\"twitter:app:url:googleplay\" content=\"https?://vine.co/v/(.*)\">");
  static Pattern imgPattern = Pattern.compile("<meta property=\"twitter:image\" content=\"(https?://.*)\">");
  static Pattern vidPattern = Pattern.compile("<meta property=\"twitter:player:stream\" content=\"(https?://.*)\">");
  static Pattern vidWidthPattern = Pattern.compile("<meta property=\"twitter:player:width\" content=\"(.*)\">");
  static Pattern vidHeightPattern = Pattern.compile("<meta property=\"twitter:player:height\" content=\"(.*)\">");
  static Pattern titlePattern = Pattern.compile("<meta property=\"twitter:description\" content=\"(.*)\">");

  static Pattern urlPattern = Pattern.compile("(https?://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|])");


  static Vector<String> parseUrls(String tweet)
  {
    Vector<String> urls = new Vector<String>();
    Matcher urlMatcher = urlPattern.matcher(tweet);
    while (urlMatcher.find ()) {
      urls.add(urlMatcher.group());
    }

    return urls;
  }


  static Vine parseVine(String html)
  {
    Matcher idMatcher = idPattern.matcher(html);
    Matcher imgMatcher = imgPattern.matcher(html);
    Matcher vidMatcher = vidPattern.matcher(html);
    Matcher vidWidthMatcher = vidWidthPattern.matcher(html);
    Matcher vidHeightMatcher = vidHeightPattern.matcher(html);
    Matcher titleMatcher = titlePattern.matcher(html);

    String id = "";
    String imgURL = "";
    String vidURL = "";
    int vidWidth = 0;
    int vidHeight = 0;
    String title = "";

    if (idMatcher.find()) {
      id = idMatcher.group(1);
    }


    if (imgMatcher.find()) {
      imgURL = imgMatcher.group(1);
    }

    if (vidWidthMatcher.find()) {
      vidWidth = Integer.parseInt(vidWidthMatcher.group(1));
    }

    if (vidHeightMatcher.find()) {
      vidHeight = Integer.parseInt(vidHeightMatcher.group(1));
    }

    if (vidMatcher.find()) {
      vidURL = vidMatcher.group(1);
    }

    if (titleMatcher.find()) {
      title = titleMatcher.group(1);
    }

    if (vidWidth == 0 || vidHeight == 0)
    {
      return null;
    }

    return new Vine(id, title, imgURL, vidURL, vidWidth, vidHeight);
  }
}

