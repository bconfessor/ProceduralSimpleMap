//Class for the Player

public class Player
{
  int playerX, playerY;//saves coordinates of center of player(for now, it will be a circle)
  int tileSize;//saves the size of tile, so it knows how much to walk with each step
  
  
  public Player(int x, int y, int tSize)
  {
    //initial positions of player(CENTER OF PLAYER, BE CAREFUL)
    playerX = x;
    playerY = y;
    tileSize = tSize;
  }
  
  void draw()
  {
    //make a dark circle as a player....I'm a programmer, idk how to make things pretty, nor is my objective here <-<
    fill(200,50,50); 
    
    ellipse(playerX,playerY,tileSize/2, tileSize/2);
  }
  
  void placePlayer(int _x, int _y)
  {
    //new coord kinda hard-coded, fix this later
    playerX = (int)((_x+2.5)*tileSize);
    playerY = (int)((_y+2.5)*tileSize);
  }
  
  
  void movePlayer(char direction)
  {
    //changes the position of the character every time arrows are pressed 
    switch(direction)
    {
      case 'l':
        //moves left
        playerX-=tileSize;
        break;   
     case 'r':
        //moves right
        playerX+=tileSize;
        break;
      case 'u':
        //moves up
        playerY-=tileSize;
        break;
      case 'd':
        //moves down
        playerY+=tileSize;
        break;
      
    }
  }
  
}