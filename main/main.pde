#include "global.h"
#include "pinMap.h"
#include "config.h"
#include "Wire.h"
#include <stdio.h>


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
  
  setup_maze(16);
  
//  PIDmode = modeStraight;
//  modeFollow = followDiagonalRight;
}

void loop()
{
  //char* buffer;
  //read user setting
  systemMode = board_switch();
  board_display();
  
  switch(systemMode)
  {
    case 3:
    {
      //sprintf(
      break;
    }
    case 2:
    {
      motorLeft_go(0);
      motorRight_go(0);
      delay(300);
      runAllSensor();
      PID_follower();
      SerialUSB.println(modeFollow);
      break;
    }
  
    //sensor test mode
    case 1:
    {
      motorLeft_go(0);
      motorRight_go(0);
      delay(500);
      runAllSensor();
      sensor_calibration();
      sensor_read();
      break;
    }
  
    case 0:  //main searching mode input by user
    {
      solve_maze();
      break;
    }
  }//end switch
}//end loop
