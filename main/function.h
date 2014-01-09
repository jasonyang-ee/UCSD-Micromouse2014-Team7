#ifndef FUNCTION_H
#define FUNCTION_H
#include "global.h"

class Function{
public:
//=====================  Hardware Driver  =====================//
  void motorDrive(char,int);
//=====================  Debug  =====================//
  void globalInterrupt();
  void allSystem();
//=====================  Motion  =====================//
};


#endif
