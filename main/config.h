#ifndef CONFIG_H
#define CONFIG_H
#include "global.h"

//=====================  Maze Constant  =====================//
//Cell per side of the maze
#define mazeSize 16

//=====================  Sensor Constant  =====================//
//counter++ for every 1us, and interrupt for every 1000 count
//interrupt period = 1us * timerRate
#define timerRate 1000

//minimun distance between wall and mouse in one cell
#define distWallExist 14
#define distStop 10

//=====================  Motor Constant  =====================//
//speed constant
#define speedFull 65500
#define speedRace 30000
#define speedMap 10000
#define speedTurn 10000

//=====================  Encoder Constant  =====================//
#define countRotateSide 124
#define countRotateBack 260

#endif
