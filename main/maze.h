#ifndef MAZE_H
#define MAZE_H

#include <stdint.h>
#include <stdio.h>

#define WALL_NORTH 1
#define WALL_EAST 2
#define WALL_SOUTH 4
#define WALL_WEST 8

typedef struct{
	uint8_t walls   :4;
	uint8_t visited :1;
	uint8_t is_goal :1;
	uint8_t vis_dir :2;
	uint8_t fill_order;
} cell;

#define DIR_DX(d) (((d)&1)-((d)&2))%(-2)
#define DIR_DY(d) (((~(d))&1)-((d)&2))%(-2)
#define LOC_X(l) ((l)>>4)
#define LOC_Y(l) ((l)&15)
#define LOC(x, y) (((x)<<4)|((y)&15))
#define LOC_IN_DIR(l,d) LOC(LOC_X(l)+DIR_DX(d),LOC_Y(l)+DIR_DY(d))
#define CELL_IN_DIR(l,d) maze[LOC_IN_DIR(l,d)]
#define RAND (((random_seed=random_seed*1103515245 +12345) / 65536) % 32768)

static uint8_t mouse_loc = 0;
static uint8_t mouse_dir = 0;
static uint8_t goal;
static uint8_t maze_size;
static uint32_t random_seed;
static cell maze[256];

// display the maze, showing
void print_maze(){
	uint8_t y=maze_size;
	do {
		y--;
		for(uint8_t x=0;x<maze_size;x++){
			printf("+");
			if(maze[LOC(x,y)].walls & WALL_NORTH) printf("----");
			else printf("    ");
		}
		printf("+\n|");
		for(uint8_t x=0;x<maze_size;x++){
			printf("  ");
			uint8_t dir = 255;
			if(mouse_loc == LOC(x,y)) dir = mouse_dir%4;
			if(maze[LOC(x,y)].visited) dir = maze[LOC(x,y)].vis_dir;
			switch(dir){
				case 0: printf("^"); break;
				case 1: printf(">"); break;
				case 2: printf("v"); break;
				case 3: printf("<"); break;
				default: printf(" ");
			}
			if(maze[LOC(x,y)].walls & WALL_EAST) printf(" |");
			else printf("  ");
		}
		printf("\n|");
		for(uint8_t x=0;x<maze_size;x++){
			printf(" %-2X",maze[LOC(x,y)].fill_order);
			if(maze[LOC(x,y)].walls & WALL_EAST) printf(" |");
			else printf("  ");
		}
		printf("\n");
	} while (y);
	for(uint8_t x=0;x<maze_size;x++){
		printf("+");
		if(maze[LOC(x,0)].walls & WALL_SOUTH) printf("----");
		else printf("    ");
	}
	printf("+\n");
}

// set the wall of a cell
// and the corresponding wall of the cell behind it
void set_cell_wall(uint8_t c, uint8_t d){
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

// randomly generate a maze starting from the given seed
// the probability that a cell will have a wall in a certain direction
// is related to difficulty
void generate_maze(int seed, uint8_t difficulty){
	random_seed = seed;
	for(uint8_t x = 0; x<15; x++){
		for(uint8_t y = 0; y<15; y++){
			if(!(RAND%(10-difficulty))) set_cell_wall(LOC(x,y),0);
			if(!(RAND%(10-difficulty))) set_cell_wall(LOC(x,y),1);
		}
	}
}


void setup_maze(int size, uint8_t g){
	maze_size = size;	
	for(uint8_t x = 0; x<16; x++){
		for(uint8_t y = 0; y<16; y++){
			if(y==0) set_cell_wall(LOC(x,y),2);
			if(x==0) set_cell_wall(LOC(x,y),3);
			if(y==maze_size-1) set_cell_wall(LOC(x,y),0);
			if(x==maze_size-1) set_cell_wall(LOC(x,y),1);
		}
	}
	// additionally set east wall of starting cell
	set_cell_wall(LOC(0,0), 1);
	// and set up goal
	goal = g;
	maze[goal].is_goal = 1;

}

// turn to and move in the specified direction
void move_dir(uint8_t req_dir){
	printf("moving in dir %d\n", req_dir);
	// if mouse orientation does not match the requested direction, turn clockwise
	uint8_t error = ((mouse_dir)%4 - req_dir)%4;
	switch(error%4){
		case 1: turn_ccw(); mouse_dir--; break;
		case 3: turn_cw(); mouse_dir++; break;
		case 2: 
			move_backward(); 
			LOC_IN_DIR(mouse_loc,mouse_dir);
			return;
	}
	mouse_loc = LOC_IN_DIR(mouse_loc,mouse_dir);
	move_forward();
}

// store the distance to the goal in each cell
void flood_fill(uint8_t cur, uint8_t dist){
	//printf("Location %02X\n",cur);
	maze[cur].fill_order = dist;
	// For each of the four directions
	for(uint8_t i=0;i<4;i++){
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
	uint8_t i = 0;
	do maze[i++].fill_order = 255;
	while(i);
	// do the hard part of solving the maze
	flood_fill(goal, 0);
	// while we still haven't solved the maze,
	while(!maze[mouse_loc].is_goal){
		printf("Currently at %02X\n",mouse_loc);
		// check for new walls
		uint8_t changed = 0;
		uint8_t walls = scan_walls();
		// if there are any new ones, save them
		for(i=0;i<4;i++) if((walls&(1<<i)) && !(maze[mouse_loc].walls&(1<<i))){
			changed = 1;
			maze[mouse_loc].walls |= (1<<i);
		}
		// if there were any changes, refresh the entire maze
		if(changed) flood_fill(goal,0);
		uint8_t best = 255;   // least distance found
		uint8_t best_dir = 0; // direction in which the least distance was found
		// for each of the four directions,
		for(uint8_t i=0;i<4;i++){
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
			printf("Can't move in any direction, aborting\n");
			break;
		}
		
		maze[mouse_loc].visited = 1;
		maze[mouse_loc].vis_dir = mouse_dir;
		// move in the best direction
		move_dir(best_dir);
	}
	print_maze();
}

#endif