#ifndef FUNCTION_H
#define FUNCTION_H
#include "global.h"

class Function{
public:
//=====================  Mode Select  =====================//
  void buttonInput();
//=====================  Motor Driver  =====================//
  void motorDrive(char,int);
//=====================  Debug  =====================//
  void debugSystem();
  void debugData();
  void debugMaze();
//=====================  Interrupt  =====================//
  void globalInterrupt();
//=====================  I2C  =====================//
  int I2CRead();
  bool I2cWrite(int);
};


#endif
