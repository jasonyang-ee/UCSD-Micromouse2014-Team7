void motorLeft_Break()
{
  digitalWrite(motorLeft1, HIGH);
  digitalWrite(motorLeft2, HIGH);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, 0);
}
void motorRight_Break()
{
  digitalWrite(motorRight1, HIGH);
  digitalWrite(motorRight2, HIGH);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, 0);
}
void motorLeft_Foward(int speed)
{
  digitalWrite(motorLeft1, HIGH);
  digitalWrite(motorLeft2, LOW);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, speed);
}
void motorRight_Foward(int speed)
{
  digitalWrite(motorRight1, LOW);
  digitalWrite(motorRight2, HIGH);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, speed);
}
void motorLeft_Backward(int speed)
{
  digitalWrite(motorLeft1, LOW);
  digitalWrite(motorLeft2, HIGH);
  digitalWrite(motorLeftSTBY, HIGH);
  pwmWrite(motorLeftPWM, speed);
}
void motorRight_Backward(int speed)
{
  digitalWrite(motorRight1, HIGH);
  digitalWrite(motorRight2, LOW);
  digitalWrite(motorRightSTBY, HIGH);
  pwmWrite(motorRightPWM, speed);
}
