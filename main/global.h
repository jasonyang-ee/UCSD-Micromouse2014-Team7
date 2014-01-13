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
volatile double distLeft;
volatile double distRight;

//Motor Speed
volatile int speedLeft = 0;
volatile int speedRight = 0;
int speedBase = 0;

//Encoder Counts
volatile int rotationLeft = 0;
volatile int rotationRight = 0;

//=====================  Cell  =====================//
Cell *cellCurrent;
int compass;

//=====================  Timer  =====================//
volatile int timer = 0;
volatile int timerCurrent = 0;
int buttonTime = 0;

//=====================  Loop Control  =====================//
int stage = 0;
int mode = 0;
int buttonState = 0;
int lastButtonState = 0;




#endif
