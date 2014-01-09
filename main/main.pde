#include "global.h"

void setup()
{
//-------------------------------------------------------  pin setup  -------------------------------------------------------//
  pinMode(sensorLeft,INPUT_ANALOG);
  pinMode(sensorFrontLeft,INPUT_ANALOG);
  pinMode(sensorFront,INPUT_ANALOG);
  pinMode(sensorFrontRight,INPUT_ANALOG);
  pinMode(sensorRight,INPUT_ANALOG);

  pinMode(LedIR1,OUTPUT);
  pinMode(LedIR2,OUTPUT);
  pinMode(LedIR3,OUTPUT);
  
  pinMode(LedRed,OUTPUT);
  pinMode(LedBlue,OUTPUT);
  pinMode(LedGreen,OUTPUT);

  pinMode(motorLeft1, PWM);
  pinMode(motorLeft2, PWM);
  pinMode(motorRight1, PWM);
  pinMode(motorRight2, PWM);

  pinMode(encoderLeftCLK, INPUT);     //Left encoder clock pin
  pinMode(encoderLeftDirc, INPUT);    //Left encoder direction pin
  pinMode(encoderRightCLK, INPUT);    //Right encoder clock pin
  pinMode(encoderRightDirc, INPUT);   //Right encoder direction pin
  
  pinMode(BOARD_LED_PIN, OUTPUT);
  pinMode(BOARD_BUTTON_PIN, INPUT);
  
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
  if(digitalRead(encoderLeftDirc) == HIGH)  rotationLeft++;
  else  rotationLeft--;
}

void encoderInterruptsRight(void)
{
  if(digitalRead(encoderRightDirc) == LOW)  rotationRight++;
  else  rotationRight--;
}

void globalInterrupt(void)
{
  F.globalInterrupt();
  if(stage == driving)
  {
    //get new sensor data
    //calculate sensor value
    //calculate PID value
  }
}

void loop()
{
  //accept button input to decide mode
  
  
  if(mode == debug)
  {
    //print out some raw data of all device
  }
  else if(mode == goTest)
  {
    if(stage == prep)
    {
      //initialize sensor
      //accept start signal
    }
    else if(stage == driving)
    {
      
    }
    else if(stage == breaking)
    {
      
    }
  }
  else if(mode == turnTest)
  {
    
  }
}
