//==========  Direction Code  ==========
//            N          0
//          W   E  ==  3   1
//            S          2
//======================================

#define WALL_NORTH 1
#define WALL_EAST 2
#define WALL_SOUTH 4
#define WALL_WEST 8

typedef struct{
uint8 walls   :
  4;
uint8 visited :
  1;
uint8 is_goal :
  1;
uint8 vis_dir :
  2;
  uint8 fill_order;
} 
cell;

#define DIR_DX(d) (((d)&1)-((d)&2))%(-2)
#define DIR_DY(d) (((~(d))&1)-((d)&2))%(-2)
#define LOC_X(l) ((l)>>4)
#define LOC_Y(l) ((l)&15)
#define LOC(x, y) (((x)<<4)|((y)&15))
#define LOC_IN_DIR(l,d) LOC(LOC_X(l)+DIR_DX(d),LOC_Y(l)+DIR_DY(d))
#define CELL_IN_DIR(l,d) maze[LOC_IN_DIR(l,d)]

static uint8 mouse_loc = 0;
static uint8 mouse_dir = 0;
static uint8 goal;
static uint8 maze_size;
static cell maze[256];
static cell maze_backup[256];

// set the wall of a cell
// and the corresponding wall of the cell behind it
void set_cell_wall(uint8 c, uint8 d){
  // set the appropriate wall of the cell
  maze[c].walls |= (1<<d);

  // check bounds
  switch(d){
  case 1: 
    if((c&0xF0)==0xF0) return; 
    break;
  case 0: 
    if((c%16)==0x0F) return; 
    break;
  case 3: 
    if((c&0xF0)==0) return; 
    break;
  case 2: 
    if((c%16)==0) return; 
    break;
  }

  // set the appropriate wall of the adjacent cell
  CELL_IN_DIR(c, d).walls |= (1<<((d+2)%4));
}


void setup_maze(int size){
  maze_size = size;	
  for(uint8 x = 0; x<maze_size; x++){
    for(uint8 y = 0; y<maze_size; y++){
      if(y==0) set_cell_wall(LOC(x,y),2);
      if(x==0) set_cell_wall(LOC(x,y),3);
      if(y==maze_size-1) set_cell_wall(LOC(x,y),0);
      if(x==maze_size-1) set_cell_wall(LOC(x,y),1);
    }
  }
//  for(int x = 0; x < maze_size; x++)
//  {
//    for(int y = 0; y < maze_size; y++)
//    {
//      maze[LOC(x,y)].fill_order = 255;
//    }
//  }
  
//  uint8 i = 0;
//  do maze[i++].fill_order = 255;
//  while(i);
  
  // additionally set east wall of starting cell
  set_cell_wall(LOC(0,0), 1);    
}

// store the distance to the goal in each cell
void flood_fill(uint8 cur, uint8 dist){
  //printf("Location %02X\n",cur);
  maze[cur].fill_order = dist;
  // For each of the four directions
  for(uint8 i=0;i<4;i++){
    // If there is no wall in that direction
    // and the cell in that direction has too high a distance
    if((!(maze[cur].walls & (1<<i))) && (CELL_IN_DIR(cur,i).fill_order > dist+1))
      // start the flood fill from that cell 
      flood_fill(LOC_IN_DIR(cur,i), dist+1);
  }
}

// drive the mouse down the distance gradient to the goal
void solve_maze()
{
//  if(checkDistance)
//  {
//    int distance = round((wheelCountRight + wheelCountLeft)*.5);
//    distance = round(distance/440);
//    for(int i = 0; i < distance; i++)
//      mouse_loc = LOC_IN_DIR(mouse_loc,mouse_dir);
//    checkDistance = false;
//  }    
    

  //if at goal, won't move until position reset.
  if(maze[mouse_loc].is_goal)
    return;
  
  
  scan_walls();
  
  for(int x = 0; x < maze_size; x++)
  {
    for(int y = 0; y < maze_size; y++)
    {
      maze[LOC(x,y)].fill_order = 255;
    }
  }
  
  goal = LOC(8,8);
  maze[LOC(8,8)].is_goal = 1;
  maze[LOC(7,8)].is_goal = 1;
  maze[LOC(8,7)].is_goal = 1;
  maze[LOC(7,7)].is_goal = 1;

  flood_fill(goal,0);

  FFF = CELL_IN_DIR(mouse_loc,((mouse_dir + 0)%4)).fill_order;
  FFR = CELL_IN_DIR(mouse_loc,((mouse_dir + 1)%4)).fill_order;
  FFB = CELL_IN_DIR(mouse_loc,((mouse_dir + 2)%4)).fill_order;
  FFL = CELL_IN_DIR(mouse_loc,((mouse_dir + 3)%4)).fill_order;

//    SerialUSB.print(FFL);
//    SerialUSB.print("\t");
//    SerialUSB.print(FFB);
//    SerialUSB.print("\t");
//    SerialUSB.print(FFF);
//    SerialUSB.print("\t");
//    SerialUSB.print(FFR);
//    SerialUSB.print("\t");
//    SerialUSB.println(mouse_dir);

//  if(maze[mouse_loc].walls & (1<<0)) SerialUSB.print("North  ");
//  if(maze[mouse_loc].walls & (1<<1)) SerialUSB.print("East  ");
//  if(maze[mouse_loc].walls & (1<<3)) SerialUSB.print("West  ");
//  if(maze[mouse_loc].walls & (1<<2)) SerialUSB.print("South  ");
//  SerialUSB.println();

  wallCase = 0;

  if(maze[mouse_loc].walls & (1<<((mouse_dir + 0)%4))) wallCase += wallFront;
  if(maze[mouse_loc].walls & (1<<((mouse_dir + 1)%4))) wallCase += wallRight;
  if(maze[mouse_loc].walls & (1<<((mouse_dir + 3)%4))) wallCase += wallLeft;
  if(maze[mouse_loc].walls & (1<<((mouse_dir + 2)%4))) FFB = 255;

  decide();

  if(PIDmode == modeStraightOne)
    mouse_loc = LOC_IN_DIR(mouse_loc,mouse_dir);
  else if(PIDmode == modeTurnRight)
    mouse_dir++;
  else if(PIDmode == modeTurnLeft)
    mouse_dir--;
  else if(PIDmode == modeTurnBack)
    mouse_dir ^= 2;
  mouse_dir %= 4; 
}


// scan for any walls and return a bitfield
void scan_walls()
{
  int walls = 0;
  runAllSensor();
  if(distFront<80)
    walls |=  (1 << 0);
  if(distRight<80)
    walls |=  (1 << 1);
  if(distLeft<80)
    walls |=  (1 << 3);

  for(int i=0;i<4;i++)
  {
    if(walls&(1<<i))
      set_cell_wall(mouse_loc,((mouse_dir + i)%4));
  }
}

void reset_position()
{
  mouse_loc = LOC(0,0);
  mouse_dir = 0;
}

void copy_maze(cell* src, cell* dst){
  int i=256;
  while(i--) dst[i] = src[i];
}

void restore_maze(){
  copy_maze(maze_backup, maze);
}

void save_maze(){
  copy_maze(maze, maze_backup);
}