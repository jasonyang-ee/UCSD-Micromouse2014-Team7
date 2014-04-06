#ifndef GLOBAL_H
#define GLOBAL_H

void board_botton(void);

//Sensor Distance
volatile double sensorLeft;
volatile double sensorFrontLeft;
volatile double sensorFront;
volatile double sensorFrontRight;
volatile double sensorRight;

//Motor Speed
int speedLeft = 0;
int speedRight = 0;

//Encoder Counts
volatile int wheelCountLeft = 0;
volatile int wheelCountRight = 0;
volatile int lastTickLeft = 0;
volatile int lastTickRight = 0;

//Loop Control
int systemStage = 1;
int systemMode = 1;

//board_button
int buttonTime = 0;
int buttonState = 0;
int lastButtonState = 0;



#endif
