#ifndef MAZE_H
#define MAZE_H
#include "global.h"

maze = MazeCell[16][16];
static loc mouse_loc;
static uint8_t mouse_dir;


// turn to and move in the specified direction
void move_dir(uint8_t req_dir){
	// if mouse orientation does not match the requested direction, turn clockwise
	if(mouse_dir&1 != req_dir&1){
		turn_cw();
		mouse_dir++;
	}
	if(mouse_dir == req_dir){
		mouse_loc.x += MOUSE_DX;
		mouse_loc.y += MOUSE_DY;
		move_forward();
	else{
		mouse_loc.x -= MOUSE_DX;
		mouse_loc.y -= MOUSE_DY;
		move_backward();
	}
}

void flood_fill(loc cur, uint8_t dist){
	maze[cur].dist = dist;
	// For each of the four directions
	for(uint8_t i=0;i<4;i++){
		// If there is no wall in that direction
		if(!(maze[0][cur].walls & (1<<i))){
			// and the cell in that direction has a higher distance so far
			if(CELL_IN_DIR(maze,cur,i).dist > dist+1)
				// start the flood fill from that cell 
				flood_fill(cur, dist+1);
		}
	}
}

void solve_maze(void move_dir_func*(uint8_t)){
	while(1){
		uint8_t best = 0;
		uint8_t best_dir = 0;
		// For each of the four directions
		for(uint8_t i=0;i<4;i++){
			// if there is no wall in that direction
			if(!(maze[0][mouse_loc].walls & (1<<i))){
				// and if the cell in that direction beats our current best,
				if(CELL_IN_DIR(maze,mouse_loc,i).dist < best%4){
					// record its direction
					best = CELL_IN_DIR(maze,mouse_loc,i).dist
					best_dir = i;
				}
			}
		}

		// move in the best direction
		move_dir(best_dir);
	}
}

#endif