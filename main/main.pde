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
  reset_position();
  priorityRight = true;
  
  PIDmode = modeStop;
  modeFollow = followEncoder;
}

void loop()
{
  
  //if(systemMode != board_switch()) delay(5000);
  
  systemMode = board_switch();
  board_display();
  
  switch(systemMode)
  {
    case 3:
    { //Not currently used
      motorFloat();
      delay(500);
      runAllSensor();
      sensor_read();
//      SerialUSB.print(wheelCountLeft);
//      SerialUSB.print("\t");
//      SerialUSB.println(wheelCountRight);
      break;
    }
    case 2:
    {
//      motorLeft_go(4000);
//      motorRight_go(4000);
      //Switches to Left Priority, Cannot Switch Back
      if(priorityRight) priorityRight = false;
      break;
    }
    case 1:
    {
      reset_position();
      break;
    }
  
    case 0:  //main searching mode input by user
    {
      runAllSensor();
      
      if(PIDmode == modeStraight)
      {
        PID();
        if(distFront < 100) PIDmode = modeStop;
      }
      
      if(PIDmode == modeStraightOne)
      {  //Goes Straight One Cell, Will Activate First Everytime
        PIDmode = modeStraight;
        PID_follower();
        //modeFollow = followEncoder;
        PID();
        PIDmode = modeStraightOne;
        if(wheelCountRight >= 440 && wheelCountLeft >= 440)
        {
          if(distFront < 100)
            PIDmode = modeFrontFix;
          else
            PIDmode = modeStop;
        }
        if(distFront < 120) PIDmode = modeFrontFix;
      }

       ///////////////////TURNING///////////////////////////////
      if(PIDmode == modeTurnRight)
      {
        motorLeft_go (20000);
        motorRight_go (-20000);
        if (wheelCountLeft >= 171)
        {
          motorLeft_go(0);
        }
        if(wheelCountRight <= -171)
        {
          motorRight_go(0);
        }
        if(wheelCountRight <= -171 && wheelCountLeft >= 171)
        {
          motorRight_go(0);
          motorLeft_go(0);
          countsNeededLeft = 171;
          countsNeededRight = -171;
          PIDmode = modeCountFix;
        }
       }
      
      if(PIDmode == modeTurnLeft)
      {
        motorRight_go (20000);
        motorLeft_go (-20000);
        if (wheelCountRight >= 171)
        {
          motorRight_go(0);
        }
        if(wheelCountLeft <= -171)
        {
          motorLeft_go(0);
        }
        if(wheelCountRight >= 171 && wheelCountLeft <= -171)
        {
          motorRight_go(0);
          motorLeft_go(0);
          countsNeededLeft = -171;
          countsNeededRight = 171;
          PIDmode = modeCountFix;
        }
      }
      
      if(PIDmode == modeTurnBack)
      {
        if(distLeft < 40)
        {
          turnAgain = modeTurnLeft;
          PIDmode = modeTurnLeft;
        }
        else
        {
          turnAgain = modeTurnRight;
          PIDmode = modeTurnRight;
        }
      }
      
      if(PIDmode == modeCountFix)
      {
        runAllSensor();
        PID();
        if(wheelCountRight == countsNeededRight && wheelCountLeft == countsNeededLeft)
        {
          motorLeft_go(0);
          motorRight_go(0);
          delay(100);
          if(wheelCountRight == countsNeededRight && wheelCountLeft == countsNeededLeft)
          {
            if(distFront < 80)
              PIDmode = modeFrontFix;
            else
            {
              PIDmode = modeStop;
              if(turnAgain)
              {
                motorLeft_go(0);
                motorRight_go(0);
                delay(200);
                wheelCountLeft = 0;
                wheelCountRight = 0;
                errorStopRightTotal = 0;
                errorStopLeftTotal = 0;
                if(turnAgain == modeTurnRight)
                  PIDmode = modeTurnRight;
                else if(turnAgain == modeTurnLeft)
                  PIDmode = modeTurnLeft;
                turnAgain = false;
              }
            }
          }
        }
      }
      
      if(PIDmode == modeFrontFix)
      {
        runAllSensor();
        PID();
        if(abs(errorFront) >= 01)
          modeFix = fixFront;
        else if(abs(errorDiagonal) >= 1)
          modeFix = fixDiagonals;
        else if (abs(errorFront) <= 1 && abs(errorDiagonal) <= 1)
        {
          modeFix = fixFront; //Always Starts with Front Fix Next Time
          PIDmode = modeStop;
          if(turnAgain)
          {
            motorLeft_go(0);
            motorRight_go(0);
            delay(200);
            wheelCountLeft = 0;
            wheelCountRight = 0;
            errorStopRightTotal = 0;
            errorStopLeftTotal = 0;
            if(turnAgain == modeTurnRight)
              PIDmode = modeTurnRight;
            else if(turnAgain == modeTurnLeft)
              PIDmode = modeTurnLeft;
            turnAgain = false;
          }
        }
      }
        
      if(PIDmode == modeStop)
      {
        motorLeft_go(0);
        motorRight_go(0);
        delay(100);
        wheelCountLeft = 0;
        wheelCountRight = 0;
        errorCountTotal = 0;
        errorStopRightTotal = 0;
        errorStopLeftTotal = 0;
        solve_maze();
        //If At Goal, will Stop Indefinitely Until Switch Case
        //PIDmode = modeTurnBack ;
      }
      break;
    }
  }//end switch
}//end loop
