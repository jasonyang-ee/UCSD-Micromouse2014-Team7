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
#define openNone 0
#define openEast 2
#define openWest 3
#define openNorth 4

#define openEastWest 5
#define openNorthEast 6
#define openNorthWest 7
#define openAll 9

//=====================  Pin Define  =====================//
//IR Reciever
#define sensorFrontLeft 6
#define sensorFrontRight 5
#define sensorDiagonalLeft 7
#define sensorDiagonalRight 4
#define sensorSideLeft 8
#define sensorSideRight 3

//IR LED
#define ledOne 12
#define ledTwo 13
#define ledThree 14

//Motor
#define PWMLeft 15
#define motorLeft1 22    //motorLeft +  LOW    }gives forward
#define motorLeft2 21    //motorLeft -  HIGH   }
#define PWMRight 27
#define motorRight1 25   //motorRight + HIGH   }gives forward
#define motorRight2 26   //motorRight - LOW    }

//Encoder
#define encoderLeftDirc 18
#define encoderLeftCLK 16
#define encoderRightDirc 31
#define encoderRightCLK 30


#endif
