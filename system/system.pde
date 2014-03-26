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
}

void loop()
{
//  if(abs(wheelCountLeft)>120)
//    motorLeft_go(0);
//  else   motorLeft_go(10000);
  
  
  motorLeft_go(0);
  motorRight_go(0);
  SerialUSB.print(wheelCountLeft);
  SerialUSB.print("\t");
  SerialUSB.println(wheelCountRight);
//  if(wheelCountLeft<90) motorLeft_go(10000);
//  else motorLeft_go(0);
//  if(wheelCountRight>(-90)) motorRight_go(-7500);
//  else motorRight_go(0);
//  
//  if(speedLeft == 0 && speedRight == 0)
//  {
//    wheelCountLeft = 0;
//    wheelCountRight = 0;
//    delay(500);
//  }
}
