

void PID(int mode)
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

      int correction = round(Kp * status.errorDiagonal + Kd*(status.errorDiagonalDiff)/.001 + Ki*status.errorDiagonalTotal);

      //positive correction corresponds to a left error, negative correction corresponds to a right error
      motor.motorRight(status.speedBase + correction);
      motor.motorLeft(status.speedBase - correction);            
      break;
    }  
  }
}
