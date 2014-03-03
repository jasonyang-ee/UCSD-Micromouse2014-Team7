//
//  main.c
//  mouse
//
//  Created by Jason Teng on 2/27/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//
#include "fake_mouse.h"
#include "maze.h"

int main(){
	setup_maze(16,LOC(8,8));
	generate_maze(1234, 6);
	solve_maze();
}