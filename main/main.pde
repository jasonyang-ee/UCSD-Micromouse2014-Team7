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
  modeFollow = followDiagonalRight;
// runAllSensor();
// initialDiagonalLeft = distDiagonalLeft;
// initialDiagonalRight = distDiagonalRight;
}

void loop()
{
  
  
  //read user setting
  systemMode = board_switch();
  board_display();
  
  switch(systemMode)
  {
    case 3:
    {
      SerialUSB.print(wheelCountLeft);
      SerialUSB.print("\t");
      SerialUSB.println(wheelCountRight);
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
  
    //PID
    case 0:
    {
      runAllSensor();
      PID_follower();
      if(PIDmode == modeStraight)
      {
        speedLeft = 15000;
        speedRight = 15000;
        PID();
        if(distFront < 70 || distLeft > 200 || distRight > 200)
          PIDmode = modeStop;
      }
//      //Turn Right
//      if(PIDmode == modeTurn)
//      {
//        timeSet = millis();
//        //mode = modeTurnRight;
//        //mode = modeTurnLeft;
//        mode = modeTurnBack;
//      }
//      
//      if(mode == modeTurnRight)
//      {
//        motorLeft_go (10000);
//        motorRight_go (-10000);
//        timeNow = millis();
//        if (timeNow >= timeSet + 340) mode = modeStop;
//      }
//      
//      if(mode == modeTurnLeft)
//      {
//        motorLeft_go (-10000);
//        motorRight_go (10000);
//        timeNow = millis();
//        if (timeNow >= timeSet + 320) mode = modeStop;
//      }
//      
//      if(mode == modeTurnBack)
//      {
//        motorLeft_go (10000);
//        motorRight_go (-10000);
//        timeNow = millis();
//        if (timeNow >= timeSet + 600) mode = modeStop;
//      }
      
      if(PIDmode == modeStop)
      {
        motorLeft_go(0);
        motorRight_go(0);
      }
      break;
    }
  }//end switch
}//end loop
