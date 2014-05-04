#include "global.h"
#include "pinMap.h"
#include "config.h"
#include "Wire.h"
#include <stdio.h>


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
  
//  Wire.begin(0,1);
//  delay(1000);
//  set_compass();
  
  setup_maze(16);
  toCenter = true;
  
  PIDmode = modeStop;
  modeFollow = followEncoder;
}

void loop()
{
  //char* buffer;
  //read user setting
  systemMode = board_switch();
  board_display();
  
  switch(systemMode)
  {
    case 3:
    {
      motorFloat();
      SerialUSB.print(wheelCountLeft);
      SerialUSB.print("\t");
      SerialUSB.println(wheelCountRight);
      break;
    }
    case 2:
    {
      waitForButtonPress();
      SerialUSB.println("BEEP");
      break;
    }
    //sensor test mode
    case 1:
    {
      motorLeft_go(0);
      motorRight_go(0);
      delay(500);
      runAllSensor();
      //sensor_calibration();
      sensor_read();
      break;
    }
  
    case 0:  //main searching mode input by user
    {
      runAllSensor();
      //PID_follower();
      if(PIDmode == modeStraight)
      {
        PID();
        if(distFront < 45) PIDmode = modeStop;
//        if(distFront < 240)
//        {
//          wheelCountLeft = 0;
//          wheelCountRight = 0;
//          modeFollow = followEncoder;
//          if(distFront < 40)  PIDmode = modeStop;
//        }
      }
      
      if(PIDmode == modeStraightOne)
      {  //Goes Straight One Cell, Will Activate Fist Everytime
        PIDmode = modeStraight;
        PID_follower();
        //modeFollow = followEncoder;
        PID();
        PIDmode = modeStraightOne;
        if(wheelCountRight >= 420 && wheelCountLeft >= 420)
        {
          motorLeft_go(0);
          motorRight_go(0);
          countsNeededLeft = 420;
          countsNeededRight = 420;
          //if(modeFollow == followEncoder)PIDmode = modeFix;
          //else 
          PIDmode = modeStop;
        }
        if(distFront < 30) PIDmode = modeStop;
      }

       ///////////////////TURNING///////////////////////////////
      if(PIDmode == modeTurnRight)
      {
        motorLeft_go (30000);
        if (wheelCountLeft >= 168)
        {
          motorLeft_go(0);
          delay(50);
          motorRight_go (-30000);
          if(wheelCountRight <= -168)
          {
            motorLeft_go(0);
            motorRight_go(0);
            countsNeededLeft = 168;
            countsNeededRight = -168;
            PIDmode = modeFix;
          }
        }
      }
      
      if(PIDmode == modeTurnLeft)
      {
        motorRight_go (30000);
        if (wheelCountRight >= 168)
        {
          motorRight_go(0);
          delay(50);
          motorLeft_go (-30000);
          if(wheelCountLeft <= -168)
          {
            motorLeft_go(0);
            motorRight_go(0);
            countsNeededLeft = -168;
            countsNeededRight = 168;
            PIDmode = modeFix;
          }
        }
      }
      
      if(PIDmode == modeTurnBack)
      {
        motorLeft_go (30000);
        if (wheelCountLeft >= 168)
        {
          motorLeft_go(0);
          delay(50);
          motorRight_go (-30000);
          if(wheelCountRight <= -168)
          {
            motorLeft_go(0);
            motorRight_go(0);
            countsNeededLeft = 168;
            countsNeededRight = -168;
            turnAgain = true;
            PIDmode = modeFix;
          }
        }
      }
      
      if(PIDmode == modeFix)
      {
        runAllSensor();
        PID();
//        if(errorStopRight == 1 || errorStopLeft == 1) //Since Error of 1 may stop motors with too low PWM
//        {
//          wheelCountRight = countsNeededRight;
//          wheelCountLeft = countsNeededLeft;
//        }
        if(wheelCountRight == countsNeededRight && wheelCountLeft == countsNeededLeft)
        {
          motorLeft_go(0);
          motorRight_go(0);
          delay(100);
          if(wheelCountRight == countsNeededRight && wheelCountLeft == countsNeededLeft)
          {
            PIDmode = modeStop;
            if(turnAgain)
            {
              motorLeft_go(0);
              motorRight_go(0);
              delay(250);
              wheelCountLeft = 0;
              wheelCountRight = 0;
              turnAgain = false;
              PIDmode = modeTurnRight;
            }
          }
        }
      }
      
      if(PIDmode == modeStop)
      {
        motorLeft_go(0);
        motorRight_go(0);
        delay(250);
        wheelCountLeft = 0;
        wheelCountRight = 0;
        solve_maze();
        //PIDmode = modeTurnRight;
      }
      break;
    }
  }//end switch
}//end loop
