#ifndef HARDWARE_H
#define HARDWARE_H
#include "global.h"

class Hardware{
public:
  void motor(char,int);
  
};

void Hardware::motorDrive(char side, int speed)
{
  switch(side){
    case 'R':
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
      break;
    case 'L':
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
      break;
  }
}

//sensor
//basic motor
//encoder

#endif
