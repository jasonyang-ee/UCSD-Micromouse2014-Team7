void runAllSensor()
{ 
  //read sensor
  voltFront = (runSensor(sensorFront));
  voltLeft = (runSensor(sensorLeft));
  voltRight = (runSensor(sensorRight));
  voltDiagonalLeft = (runSensor(sensorDiagonalLeft));
  voltDiagonalRight = (runSensor(sensorDiagonalRight));
 
  //converte voltage to distance
  distFront = convertDistance(voltFront, 1);
  distLeft = convertDistance(voltLeft, 2);
  distRight = convertDistance(voltRight, 3);
  distDiagonalLeft = convertDistance(voltDiagonalLeft, 4);
  distDiagonalRight = convertDistance(voltDiagonalRight, 5);
  
  calculateErrorDiagonal();
}


/*=======================================================  individual sensor  =======================================================*/
int runSensor(int sensorRef)
{
  int sampleNum = 20;
  int voltage = 0;
  for(int i=0; i<sampleNum; i++)
    voltage += analogRead(sensorRef);
  voltage /= sampleNum;
  
  return voltage;
}

double convertDistance(int volt, int c)
{
  double x = 1.0/volt;
  
  //Front
  if(c==1)
  {
    // dist = -998.25*(1/v)^2 + 270.64*(1/v) -1.1891
    if(volt>9)  return (( -998.25*x*x + 270.64*x - 1.1891));
    else  return 20;
  }
  
  //Left
  if(c==2)
  {
    // dist = -414.6(1/V)^2 + 143(1/V) - 0.9423
    if(volt>6)  return ( (-414.6*x*x + 143*x - 0.9423));
    else return 20;
  }
  
  //Right
  if(c==3)
  {
    // dist = 773.41(1/V)^2 + 96.525(1/V) - 0.6535
    if(volt>8)  return ( 773.41*x*x + 96.525*x - 0.6535);
    else  return 20;
  }
  
  //Front Left
  if(c==4)
  {
    // dist = -189.78(1/v)^2 + 156.48(1/v) + 0.1224
    if(volt>7)  return ( -189.78*x*x + 156.48*x - 0.1224);
    else  return 20;
  }
  
  //Front Right
  if(c==5)
  {
    // dist = 173.96(1/v)^2 + 156.82(1/v) - 0.0099
    if(volt>10)  return  (173.96*x*x + 156.82*x + 0.0099);
    else  return 20;
  }
  return 20;
}

void calculateErrorDiagonal()
{
  errorDiagonalLast = errorDiagonal;
  errorDiagonal = (distDiagonalLeft - distDiagonalRight) * 0.707;
  errorDiagonalDiff = errorDiagonal - errorDiagonalLast;
  errorDiagonalTotal += errorDiagonal;
}
