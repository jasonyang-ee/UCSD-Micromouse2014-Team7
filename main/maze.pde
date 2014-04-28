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
	uint8 walls   :4;
	uint8 visited :1;
	uint8 is_goal :1;
	uint8 vis_dir :2;
	uint8 fill_order;
} cell;

void set_cell_wall(uint8, uint8);
void generate_maze(int, uint8);
void setup_maze(int);
void move_dir(uint8);
void flood_fill(uint8, uint8);
void solve_maze();


#define DIR_DX(d) (((d)&1)-((d)&2))%(-2)
#define DIR_DY(d) (((~(d))&1)-((d)&2))%(-2)
#define LOC_X(l) ((l)>>4)
#define LOC_Y(l) ((l)&15)
#define LOC(x, y) (((x)<<4)|((y)&15))
#define LOC_IN_DIR(l,d) LOC(LOC_X(l)+DIR_DX(d),LOC_Y(l)+DIR_DY(d))
#define CELL_IN_DIR(l,d) maze[LOC_IN_DIR(l,d)]
//#define RAND (((random_seed=random_seed*1103515245 +12345) / 65536) % 32768)

#define DEAD_RECKONING 1
#define MOVE_FORWARD_DURATION 500

static uint8 mouse_loc = 0;
static uint8 mouse_dir = 0;
static uint8 goal;
static uint8 maze_size;
static uint32 random_seed;
static cell maze[256];

// set the wall of a cell
// and the corresponding wall of the cell behind it
void set_cell_wall(uint8 c, uint8 d){
	// set the appropriate wall of the cell
	maze[c].walls |= (1<<d);
	
	// check bounds
	switch(d){
		case 1: if((c&0xF0)==0xF0) return; break;
		case 0: if((c%16)==0x0F) return; break;
		case 3: if((c&0xF0)==0) return; break;
		case 2: if((c%16)==0) return; break;
	}
    
	// set the appropriate wall of the adjacent cell
	CELL_IN_DIR(c, d).walls |= (1<<((d+2)%4));
}


void setup_maze(int size){    //Took out goal, since goal should always be at (8,8)(8,7)(7,8)(7,7).
	maze_size = size;	
	for(uint8 x = 0; x<maze_size; x++){
		for(uint8 y = 0; y<maze_size; y++){
			if(y==0) set_cell_wall(LOC(x,y),2);
			if(x==0) set_cell_wall(LOC(x,y),3);
			if(y==maze_size-1) set_cell_wall(LOC(x,y),0);
			if(x==maze_size-1) set_cell_wall(LOC(x,y),1);
		}
	}
	// additionally set east wall of starting cell
	set_cell_wall(LOC(0,0), 1);
	// and set up goal
	goal = LOC(8,8);
	maze[LOC(8,8)].is_goal = 1;
        maze[LOC(7,8)].is_goal = 1;
        maze[LOC(8,7)].is_goal = 1;
        maze[LOC(7,7)].is_goal = 1;
}

// turn to and move in the specified direction
void move_dir(uint8 req_dir){
	//printf("moving in dir %d\n", req_dir);
	// if mouse orientation does not match the requested direction, turn clockwise
	uint8 error = ((mouse_dir)%4 - req_dir)%4;
	switch(error%4){
		case 1: turn_ccw(); mouse_dir--; break;
		case 3: turn_cw(); mouse_dir++; break;
		case 2: turn_back(); mouse_dir ^= 2; break;
			LOC_IN_DIR(mouse_loc,mouse_dir);
			return;
	}
	mouse_loc = LOC_IN_DIR(mouse_loc,mouse_dir);
	move_forward();
}

// store the distance to the goal in each cell
void flood_fill(uint8 cur, uint8 dist){
	//printf("Location %02X\n",cur);
	maze[cur].fill_order = dist;
	// For each of the four directions
	for(uint8 i=0;i<4;i++){
		// If there is no wall in that direction
		if(!(maze[cur].walls & (1<<i))
           // and the cell in that direction has too high a distance
           && CELL_IN_DIR(cur,i).fill_order > dist+1)				
            // start the flood fill from that cell 
            flood_fill(LOC_IN_DIR(cur,i), dist+1);
	}
}

// drive the mouse down the distance gradient to the goal
void solve_maze(){
	// fill maze with 0xFF before running flood_fill
	uint8 i = 0;
	do maze[i++].fill_order = 255;
	while(i);
	// do the hard part of solving the maze
	flood_fill(goal, 0);
	// while we still haven't solved the maze,
	while(!maze[mouse_loc].is_goal){
		//printf("Currently at %02X\n",mouse_loc);
		// check for new walls
		uint8 changed = 0;
		uint8 walls = scan_walls();
		// if there are any new ones, save them
		for(i=0;i<4;i++) if((walls&(1<<i)) && !(maze[mouse_loc].walls&(1<<i))){
			changed = 1;
			maze[mouse_loc].walls |= (1<<i);
		}
		// if there were any changes, refresh the entire maze
		if(changed) flood_fill(goal,0);
		uint8 best = 255;   // least distance found
		uint8 best_dir = 0; // direction in which the least distance was found
		// for each of the four directions,
		for(uint8 i=0;i<4;i++){
			// if there is no wall in that direction,
			if(!(maze[mouse_loc].walls & (1<<i))
               // and the cell in that direction has a better distance,
               && CELL_IN_DIR(mouse_loc,i).fill_order < best){
                // record its direction
                best = CELL_IN_DIR(mouse_loc,i).fill_order;
                best_dir = i;
			}
		}
		if(best == 255){
			//printf("Can't move in any direction, aborting\n");
			break;
		}
		
		maze[mouse_loc].visited = 1;
		maze[mouse_loc].vis_dir = mouse_dir;
		// move in the best direction
		move_dir(best_dir);
	}
	//print_maze();
}




// turn 90 degrees counterclockwise
void turn_ccw()
{      
  timeSet = millis();
  while(1)
  {
    motorLeft_go (-10000);
    motorRight_go (10000);
    timeNow = millis();
    if (timeNow >= timeSet + 340) break; 
  }
}

// turn 90 degrees clockwise
void turn_cw()
{
  timeSet = millis();
  while(1)
  {
  motorLeft_go (10000);
  motorRight_go (-10000);
  timeNow = millis();
  if (timeNow >= timeSet + 340) break;;
  }
}

void move_forward()
{
  runAllSensor();
  PID_follower();
  uint32 start_time = millis();
  while(1){
    speedLeft = 15000;
    speedRight = 15000;
    PID();
    if(DEAD_RECKONING){
      if(millis()-start_time > MOVE_FORWARD_DURATION) break;
    }else{
      //if(we've gone enough encoder ticks forward) break;
    }
  }
  motorLeft_go(0);
  motorRight_go(0);
}

void turn_back(){
  timeSet = millis();
  while(1)
  {
    motorLeft_go (10000);
    motorRight_go (-10000);
    timeNow = millis();
    if(timeNow >= timeSet + 550) break;
  }
}

void move_start(){

}

void move_end(){

}

void move_stop()
{
  motorLeft_go(0);
  motorRight_go(0);
  while(!movement) runAllSensor();
}

// scan for any walls and return a bitfield
uint8 scan_walls()
{
  int result = 0;
  runAllSensor();
  if(distFront<60)
    result |=  (1 << 0);
  if(distRight<60)
    result |=  (1 << 1);
  if(distLeft<60)
    result |=  (1 << 3);
    
  return result;	  // the fake mouse never returns any
}
