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
          int Kp = 250;
          int Kd = 10;
          int Ki = 0;
    
          int correction = round(Kp * errorSide + Kd*(errorSideDiff)/timeDiff + Ki*errorSideTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(40000 + correction);
          motorLeft_go(40000 - correction);
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
          int Kp = 200;
          int Kd = 5;
          int Ki = 2;
    
          int correction = round(Kp * errorCount + Kd*(errorCountDiff)/timeDiff + Ki*errorCountTotal);
        
          //positive correction corresponds to a left error, negative correction corresponds to a right error (Not Tested)
          motorRight_go(22000 + correction);
          motorLeft_go(22000 - correction);
          break;
        }
      }
      break;
    }
    case modeCountFix:
    {
      int Kp = 1000;
      int Kd = 10;
      double Ki = .01;
            
      int correctionRight = round(Kp * errorStopRight + Kd*(errorStopRightDiff)/.0001 + Ki*errorStopRightTotal);
      
      Kp = 1000;
      Kd = 10;
      Ki = .01;
      
      int correctionLeft = round(Kp * errorStopLeft + Kd*(errorStopLeftDiff)/.0001 + Ki*errorStopLeftTotal);
      
//      if(correctionRight == 2000 || correctionRight == -1000) wheelCountRight = countsNeededRight;
//      if(correctionLeft == 2000 || correctionLeft == -1000) wheelCountLeft = countsNeededLeft;
//      if(errorStopRight >= 33) wheelCountRight = countsNeededRight;
//      if(errorStopLeft >= 33) wheelCountLeft = countsNeededLeft;

      if(correctionRight > 0) correctionRight += 3000;
      if(correctionRight < 0) correctionRight -= 3000;
      if(correctionLeft < 0) correctionLeft -= 3000;
      if(correctionLeft > 0) correctionLeft += 3000;

      motorRight_go(correctionRight);
      motorLeft_go(correctionLeft);
      break;
    }
    case modeFrontFix:
    {
      
      
      break;
    }
  }
}

//set PID straight follow state
void PID_follower()
{ //Needs to Be Tweaked Still
  if(distDiagonalRight > 95 && distDiagonalLeft > 95 && (distRight > 60 || distLeft > 60))
    modeFollow = followEncoder;
  else if(distDiagonalRight > 95 && distDiagonalLeft < 95 && (distRight > 60 || distLeft > 60))
  {
    modeFollow = followDiagonalLeft;
    if(distFront<90)
      modeFollow = followEncoder;
  }
  else if(distDiagonalRight < 95 && distDiagonalLeft > 95 && (distRight > 60 || distLeft > 60))
  {
    modeFollow = followDiagonalRight;
    if(distFront<90)
      modeFollow = followEncoder;
  } 
  else if(distRight < 60 && distLeft < 60)
    modeFollow = followSide;  
}
