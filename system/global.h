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
volatile double distFrontLeft = 0;
volatile double distFrontRight = 0;

volatile int voltFront = 0;
volatile int voltLeft = 0;
volatile int voltRight = 0;
volatile int voltFrontLeft = 0;
volatile int voltFrontRight = 0;

//Loop Control
int systemStage = 1;
int systemMode = 1;

//board_button
int buttonTime = 0;
int buttonState = 0;
int lastButtonState = 0;

//PID Modes
#define modeStraight 1



#endif
