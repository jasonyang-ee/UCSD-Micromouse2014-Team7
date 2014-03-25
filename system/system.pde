#include "global.h"
#include "pinMap.h"
#include "config.h"


void setup()
{
  //LED display
  pinMode(Led1,OUTPUT);
  pinMode(Led2,OUTPUT);
  pinMode(Led3,OUTPUT);
  //Encoder
  pinMode(encoderLeftCLK, INPUT);
  pinMode(encoderLeftDir, INPUT);
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDir, INPUT);
  //Board I/O
  pinMode(BOARD_LED_PIN, OUTPUT);
  pinMode(BOARD_BUTTON_PIN, INPUT);
  
  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}
void encoderLeftInterrupts(void)
{
  if(digitalRead(encoderLeftDir) == HIGH)
    wheelCountLeft++;
  else
    wheelCountLeft--;
}

void encoderRightInterrupts(void)
{
  if(digitalRead(encoderRightDir) == HIGH)
    wheelCountRight++;
  else
    wheelCountRight--;
}

void loop()
{
  board_botton();
  SerialUSB.print(wheelCountRight);
  SerialUSB.print("\t");
  SerialUSB.println(wheelCountLeft);
}
