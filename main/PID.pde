void PID()
{
  switch (PIDmode)
  {
    //Drives straight
    case modeStraight:
    {
      switch (modeFollow)
      {
        case followSide:
        {      
          //Follows Side Sensors
          //Gain values for PID
          int Kp = 1000;
          int Kd = 800;
          int Ki = 0;
    
          int correction = round(Kp * errorSide + Kd*(errorSideDiff)/.0001 + Ki*errorSideTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);            
          break;
        }
        case followEncoder:
        {
          //Follows Encoders
          //Gain Values for PID
          double Kp = 5;
          double Kd = 0;
          double Ki = 0;
    
          int correction = round(Kp * errorCount + Kd*(errorCountDiff)/.0001 + Ki*errorCountTotal);
          
          
          //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);            
          break;
        }
      }
      break;
    }
    case modeTurnRight:
    {
      //Follows Encoders
      //Gain Values for PID
      int Kp = 1000;
      int Kd = 800;
      int Ki = 0;

      int correction = round(Kp * errorCount + Kd*(errorCountDiff)/.0001 + Ki*errorCountTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
      motorRight_go(speedLeft + correction);
      motorLeft_go(speedRight - correction);            
      break;
    }
    case modeTurnLeft:
    {
      //Follows Encoders
      //Gain Values for PID
      int Kp = 1000;
      int Kd = 800;
      int Ki = 0;

      int correction = round(Kp * errorCount + Kd*(errorCountDiff)/.0001 + Ki*errorCountTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
      motorRight_go(speedLeft + correction);
      motorLeft_go(speedRight - correction);            
      break;
    }
    case modeTurnBack:
    {
      //Follows Encoders
      //Gain Values for PID
      int Kp = 1000;
      int Kd = 800;
      int Ki = 0;

      int correction = round(Kp * errorCount + Kd*(errorCountDiff)/.0001 + Ki*errorCountTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
      motorRight_go(speedLeft + correction);
      motorLeft_go(speedRight - correction);            
      break;
    }
    case modeStop:
    {
      //Follows Encoders
      //Gain Values for PID
      int Kp = 0;
      int Kd = 0;
      int Ki = 0;

      int correction = round(Kp * errorCount + Kd*(errorCountDiff)/.0001 + Ki*errorCountTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
      motorRight_go(speedLeft + correction);
      motorLeft_go(speedRight - correction);            
      break;
    } 
  }
}

void goStraight()
{
  //Error Initializations
  errorDiagonalTotal=0;

  wheelCountLeft = 0;
  wheelCountRight = 0;

  //mode set
  PIDmode = modeStraight;          
}

