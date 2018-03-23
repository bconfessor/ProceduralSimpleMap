//creates PCG Map

public class Map
{
  PVector currentCoord;
  PVector floorBeginning;//coordinates for the top left corner of room
  int floorSize;//width and height of floor; always square floor
  int tileSize;//tile size(always a square)
  int numberOfTiles; //given by the user

  



  Player player;
  Tile[][] tilesArray;
  ArrayList<Room> roomsArray = new ArrayList<Room>();



  public Map(int fSize, int floorCornerX, int floorCornerY, int numT, int minRoomSize, int maxRoomSize, int maxNumberOfRooms)
  {
    floorSize = fSize;

    floorBeginning = new PVector(floorCornerX, floorCornerY);

    numberOfTiles = numT;
    tileSize = fSize/numT; 
    tilesArray = new Tile[numT][numT];
    for (int i = 0; i<numT; i++)
    {
      for (int j = 0; j<numT; j++)
      {
        //fill the Tile Array with tiles
        tilesArray[i][j]= new Tile((int)floorBeginning.x+i*tileSize, (int)floorBeginning.y+j*tileSize, tileSize);
      }
    }
    /*print("\nFloor size is ", fSize);
    print("\nnumber of tiles is ", numT);
    print("\nSize of each tile is ", tileSize);*/


    //create Player obj
    player = new Player(floorCornerX+tileSize/2, floorCornerY+tileSize/2, tileSize);
    
    //Create PCG Rooms
    resetGrid();
  }



  void draw()
  {
    //for now, just draws the basic lines around the room 
    fill(255);
    for (int i = 0; i<numberOfTiles; i++)
    {
      for (int j = 0; j<numberOfTiles; j++)
      {
        tilesArray[i][j].draw();
      }
    }
    player.draw();
  }



  //======================================Room Generation Methods======================================

  void generateRandomRooms()
  {
    //creates the rooms and saves them in the Rooms array 

    for (int i = 0; i<maxNumberOfRooms; i++)
    {
      //working with tile numbers intead of pixels here, for simplicity
      int w = (int)random(minRoomSize, maxRoomSize+1);//gets a value for w within the specified range
      int h = (int)random(minRoomSize, maxRoomSize+1);//same as above, between min and max
      int _x=(int)random(numberOfTiles-w-1);
      int _y=(int)random(numberOfTiles-h-1);

      Room newRoom = new Room(_x,_y,w,h);

      boolean failed=false;
      for(int j = 0;j< roomsArray.size();j++)
      {
        //check for intersections
        if(newRoom.intersects(roomsArray.get(j)))
        {
          //two rooms collide;new room is invalid
          failed=true;
          break;
        }
      }
      //if after all checks, new room didn't collide with anyone, save it in the array
      if(!failed)
      {
        createRoom(newRoom);
        print("\nCreating a room starting at (", _x, ",",_y,") with dimensions ",w,"x",h);
        print("\nCenter of new room: (",newRoom.center.x,",",newRoom.center.y,")");
        roomsArray.add(newRoom);
      }
    }
  }
  
  void createRoom(Room newRoom)
  {
    //carves out a new room from the parameter room
    //Gets the measurements of the new room and paint them(by changing their type)
    for(int i =newRoom.x1;i<newRoom.x2;i++)
    {
      for(int j =newRoom.y1;j<newRoom.y2;j++)
      {
        tilesArray[i][j].tileType="floor";
      }
    }
  }
  
  void generateCorridors()
  {
    //gets the rooms two by two and connect them
    for(int i = 0;i<roomsArray.size()-1;i++)
    {
      createCorridor(roomsArray.get(i),roomsArray.get(i+1));
    }
  }
  
  void createCorridor(Room r1, Room r2)
  {
    //Creates a corridor between r1 and r2, divided between the horizontal and vertical parts
    createVerticalCorridor(r1.center.y, r2.center.y, min(r1.center.x, r2.center.x));//as much to the left as possible
    if((r1.center.x >=r2.center.x && r1.center.y>=r2.center.y)||(r2.center.x>=r1.center.x&&r2.center.y>=r1.center.y))
    {
      //checks so it won't start both corridors from the same room
      createHorizontalCorridor(r1.center.x,r2.center.x, max(r1.center.y, r2.center.y));//lowest possible
    }
    else
      createHorizontalCorridor(r1.center.x,r2.center.x, min(r1.center.y, r2.center.y));//highest possible

  }
  
  
  void createHorizontalCorridor(float x1, float x2, float y)
  {
    //creates a horizontal corridor from x1 to x2, with height y
    for(int i = (int)min(x1,x2);i<(int)max(x1,x2)+1;i++)
    {
      tilesArray[i][(int)y].tileType = "floor";
    }
    
  }
  void createVerticalCorridor(float y1, float y2, float x)
  {
    //creates a horizontal corridor from x1 to x2, with height y
    for(int i = (int)min(y1,y2);i<(int)max(y1,y2)+1;i++)
    {
      tilesArray[(int)x][i].tileType = "floor";
    }
  }
  
  
  //method for cleaning the rooms and reseting the grid
  void resetGrid()
  {
    roomsArray.clear();//empties the array
    //restores all tiles to 'wall'(costy, but i'm not aiming for performance here)
    for (int i = 0; i<numberOfTiles; i++)
    {
      for (int j = 0; j<numberOfTiles; j++)
      {
        //change type for all tiles
        tilesArray[i][j].tileType="wall";
      }
    }    
    //regenerate rooms
    generateRandomRooms();
    placePlayerInRandomRoom();
    generateCorridors();
  }
  
  void placePlayerInRandomRoom()
  {
    //choose a random room within center of possible ones
    int randRoom = (int)random(roomsArray.size());
    //get random coordinates from this room
    int newX = (int)roomsArray.get(randRoom).center.x;
    int newY = (int)roomsArray.get(randRoom).center.y; 
    
    print("Placing player in room ",randRoom,", position (",newX,",",newY,")");
    //finally, place character in that place
    player.placePlayer(newX, newY);
    
  }
  
}