#ifndef GLOBAL_H
#define GLOBAL_H

//motor
int speedLeft = 0;
int speedRight = 0;

//Encoder Counts
volatile int wheelCountLeft = 0;
volatile int wheelCountRight = 0;

//Sensor Values
volatile double distFront = 0;
volatile double distLeft = 0;
volatile double distRight = 0;
volatile double distDiagonalLeft = 0;
volatile double distDiagonalRight = 0;

volatile int voltFront = 0;
volatile int voltLeft = 0;
volatile int voltRight = 0;
volatile int voltDiagonalLeft = 0;
volatile int voltDiagonalRight = 0;

int errorSide = 0;
int errorSideLast = 0;
int errorSideDiff = 0;
int errorSideTotal = 0;

int errorDiagonal = 0;
int errorDiagonalLast = 0;
int errorDiagonalDiff = 0;
int errorDiagonalTotal = 0;


//Loop Control
int systemStage = 1;
int systemMode = 1;

//board_button
int buttonTime = 0;
int buttonState = 0;
int lastButtonState = 0;

//PID Modes
int mode = 0;
#define modeDecide 0
#define modeStraight 1
#define modeStop 2




#endif
