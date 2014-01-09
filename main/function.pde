#include "function.h"

void Function::globalInterrupt()
{
  
}

void Function::motorDrive(char side, int speed)
{
  if(side == 'R')
  {
    if(speed > 0){
      pwmWrite(motorRight1, abs(speed));
      pwmWrite(motorRight2, fullPWM);
    }
    else if(speed < 0){
      pwmWrite(motorRight2, abs(speed));
      pwmWrite(motorRight1, fullPWM);
    }
    else if(speed == 0){
      pwmWrite(motorRight1, fullPWM);
      pwmWrite(motorRight2, fullPWM);
    }
  }
  else if(side == 'L')
  {
    if(speed > 0){
      pwmWrite(motorLeft1, abs(speed));
      pwmWrite(motorLeft2, fullPWM);
    }
    else if(speed < 0){
      pwmWrite(motorLeft2, abs(speed));
      pwmWrite(motorLeft1, fullPWM);
    }
    else if(speed == 0){
      pwmWrite(motorLeft1, fullPWM);
      pwmWrite(motorLeft2, fullPWM);
    }
  }
}



