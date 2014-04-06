#include "global.h"
#include "define.h"
#include "config.h"
#include "Wire.h"

void setup()
{
  //Sensor
  pinMode(sensorLeft,INPUT_ANALOG);
  pinMode(sensorFrontLeft,INPUT_ANALOG);
  pinMode(sensorFront,INPUT_ANALOG);
  pinMode(sensorFrontRight,INPUT_ANALOG);
  pinMode(sensorRight,INPUT_ANALOG);
  //LED display
  pinMode(Led1,OUTPUT);
  pinMode(Led2,OUTPUT);
  pinMode(Led3,OUTPUT);
  //Motor
  pinMode(motorLeftPWM, PWM);
  pinMode(motorLeft1, OUTPUT);
  pinMode(motorLeft2, OUTPUT);
  pinMode(motorRightPWM, PWM);
  pinMode(motorRight1, OUTPUT);
  pinMode(motorRight2, OUTPUT);
  //Encoder
  pinMode(encoderLeftCLK, INPUT);
  pinMode(encoderLeftDir, INPUT);
  pinMode(encoderRightCLK, INPUT);
  pinMode(encoderRightDir, INPUT);
  //Board I/O
  pinMode(BOARD_LED_PIN, OUTPUT);
  pinMode(BOARD_BUTTON_PIN, INPUT);
  
  //I2C setup
//  Wire.begin(0,1);
  
  //Interrupts
//  Timer2.pause();                                      // to set timer clock, please go global.h to change timerRate
//  Timer2.setPrescaleFactor(72);                        // set freq = system(72MHz) / 72 = 1MHz, counter++ for every 1us
//  Timer2.setOverflow(timerRate);                       // Set period = timerRate * 1us
//  Timer2.setChannel1Mode(TIMER_OUTPUT_COMPARE);        // CH1 of timer2 is pin D11
//  Timer2.setCompare(TIMER_CH1, 1);                     // Interrupt at counter = 1
//  Timer2.attachCompare1Interrupt(globalInterrupt);     // the function that will be called
//  Timer2.refresh();                                    // Refresh the timer's count, prescale, and overflow
//  Timer2.resume();                                     // Start the timer counting

  attachInterrupt(encoderLeftCLK, encoderLeftInterrupts, RISING);
  attachInterrupt(encoderRightCLK, encoderRightInterrupts, RISING);
}

void encoderLeftInterrupts(void)
{
  if(millis() == lastTickLeft) return;
  if(digitalRead(encoderLeftDir) == HIGH)
    wheelCountLeft++;
  else
    wheelCountLeft--;
  lastTickLeft = millis();
}

void encoderRightInterrupts(void)
{
  if(millis() == lastTickLeft) return;
  if(digitalRead(encoderRightDir) == HIGH)
    wheelCountRight++;
  else
    wheelCountRight--;
  lastTickRight = millis();
}


void loop()
{
  board_botton();
      
  
}
