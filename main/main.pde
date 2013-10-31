#include "global.h"

void setup()
{
//-------------------------------------------------------  pin setup  -------------------------------------------------------//
  pinMode(sensorFrontLeft,INPUT_ANALOG);      //int sensorFrontLeft
  pinMode(sensorFrontRight,INPUT_ANALOG);     //int sensorFrontRight
  pinMode(sensorDiagonalLeft,INPUT_ANALOG);   //int sensorDiagonalLeft
  pinMode(sensorDiagonalRight,INPUT_ANALOG);  //int sensorDiagonalRight
  pinMode(sensorSideLeft,INPUT_ANALOG);       //int sensorSideLeft
  pinMode(sensorSideRight,INPUT_ANALOG);      //int sensorSideRight

  pinMode(ledOne,OUTPUT);                     //int led
  pinMode(ledTwo,OUTPUT);                     //int led
  pinMode(ledThree,OUTPUT);                   //int led

  pinMode(PWMLeft, PWM);                      //PWM control of Left Motor
  pinMode(motorLeft1, OUTPUT);		      //direction control of Left Motor
  pinMode(motorLeft2, OUTPUT);		      //direction control of Left Motor
  pinMode(PWMRight, PWM);                     //PWM control of Right Motor
  pinMode(motorRight1, OUTPUT);  	      //direction control of Right Motor
  pinMode(motorRight2, OUTPUT);		      //direction control of Right Motor
  pwmWrite(PWMLeft, 0);                       //initialize speed of 
  pwmWrite(PWMRight, 0);                      //both motors to 0

  pinMode(encoderLeftCLK, INPUT);             //Left encoder clock pin
  pinMode(encoderLeftDirc, INPUT);            //Left encoder direction pin
  pinMode(encoderRightCLK, INPUT);	      //Right encoder clock pin
  pinMode(encoderRightDirc, INPUT);	      //Right encoder direction pin
  
  digitalWrite(ledOne, HIGH);
  digitalWrite(ledTwo, HIGH);
  digitalWrite(ledThree, HIGH);
  
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
  timerCount = (timerCount++) % (1000000/timerRate);  //refresh for every 1 sec

}

void loop()
{
  
}
