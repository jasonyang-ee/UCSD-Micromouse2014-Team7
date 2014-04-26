//general function
void motorLeft_go(int speed)
{
  if(speed == 0)
    motorLeft_break();
  else if(speed>0)
    motorLeft_forward(speed);
  else if(speed<0)
    motorLeft_backward(-speed);
}
void motorRight_go(int speed)
{
  if(speed == 0)
    motorRight_break();
  else if(speed>0)
    motorRight_forward(speed);
  else if(speed<0)
    motorRight_backward(-speed);
}




//Privite function
void motorLeft_break()
{
  digitalWrite(motorLeft1, HIGH);
  digitalWrite(motorLeft2, HIGH);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, 0);
}
void motorRight_break()
{
  digitalWrite(motorRight1, HIGH);
  digitalWrite(motorRight2, HIGH);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, 0);
}

void motorLeft_forward(int speed)
{
  digitalWrite(motorLeft1, HIGH);
  digitalWrite(motorLeft2, LOW);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, speed);
}

void motorRight_forward(int speed)
{
  digitalWrite(motorRight1, LOW);
  digitalWrite(motorRight2, HIGH);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, speed);
}
void motorLeft_backward(int speed)
{
  digitalWrite(motorLeft1, LOW);
  digitalWrite(motorLeft2, HIGH);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, speed);
}
void motorRight_backward(int speed)
{
  digitalWrite(motorRight1, HIGH);
  digitalWrite(motorRight2, LOW);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, speed);
}
