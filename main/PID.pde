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
          int Kp = 300;
          int Kd = 25;
          int Ki = 0;
    
          int correction = round(Kp * errorSide + Kd*(errorSideDiff)/timeDiff + Ki*errorSideTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(35000 + correction);
          motorLeft_go(35000 - correction);
          break;
        }
        case followDiagonalLeft:
        {
          int Kp = 1300;
          int Kd = 12;
          int Ki = 0;
          int correction = round(Kp * errorDiagonalLeft + Kd*(errorDiagonalLeftDiff)/timeDiff + Ki*errorDiagonalLeftTotal);
    
          //positive correction corresponds to a left error, negative correction corresponds to a right error
          motorRight_go(35000 + correction);
          motorLeft_go(35000 - correction);
          break;
        }
        case followDiagonalRight:
        {
          int Kp = 1300;
          int Kd = 12;
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
          int Ki = 1;
    
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

      if(correctionRight > 0) correctionRight += 4000;
      if(correctionRight < 0) correctionRight -= 4000;
      if(correctionLeft < 0) correctionLeft -= 4000;
      if(correctionLeft > 0) correctionLeft += 4000;

      motorRight_go(correctionRight);
      motorLeft_go(correctionLeft);
      break;
    }
    case modeFrontFix:
    {
      switch(modeFix)
      {
        case fixFront:
        {
          //Gain Values for PID
          int Kp = 3000;
          int Kd = 2;
          int Ki = 0;
    
          int correction = round(Kp * errorFront + Kd*(errorFrontDiff)/timeDiff + Ki*errorFrontTotal);
          
          if(correction > 0) correction += 5000;
          if(correction < 0) correction -= 5000;
        
          motorRight_go(correction);
          motorLeft_go(correction);
          
          break;
        }
        case fixDiagonals:
        {
          //Gain Values for PID
          int Kp = 2000;
          int Kd = 2;
          int Ki = 0;

          int correction = round(Kp * errorDiagonal + Kd*(errorDiagonalDiff)/timeDiff + Ki*errorDiagonalTotal);
          
          if(correction > 0) correction += 4000;
          if(correction < 0) correction -= 4000;
        
          motorRight_go(-correction);
          motorLeft_go(correction);
          break;
        }
      }
      break;
    }
  }
}

//set PID straight follow state
void PID_follower()
{ //Needs to Be Tweaked Still
  
  if(distDiagonalRight > 185 && distDiagonalLeft > 185 && (distRight > 60 || distLeft > 60))
    modeFollow = followEncoder;
  else if(distDiagonalRight > 185 && distDiagonalLeft < 185 && (distLeft < 60))
  {
    modeFollow = followDiagonalLeft;
    if(distFront<130)
      modeFollow = followEncoder;
  }
  else if(distDiagonalRight < 185 && distDiagonalLeft > 185 && (distRight < 60))
  {
    modeFollow = followDiagonalRight;
    if(distFront<130)
      modeFollow = followEncoder;
  }
  else if(distRight < 60 && distLeft < 60)
    modeFollow = followSide;  


//  if((distLeft < 80 && distRight < 80) && (distDiagonalRight < 290) && (distDiagonalLeft < 170))
//    modeFollow = followSide;
//  else
//    modeFollow = followEncoder;
    

  if((((wheelCountRight + wheelCountLeft)/2) < 50) || (((wheelCountRight + wheelCountLeft)/2) > 250)) modeFollow = followEncoder;
      
  if(modeFollowLast != modeFollow)
  {
    if(modeFollow == followEncoder)
    {
      countOffset = wheelCountLeft - wheelCountRight;
      runAllSensor();
    }
  }
    
  modeFollowLast = modeFollow;
}
