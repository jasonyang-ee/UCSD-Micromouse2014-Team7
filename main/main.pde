#include "global.h"
#include "pinMap.h"
#include "config.h"
#include "Wire.h"


void setup()
{
  //LED display
  pinMode(Led1,OUTPUT);
  pinMode(Led2,OUTPUT);
  pinMode(Led3,OUTPUT);
  //motor
  pinMode(motorLeft1, OUTPUT);
  pinMode(motorLeft2, OUTPUT);
  pinMode(motorLeftSTBY, OUTPUT);
  pinMode(motorLeftPWM, PWM);
  pinMode(motorRight1, OUTPUT);
  pinMode(motorRight2, OUTPUT);
  pinMode(motorRightSTBY, OUTPUT);
  pinMode(motorRightPWM, PWM);
  
  //Encoder
  pinMode(encoderLeftCLK, INPUT);
  pinMode(encoderLeftDir, INPUT);
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDir, INPUT);
  //Board I/O
  pinMode(BOARD_LED_PIN, OUTPUT);
  pinMode(BOARD_BUTTON_PIN, INPUT);
  
  attachInterrupt(encoderLeftCLK, encoderLeft_interrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRight_interrupts, RISING);
  
  Wire.begin(0,1);
  PIDmode = modeStraight;
  modeFollow = followLeft;
}

void loop()
{
  //read user setting
  systemMode = board_switch();
  board_display();
  
  switch(systemMode)
  {
    case 2:
    {
      delay(500);
      runAllSensor();
      SerialUSB.println((distDiagonalLeft/distLeft)-5);
      break;
    }
  
    //sensor test mode  
    case 1:
    {
      motorLeft_go(0);
      motorRight_go(0);
      delay(500);
      runAllSensor();
      sensor_read();
      break;
    }
  
    //PID
    case 0:
    {
      runAllSensor();
      if(PIDmode == modeStraight)
      {
        speedLeft = 10000;
        speedRight = 10000;
        PID();
        if(distFront < 35)
          PIDmode = modeStop;
      }
      if(PIDmode == modeStop)
      {
        motorLeft_go(0);
        motorRight_go(0);
      }
      break;
    }
  }//end switch
}//end loop
