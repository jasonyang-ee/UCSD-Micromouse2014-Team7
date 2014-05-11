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
  
  //find PID interval
  timeDiff = (micros()*.000001) - timeLast;
  timeLast = micros()*.000001;
  
  //find movement of the mouse
  movementLast = movementNow;
  movementNow = distFront+distLeft+distRight+distDiagonalLeft+distDiagonalRight;
  if(abs(movement - movementLast)<50) movement = 0;
  else movement = 1;
  
  //find PID error
  calculateErrorRight();
  calculateErrorLeft();
  calculateErrorSide();
  calculateErrorDiagonalLeft();
  calculateErrorDiagonalRight();
  calculateErrorCount();
  calculateErrorStop();
  calculateErrorFront();
  calculateErrorDiagonal();
}

//print out voltage
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

//print out converted value
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

//privite function for runAll
int runSensor(int sensorRef)
{
  int sampleNum = 20;
  int voltage = 0;
  for(int i=0; i<sampleNum; i++)
    voltage += analogRead(sensorRef);
  voltage /= sampleNum;
  
  return voltage;
}

//voltage to distance
double convertDistance(int volt, int c)
{
  double x = volt;
 
  //Front
  if(c==1)
  {
    if(volt>190)  return (10*13409*pow(x,-1.052));
    else  return 500;
  }
  
  //Left
  if(c==2)
  {
    if(volt>340)  return (10*50000000*pow(x,-2.139));
    else return 500;
  }
  
  //Right
  if(c==3)
  {
    if(volt>800)  return (10*10000000*pow(x,-1.935));
    else return 500;
  }
  
  //Front Left
  if(c==4)
  {

    if(volt>230)  return (10*2583*pow(x,-0.793));
    else  return 500;
  }
  
  //Front Right
  if(c==5)
  {
    if(volt>250)  return (10*22607*pow(x,-1.124));
    else  return 500;
  }
  
  return 0;
}



//error for PID
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
//  if(distLeft > 350)
//    errorSide = distLeft-340-distRight;
//  if(distLeft > 320)
//    errorSide = distLeft - distRight - 300;
//  if(distLeft < 100 && distRight <100)
    errorSide = (distLeft - distRight) - 10;
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

void calculateErrorStop()
{
  errorStopRightLast = errorStopRight;
  errorStopRight = (countsNeededRight - wheelCountRight);
  errorStopRightDiff = errorStopRight - errorStopRightLast;
  errorStopRightTotal += errorStopRight;
  
  errorStopLeftLast = errorStopLeft;
  errorStopLeft = (countsNeededLeft - wheelCountLeft);
  errorStopLeftDiff = errorStopLeft - errorStopLeftLast;
  errorStopLeftTotal += errorStopLeft;
}

void calculateErrorFront()
{
  errorFrontLast = errorFront;
  errorFront = (distFront - 25);
  errorFrontDiff = errorFront - errorFrontLast;
  errorFrontTotal += errorFront;
}

void calculateErrorDiagonal()
{
  errorDiagonalLast = errorDiagonal;
  errorDiagonal = ((distDiagonalLeft - distDiagonalRight) - 7);
  errorDiagonalDiff = errorDiagonal - errorDiagonalLast;
  errorDiagonalTotal += errorDiagonal;
}
