//Main file for PCG Test

Map map;
int roomSize = 800;
int roomTileNumber = 40;
int roomStartX = 40;
int roomStartY = 40;

//values to be passed to the Room Generator to build the map
int minRoomSize=4;
int maxRoomSize=12;//min and max size of room(IN TILES)
int maxNumberOfRooms=10;//Number of rooms that should be generated(MAX)



void setup()
{
 size(880,880);//Size of screen;
 map = new Map(roomSize, roomStartX, roomStartY, roomTileNumber, minRoomSize, maxRoomSize, maxNumberOfRooms);
 //map.draw();
}

void keyPressed()
  {
     if(keyCode==UP || key == 'w')
     {
         print("\nPressed up");
         map.player.movePlayer('u');
     }
     else if(keyCode == DOWN || key == 's')
     {
         print("\nPressed down");
         map.player.movePlayer('d');
     }
     else if(keyCode == LEFT || key == 'a')
     {
         print("\nPressed left");
         map.player.movePlayer('l');
     }
        else if(keyCode == RIGHT || key == 'd')
     {
         print("\nPressed right");
         map.player.movePlayer('r');
     }
     else if(key == 'g' || key == 'G')
     {
         map.resetGrid();
     }
  }


void draw()
{
  map.draw();
  
}