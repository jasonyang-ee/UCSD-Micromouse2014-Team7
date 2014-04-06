void PID()
{
  switch (PIDmode)
  {
  //Drives straight
  case modeStraight:
    {		      
      //Follows FrontLeft/FrontRight Sensors
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
  }
}

void goStraight(int speed)
{
  //Error Initializations
  errorDiagonalTotal=0;

  wheelCountLeft = 0;
  wheelCountRight = 0;

  //mode set
  PIDmode = modeStraight;          
}

