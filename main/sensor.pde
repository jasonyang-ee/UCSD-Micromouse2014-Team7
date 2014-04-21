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
    if(volt>190)  return ( 10*59217*pow(x,-1.298)  );
    else  return 500;
  }
  
  //Left
  if(c==2)
  {
    if(volt>340)  return ( 10*286485*pow(x,-1.439) );
    else return 500;
  }
  
  //Right
  if(c==3)
  {
    if(volt>800)  return ( 10*10000000*pow(x,-1.944) );
    else return 500;
  }
  
  //Front Left
  if(c==4)
  {

    if(volt>230)  return ( 10*54485*pow(x,-1.28) );
    else  return 500;
  }
  
  //Front Right
  if(c==5)
  {
    if(volt>250)  return ( 10*32443*pow(x,-1.2) );
    else  return 500;
  }
}

void calculateErrorRight()
{
  errorRightLast = errorRight;
  errorRight = ((distDiagonalRight/distRight)-5);
  errorRightDiff = errorRight - errorRightLast;
  errorRightTotal += errorRight;
}

void calculateErrorLeft()
{
  errorLeftLast = errorLeft;
  errorLeft = ((distDiagonalLeft/distLeft)-5);
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

