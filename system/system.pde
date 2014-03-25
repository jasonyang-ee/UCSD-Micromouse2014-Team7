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
  motorLeft_Break();
  motorRight_Break();
  int temp=0;
  
  Wire.beginTransmission(0x53);
  Wire.send(0x32);
  Wire.requestFrom(0x53, 1);
  if(Wire.available())
  {
    SerialUSB.print("hi");
    temp = Wire.receive();
  }

  int confirm = Wire.endTransmission();

  SerialUSB.println(confirm);
    
    
  
//  int *temp = get_I2C();
//  SerialUSB.print("x: ");
//  SerialUSB.print(temp[0]);
//  SerialUSB.print(" y: ");
//  SerialUSB.print(temp[1]);
//  SerialUSB.print(" z: ");
//  SerialUSB.println(temp[2]);
  
  
//  SerialUSB.print(wheelCountLeft);
//  SerialUSB.print("\t");
//  SerialUSB.println(wheelCountRight);
}
