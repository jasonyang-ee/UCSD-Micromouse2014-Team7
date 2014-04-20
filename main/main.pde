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
  
  motorLeft_go(0);
  motorRight_go(0);
  
  Wire.begin(0,1);
  PIDmode = modeTurn;
}




void loop()
{
  //read user setting
  systemMode = board_switch();
  

  //sensor test mode
  if(systemMode == 1)
  {
    delay(500);
    sensor_calibration();
  }

  //main search mode
  if(systemMode == 0)
  {
    //Turn Right
    if(PIDmode == modeTurn)
    {
      timeSet = millis();
      //mode = modeTurnRight;
      //mode = modeTurnLeft;
      PIDmode = modeTurnBack;
    }
    if(PIDmode == modeTurnRight)
    {
      motorLeft_go (10000);
      motorRight_go (-10000);
      timeNow = millis();
      if (timeNow >= timeSet + 340) PIDmode = modeStop;
    }
    if(PIDmode == modeTurnLeft)
    {
      motorLeft_go (-10000);
      motorRight_go (10000);
      timeNow = millis();
      if (timeNow >= timeSet + 320) PIDmode = modeStop;
    }
    if(PIDmode == modeTurnBack)
    {
      motorLeft_go (10000);
      motorRight_go (-10000);
      timeNow = millis();
      if (timeNow >= timeSet + 600) PIDmode = modeStop;
    }
    
    //Go Straight
    if(PIDmode == modeDecide)
    {
      goStraight(10000);
    }
    if(PIDmode == modeStraight)
    {
      speedLeft = 10000;
      speedRight = 10000;
      runAllSensor(); 
      PID();
      if (distFront < 5) PIDmode = modeStop;
    }
    if(PIDmode == modeStop)
    {
      motorLeft_go(0);
      motorRight_go(0);
    }
  }

}
