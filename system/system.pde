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
  mode = modeTurn;
}

void loop()
{ 
  
  //Turn Right
  if(mode == modeTurn)
  {
    timeSet = millis();
    //mode = modeTurnRight;
    //mode = modeTurnLeft;
    mode = modeTurnBack;
  }
  
  if(mode == modeTurnRight)
  {
    motorLeft_go (10000);
    motorRight_go (-10000);
    timeNow = millis();
    if (timeNow >= timeSet + 340) mode = modeStop;
  }
  
  if(mode == modeTurnLeft)
  {
    motorLeft_go (-10000);
    motorRight_go (10000);
    timeNow = millis();
    if (timeNow >= timeSet + 320) mode = modeStop;
  }
  
  if(mode == modeTurnBack)
  {
    motorLeft_go (10000);
    motorRight_go (-10000);
    timeNow = millis();
    if (timeNow >= timeSet + 600) mode = modeStop;
  }
 
  
  //Go Straight
//  if(mode == modeDecide)
//  {
//    goStraight(10000);
//  }
//  
//  if(mode == modeStraight)
//  {
//    speedLeft = 10000;
//    speedRight = 10000;
//    runAllSensor(); 
//    PID();
//    if (distFront < 5) mode = modeStop;
//  }
//  
  if(mode == modeStop)
  {
    motorLeft_go(0);
    motorRight_go(0);
  }

>>>>>>> 807b970267269290e9d082eafd5431ea115a02d1

}
