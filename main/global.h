#ifndef GLOBAL_H
#define GLOBAL_H
#include "define.h"
#include "config.h"
#include "cell.h"
#include "function.h"

//=====================  Objects  =====================//
Function F;
Cell C[mazeSize][mazeSize];  //CELL cell[y][x];

//=====================  Hardware  =====================//
//Sensor Distance
volatile double distFront;
volatile double distFrontLeft;
volatile double distFrontRight;
volatile double distSideLeft;
volatile double distSideRight;
volatile double distDiagonalLeft;
volatile double distDiagonalRight;
volatile double distSideLeftLast;
volatile double distSideRightLast;

//Motor Speed
volatile int speedLeft = 0;
volatile int speedRight = 0;
volatile int speedBase = 0;

//Encoder Counts
volatile int rotationLeft = 0;
volatile int rotationRight = 0;

//=====================  Cell  =====================//
volatile Cell *cellCurrent;
volatile int compass;

//=====================  Timer  =====================//
volatile int timer = 0;
volatile int timerCurrent = 0;

//=====================  Loop Control  =====================//
volatile int stage = 0;
volatile int mode = 0;



#endif
