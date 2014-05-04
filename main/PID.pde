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
          //450 35 for 10000
          int Kp = 200;
          int Kd = 10;
          int Ki = 0;
    
          int correction = round(Kp * errorSide + Kd*(errorSideDiff)/timeDiff + Ki*errorSideTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(50000 + correction);
          motorLeft_go(50000 - correction);
          break;
        }
        case followDiagonalLeft:
        {
          int Kp = 350;
          int Kd = 5;
          int Ki = 0;
          int correction = round(Kp * errorDiagonalLeft + Kd*(errorDiagonalLeftDiff)/timeDiff + Ki*errorDiagonalLeftTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(35000 + correction);
          motorLeft_go(35000 - correction);
          break;
        }
        case followDiagonalRight:
        {
          int Kp = 350;
          int Kd = 5;
          int Ki = 0;
          int correction = round(Kp * errorDiagonalRight + Kd*(errorDiagonalRightDiff)/timeDiff + Ki*errorDiagonalRightTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(35000 - correction);
          motorLeft_go(35000 + correction);
          break;
        }
        case followEncoder:
        {
          //Follows Encoders
          //Gain Values for PID
          int Kp = 150;
          int Kd = 15;
          int Ki = 0;
    
          int correction = round(Kp * errorCount + Kd*(errorCountDiff)/timeDiff + Ki*errorCountTotal);
        
          //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
          motorRight_go(28000 + correction);
          motorLeft_go(28000 - correction);
          break;
        }
      }
      break;
    }
    case modeFix:
    {
      int Kp = 2000;
      int Kd = 100;
      int Ki = 0;
            
      int correctionRight = round(Kp * errorStopRight + Kd*(errorStopRightDiff)/.0001 + Ki*errorStopRightTotal);
      
      Kp = 2000;
      Kd = 100;
      Ki = 0;
      
      int correctionLeft = round(Kp * errorStopLeft + Kd*(errorStopLeftDiff)/.0001 + Ki*errorStopLeftTotal);
      
      if(correctionRight == 2000 || correctionRight == -2000) wheelCountRight = countsNeededRight;
      if(correctionLeft == 2000 || correctionLeft == -2000) wheelCountLeft = countsNeededLeft;
      if(errorStopRight >= 33) wheelCountRight = countsNeededRight;
      if(errorStopLeft >= 33) wheelCountLeft = countsNeededLeft;
      
      motorRight_go(correctionRight);
      motorLeft_go(correctionLeft);
    }
  }
}

//set PID straight follow state
void PID_follower()
{
  if(distDiagonalRight > 95 && distDiagonalLeft > 95 && (distRight > 60 || distLeft > 60))
    modeFollow = followEncoder;
  else if(distDiagonalRight > 95 && distDiagonalLeft < 95 && (distRight > 60 || distLeft > 60))
  {
    modeFollow = followDiagonalLeft;
    if(distFront<50)
      modeFollow = followEncoder;
  }
  else if(distDiagonalRight < 95 && distDiagonalLeft > 95 && (distRight > 60 || distLeft > 60))
  {
    modeFollow = followDiagonalRight;
    if(distFront<50)
      modeFollow = followEncoder;
  } 
  else if(distRight < 60 && distLeft < 60)
    modeFollow = followSide;  
}
