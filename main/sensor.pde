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
  
  timeDiff = (micros()*.000001) - timeLast;
  timeLast = micros()*.000001;
  
  calculateErrorRight();
  calculateErrorLeft();
  calculateErrorSide();
  calculateErrorDiagonalLeft();
  calculateErrorDiagonalRight();
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

void sensor_read()
{
  SerialUSB.print(distLeft);
  SerialUSB.print("\t");
  SerialUSB.print(distDiagonalLeft);
  SerialUSB.print("\t");
  SerialUSB.print(distFront);
  SerialUSB.print("\t");
  SerialUSB.print(distDiagonalRight);
  SerialUSB.print("\t");
  SerialUSB.println(distRight);
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
    if(volt>190) return ( 10*7481.6*pow(x,-1.025) );
    else return 500;
  }
  
  //Left
  if(c==2)
  {
    if(volt>340) return ( 10*80175*pow(x,-1.369) );
    else return 500;
  }
  
  //Right
  if(c==3)
  {
    if(volt>800) return ( 10*40000000*pow(x,-2.073) );
    else return 500;
  }
  
  //Front Left
  if(c==4)
  {

    if(volt>230) return ( 10*24524*pow(x,-1.158) );
    else return 500;
  }
  
  //Front Right
  if(c==5)
  {
    if(volt>250) return ( 10*8442.9*pow(x,-1.034) );
    else return 500;
  }
}

void calculateErrorRight()
{
  errorRightLast = errorRight;
  errorRight = ((distDiagonalRight/distRight)-7);
  errorRightDiff = errorRight - errorRightLast;
  errorRightTotal += errorRight;
}

void calculateErrorLeft()
{
  errorLeftLast = errorLeft;
  errorLeft = ((distDiagonalLeft/distLeft)-7);
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

void calculateErrorDiagonalLeft()
{
  errorDiagonalLeftLast = errorDiagonalLeft;
  errorDiagonalLeft = (distDiagonalLeft - initialDiagonalLeft);
  errorDiagonalLeftDiff = errorDiagonalLeft - errorDiagonalLeftLast;
  errorDiagonalLeftTotal += errorDiagonalLeft;
}

void calculateErrorDiagonalRight()
{
  errorDiagonalRightLast = errorDiagonalRight;
  errorDiagonalRight = (distDiagonalRight - initialDiagonalRight);
  errorDiagonalRightDiff = errorDiagonalRight - errorDiagonalRightLast;
  errorDiagonalRightTotal += errorDiagonalRight;
}

void calculateErrorCount()
{
  errorCountLast = errorCount;
  errorCount = (wheelCountLeft - wheelCountRight);
  errorCountDiff = errorCount - errorCountLast;
  errorCountTotal += errorCount;
}

