void PID()
{
  switch (mode)
  {
  //Drives straight
  case modeStraight:
    {		      
      //Follows FrontLeft/FrontRight Sensors
      //Gain values for PID
      int Kp = 1500;
      int Kd = 200;
      int Ki = 0;

      int correction = round(Kp * errorDiagonal + Kd*(errorDiagonalDiff)/.001 + Ki*errorDiagonalTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error
      motorRight_Forward(speedBase + correction);
      motorLeft_Forward(speedBase - correction);            
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
  mode = modeStraight;          
  speedBase = speed;
}


