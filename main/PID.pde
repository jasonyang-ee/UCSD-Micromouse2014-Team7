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
          //300 5 for 10000
          int Kp = 450;
          int Kd = 35;
          int Ki = 0;
    
          int correction = round(Kp * errorSide + Kd*(errorSideDiff)/timeDiff + Ki*errorSideTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);
          break;
        }
        case followDiagonalLeft:
        {
          int Kp = 600;
          int Kd = 5;
          int Ki = 0;
          int correction = round(Kp * errorDiagonalLeft + Kd*(errorDiagonalLeftDiff)/timeDiff + Ki*errorDiagonalLeftTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);
          break;
        }
        case followDiagonalRight:
        {
          int Kp = 600;
          int Kd = 5;
          int Ki = 0;
          int correction = round(Kp * errorDiagonalRight + Kd*(errorDiagonalRightDiff)/timeDiff + Ki*errorDiagonalRightTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft - correction);
          motorLeft_go(speedRight + correction);
          break;
        }
        case followLeft:
        {
          //Follows Side Sensors
          //Gain values for PID
          //good result 1500 10
          int Kp = 750;
          int Kd = 25;
          int Ki = 0;
    
          int correction = round(Kp * errorLeft + Kd*(errorLeftDiff)/timeDiff + Ki*errorLeftTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);
          break;
        }
        case followRight:
        {
          //Follows Side Sensors
          //Gain values for PID
          //good result 1500 10
          int Kp = 750;
          int Kd = 25;
          int Ki = 0;
    
          int correction = round(Kp * errorRight + Kd*(errorRightDiff)/timeDiff + Ki*errorRightTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);
          break;
        }
        case followEncoder:
        {
          //Follows Encoders
          //Gain Values for PID
          double Kp = 300;
          double Kd = 5;
          double Ki = 0;
    
          int correction = round(Kp * errorCount + Kd*(errorCountDiff)/timeDiff + Ki*errorCountTotal);
          
          
          //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
          motorRight_go(speedLeft + correction);
          motorLeft_go(speedRight - correction);
          break;
        }
        case followNone:
        {
          motorRight_go(speedLeft);
          motorLeft_go(speedRight);
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



