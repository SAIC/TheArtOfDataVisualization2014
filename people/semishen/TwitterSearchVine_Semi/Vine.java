public class Vine
{
  String _id;
  String _title;
  String _imgURL;
  String _vidURL;
  int _width;
  int _height;


  public Vine(String id, String title, String imgURL, String vidURL, int w, int h)
  {
    _id = id;
    _title = title;
    _imgURL = imgURL;
    _vidURL = vidURL;
    _width = w;
    _height = h;
  }

  public String getId() 
  {
    return _id;
  }

  public String getTitle() 
  {
    return _title;
  }

  public String getImgURL() 
  {
    return _imgURL;
  }

  public String getVidURL() 
  {
    return _vidURL;
  }

  public String toString()
  {
    String result = _id;

    result += "\n\t" + _title;
    result += "\n\t" + _imgURL;
    result += "\n\t" + _vidURL;
    result += "\n\t" + _width + " / " + _height;

    return result;
  }
}

