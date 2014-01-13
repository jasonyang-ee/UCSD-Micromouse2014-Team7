#ifndef DEFINE_H
#define DEFINE_H
#include "global.h"

//=====================  Compass Description  =====================//
#define north 0
#define east 1
#define south 2
#define west 3

//=====================  Direction Description  =====================//
#define front 0
#define right 1
#define back 2
#define left 3

//=====================  Wall Description  =====================//

//=====================  Hardware Description  =====================//
#define fullPWM 65535
#define fullAnalog 4095

//=====================  I2C Address  =====================//
#define switchAddress 0x38


//=====================  Pin Define  =====================//
//IR Reciever
#define sensorLeft 3
#define sensorFrontLeft 4
#define sensorFront 5
#define sensorFrontRight 6
#define sensorRight 7

//IR LED
#define LedIR1 12
#define LedIR2 13
#define LedIR3 14

//Motor
#define motorLeft1 11  // Forward = 1H+2L, Break = L+L, Reverse = 1L+2H
#define motorLeft2 10  // Coast = H+H
#define motorRight1 8  //
#define motorRight2 9  //

//Encoder
#define encoderLeftDirc 22
#define encoderLeftCLK 21
#define encoderRightDirc 24
#define encoderRightCLK 23

//Indicator LED
#define LedRed 15
#define LedBlue 16
#define LedGreen 17

#endif
