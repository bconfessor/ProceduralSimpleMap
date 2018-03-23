//Class for each map tile

public class Tile
{
 int x,y;//holds coordinates for the upper left corner of the tile
 int tileSize;//square tile, so only one value needed
 
 String tileType="wall";//indicates is tile is 'empty', 'floor', 'lava', etc...;default is "wall"
 
 public Tile(int _x, int _y, int tSize, String tType)
 {
  x=_x;
  y=_y;
  tileSize = tSize;
  tileType = tType;
 }
 
 public Tile(int _x, int _y, int tSize)
 {
  x=_x;
  y=_y;
  tileSize = tSize;
 }
  
 void draw()
 {
  //draws the tile itself (color depends on type
  if(tileType=="wall")
    fill(133,87,35);
  else //tileType == "floor"
    fill(255);
    
    
  rect(x,y,tileSize,tileSize); 
   
 }
  
  
  
  
  
  
  
  
  
  
}