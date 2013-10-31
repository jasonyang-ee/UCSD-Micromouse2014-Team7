#ifndef GLOBAL_H
#define GLOBAL_H
#include "define.h"
#include "config.h"
#include "cell.h"
#include "hardware.h"
#include "search.h"
#include "motion.h"
#include "debug.h"


volatile Search S;
volatile Hardware H;
volatile Motion M;
volatile Debug D;
volatile Cell C[mazeSize][mazeSize];  //CELL cell[y][x];

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

//Sensor Voltage
volatile int voltFrontLeft;
volatile int voltFrontRight;
volatile int voltSideLeft;
volatile int voltSideRight;
volatile int voltDiagonalLeft;
volatile int voltDiagonalRight;

//Motor Speed
volatile int speedLeft = 0;
volatile int speedRight = 0;
volatile int speedBase = 0;

//Encoder Counts
volatile int countLeft = 0;
volatile int countRight = 0;

//=====================  Cell  =====================//
volatile Cell *cellCurrent;
volatile int compass;

//=====================  Timer  =====================//
volatile int timerCount = 0;

//=====================  PID Error  =====================//
//decelerate

//straight followBoth

//straight followRight

//straight followLeft

//straight fishBone

//rotate

//angular velocity

#endif
