#include "global.h"

void setup()
{
//-------------------------------------------------------  pin setup  -------------------------------------------------------//
  pinMode(sensorLeft,INPUT_ANALOG);
  pinMode(sensorFrontLeft,INPUT_ANALOG);
  pinMode(sensorFront,INPUT_ANALOG);
  pinMode(sensorFrontRight,INPUT_ANALOG);
  pinMode(sensorRight,INPUT_ANALOG);

  pinMode(IRLED1,OUTPUT);
  pinMode(IRLED2,OUTPUT);
  pinMode(IRLED3,OUTPUT);
  
  pinMode(redLED,OUTPUT);
  pinMode(blueLED,OUTPUT);
  pinMode(greenLED,OUTPUT);

  pinMode(motorLeft, PWM);
  pinMode(motorLeft2, PWM);
  pinMode(motorRight1, PWM);
  pinMode(motorRight2, PWM);

  pinMode(encoderLeftCLK, INPUT);             //Left encoder clock pin
  pinMode(encoderLeftDirc, INPUT);            //Left encoder direction pin
  pinMode(encoderRightCLK, INPUT);	      //Right encoder clock pin
  pinMode(encoderRightDirc, INPUT);	      //Right encoder direction pin
  
//-------------------------------------------------------  Interrupts  -------------------------------------------------------//
  Timer2.pause();                                      // to set timer clock, please go global.h to change timerRate
  Timer2.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72 = 1MHz, counter++ for every 1us
  Timer2.setOverflow(timerRate);                       // Set period = timerRate * 1us
  Timer2.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer2 is pin D11
  Timer2.setCompare(TIMER_CH1, 1);                     // Interrupt at counter = 1
  Timer2.attachCompare1Interrupt(globalInterrupt);     // the function that will be called
  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
  Timer2.resume();                                     // Start the timer counting

  attachInterrupt(encoderLeftCLK, encoderInterruptsLeft, RISING);   //left encoder
  attachInterrupt(encoderRightCLK, encoderInterruptsRight, RISING);  //right encoder  
}

void encoderInterruptsLeft(void)
{
  if(digitalRead(encoderLeftDirc) == HIGH)  countLeft++;
  else  countLeft--;
}

void encoderInterruptsRight(void)
{
  if(digitalRead(encoderRightDirc) == LOW)  countRight++;
  else  countRight--;
}

void globalInterrupt(void)
{
  timerCurrent = millis();
}

void loop()
{
  
}
