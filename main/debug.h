#ifndef DEBUG_H
#define DEBUG_H
#include "global.h"

class Debug{
public:
  void allSystem();
private:
  bool tic;
};

//==========================================  Function Definition  ==========================================//
void Debug::allSystem()
{
  timer = timerCurrent;
  while( timmerCurrent-timer < 2000 ) motorDrive('L',fullPWM/10);
  while( timmerCurrent-timer < 2000 ) motorDrive('R',fullPWM/10);
  
  
  
  
}





#endif
