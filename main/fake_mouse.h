#ifndef FAKE_MOUSE_H
#define FAKE_MOUSE_H
#include <stdio.h>
#include <stdint.h>

// turn 90 degrees counterclockwise
void turn_ccw(){
	printf("Turning counterclockwise\n");
}

// turn 90 degrees clockwise
void turn_cw(){
	printf("Turning clockwise\n");
}

void move_forward(){
	printf("Moving forward\n");
}

void move_backward(){
	printf("Moving backward\n");
}

// scan for any walls and return a bitfield
uint8_t scan_walls(){
	// the fake mouse never returns any
	return 0;	
}

#endif