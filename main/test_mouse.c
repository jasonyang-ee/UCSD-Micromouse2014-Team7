#include "fake_mouse.h"
#include "maze.h"

int main(){
	setup_maze(16,LOC(13,13));
	generate_maze(1234, 6);
	solve_maze();
}