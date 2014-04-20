void runAllSensor()
{ 
  //read sensor
  int voltFront = (runSensor(sensorFront));
  int voltLeft = (runSensor(sensorLeft));
  int voltRight = (runSensor(sensorRight));
  int voltDiagonalLeft = (runSensor(sensorDiagonalLeft));
  int voltDiagonalRight = (runSensor(sensorDiagonalRight));
 
  //converte voltage to distance
  distFront = convertDistance(voltFront, 1);
  distLeft = convertDistance(voltLeft, 2);
  distRight = convertDistance(voltRight, 3);
  distDiagonalLeft = convertDistance(voltDiagonalLeft, 4);
  distDiagonalRight = convertDistance(voltDiagonalRight, 5);
  
  calculateErrorRight();
  calculateErrorLeft();
  calculateErrorSide();
  calculateErrorDiagonal();
  calculateErrorCount();
}

void sensor_calibration()
{
  int voltFront = (runSensor(sensorFront));
  int voltLeft = (runSensor(sensorLeft));
  int voltRight = (runSensor(sensorRight));
  int voltDiagonalLeft = (runSensor(sensorDiagonalLeft));
  int voltDiagonalRight = (runSensor(sensorDiagonalRight));
  SerialUSB.print(voltLeft);
  SerialUSB.print("\t");
  SerialUSB.print(voltDiagonalLeft);
  SerialUSB.print("\t");
  SerialUSB.print(voltFront);
  SerialUSB.print("\t");
  SerialUSB.print(voltDiagonalRight);
  SerialUSB.print("\t");
  SerialUSB.println(voltRight);
}

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
  double x = volt;
  
  //Front
  if(c==1)
  {
    if(volt>400)  return ( 44953*pow(x,-1.136)  );
    else  return 50;
  }
  
  //Left
  if(c==2)
  {
    if(volt>300)  return ( 245017*pow(x,-1.519) );
    else return 50;
  }
  
  //Right
  if(c==3)
  {
    if(volt>600)  return ( 30000000*pow(x,-2.14) );
    else return 50;
  }
  
  //Front Left
  if(c==4)
  {

    if(volt>300)  return ( -0.00000003*x*x*x + 0.0001*x*x - 0.2117*x + 109.94 );
    else  return 50;
  }
  
  //Front Right
  if(c==5)
  {
    if(volt>300)  return ( 7957.2*pow(x,-0.981) );
    else  return 50;
  }
}

void calculateErrorRight()
{
  errorRightLast = errorRight;
  errorRight = (distLeft - distRight);
  errorRightDiff = errorRight - errorRightLast;
  errorRightTotal += errorRight;
}

void calculateErrorLeft()
{
  errorLeftLast = errorLeft;
  errorLeft = (distLeft - distRight);
  errorLeftDiff = errorLeft - errorLeftLast;
  errorLeftTotal += errorLeft;
}

void calculateErrorSide()
{
  errorSideLast = errorSide;
  errorSide = (distLeft - distRight);
  errorSideDiff = errorSide - errorSideLast;
  errorSideTotal += errorSide;
}

void calculateErrorDiagonal()
{
  errorDiagonalLast = errorDiagonal;
  errorDiagonal = (distDiagonalLeft - distDiagonalRight);
  errorDiagonalDiff = errorDiagonal - errorDiagonalLast;
  errorDiagonalTotal += errorDiagonal;
}

void calculateErrorCount()
{
  errorCountLast = errorCount;
  errorCount = (wheelCountLeft - wheelCountRight);
  errorCountDiff = errorCount - errorCountLast;
  errorCountTotal += errorCount;
}

