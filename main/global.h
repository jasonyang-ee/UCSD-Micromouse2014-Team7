#ifndef GLOBAL_H
#define GLOBAL_H

//motor
int speedLeft = 0;
int speedRight = 0;

//Encoder Counts
volatile int wheelCountLeft = 0;
volatile int wheelCountRight = 0;
volatile int lastCountLeft = 0;
volatile int lastCountRight = 0;
volatile int encoderTimeLeft = 0;
volatile int encoderTimeRight = 0;
volatile int lastTickLeft = 0;
volatile int lastTickRight = 0;

//Sensor Values
volatile double distFront = 0;
volatile double distLeft = 0;
volatile double distRight = 0;
volatile double distDiagonalLeft = 0;
volatile double distDiagonalRight = 0;
double initialDiagonalLeft = 70;
double initialDiagonalRight = 80;

//PID error
int errorLeft = 0;
int errorLeftLast = 0;
int errorLeftDiff = 0;
int errorLeftTotal = 0;
int errorRight = 0;
int errorRightLast = 0;
int errorRightDiff = 0;
int errorRightTotal = 0;
int errorSide = 0;
int errorSideLast = 0;
int errorSideDiff = 0;
int errorSideTotal = 0;
int errorDiagonal = 0;
int errorDiagonalLeftLast = 0;
int errorDiagonalLeft = 0;
int errorDiagonalLeftDiff = 0;
int errorDiagonalLeftTotal = 0;
int errorDiagonalRightLast = 0;
int errorDiagonalRight = 0;
int errorDiagonalRightDiff = 0;
int errorDiagonalRightTotal = 0;
int errorCount = 0;
int errorCountLast = 0;
int errorCountDiff = 0;
int errorCountTotal = 0;

int errorStopRight = 0;
int errorStopRightLast = 0;
int errorStopRightDiff = 0;
int errorStopRightTotal = 0;
int errorStopLeft = 0;
int errorStopLeftLast = 0;
int errorStopLeftDiff = 0;
int errorStopLeftTotal = 0;
int countsNeededLeft = 0;
int countsNeededRight = 0;

//PID time interval
double timeDiff = 0;
double timeLast = 0;

//board_button
int buttonTime = 0;
int buttonState = 0;
int lastButtonState = 0;

//System Modes
int systemMode = 0;

//PID Modes
int PIDmode = 0;
#define modeDecide 0
#define modeStraight 1
#define modeStop 2
//#define modeTurn 3
#define modeTurnRight 4
#define modeTurnLeft 5
#define modeTurnBack 6
#define modeStraightOne 7
#define modeCountFix 8
#define modeFrontFix 9
int turnAgain = false; //For Turning Back

//Fix Modes
int modeFix = 0;
#define fixFront 1
#define fixDiagonals 2

//PID Straight Modes
int modeFollow = 0;
#define followSide 1
#define followDiagonalLeft 2
#define followDiagonalRight 3
#define followRight 4
#define followLeft 5
#define followEncoder 6
#define followNone 7

//PID Turn Modes
int turnState = 0;

//Decision Scenarios
int wallCase = 0;
#define wallNone 0
#define wallFront 1
#define wallRight 2
#define wallLeft 4

#define wallFrontRight  3
#define wallFrontLeft 5
#define wallRightLeft  6
#define wallAll  7

//Flood Fill Values used in Decision
int FFL = 0; //Flood Fill Value to Cell on Left
int FFR = 0; //On Right
int FFF = 0; //In Front
int FFB = 0; //Behind

//Status Variables
int currentX = 0;
int currentY = 0;
int compass = 0;

int timeSet = 0;
int timeNow = 0;

//Movement of the mouse
int movement = 0;
int movementNow = 0;
int movementLast = 0;

//Compass Headings
int headingInitial = 0;
double heading = 0;
short compass_raw_y = 0;
short compass_raw_z = 0;
short compass_raw_x = 0;

//FloodFill Directions
int toCenter = false;
int toStart = false;

//Priorities
int priorityRight = true;
int checkDistance = false;


#endif
