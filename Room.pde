public class Room
{
  int x1,x2,y1,y2;//holds the 4 corners of the rooms(IN NUMBER OF TILES)
  PVector center;//holds the center of the room;used for creating the corridors
  public Room(int x, int y, int w, int h)
  {
    //x and y = upper left corner of room
    //with h and w we can find the other corners of the room
    x1=x;
    x2=x+w;
    y1=y;
    y2=y+h;
    center = new PVector(floor((x1+x2)/2), floor((y1+y2)/2));
  }
  
  
  boolean intersects(Room r)
  {
    //checks if the current room intersects with the parameter room
    //TODO: Check for intersections(Remember Python with Esperança? same shit)
    
    if(this.x2>=r.x1&&this.x1<=r.x1)//intersecting on x axis(r is on the right)
    {
      if(r.y1<=this.y1&&r.y2>=this.y1)//intersecting on y axis(r in on top)
      {
        return true;
      }
      else if(r.y2>=this.y2&&r.y1<=this.y2)//intersecting on y axis(r is on bottom)
      {
        return true;
      }
    }
    
    
    else if(r.x2>=this.x1&&r.x1<=this.x1)//intersecting on x axis(r is on the left)
    {
      if(r.y1<=this.y1&&r.y2>=this.y1)//intersecting on y axis(r in on top)
      {
        return true;
      }
      else if(r.y2>=this.y2&&r.y1<=this.y2)//intersecting on y axis(r is on bottom)
      {
        return true;
      }
    }
    
    //no interceptions if it gets to this point
    return false;
  }
  
  
  
  
}