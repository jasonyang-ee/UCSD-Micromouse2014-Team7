
void encoderLeft(void)
{
  if((millis()-encoderTimeLeft)>50)
    if(abs(wheelCountLeft)-abs(lastCountLeft)>0.05*(speedLeft+100))
      wheelCountLeft = wheelCountRight;
    else lastCountLeft = wheelCountLeft;
    
  encoderLeft_interrupts();
}
void encoderRight(void)
{
  if((millis()-encoderTimeRight)>50)
    if(abs(wheelCountRight)-abs(lastCountRight)>0.05*(speedRight+100))
      wheelCountRight = wheelCountLeft;
    else lastCountRight = wheelCountRight;
    
  encoderRight_interrupts();
}

void encoderLeft_interrupts(void)
{
  if(digitalRead(encoderLeftDir) == LOW)
    wheelCountLeft++;
  else
    wheelCountLeft--;
}

void encoderRight_interrupts(void)
{
  if(digitalRead(encoderRightDir) == HIGH)
    wheelCountRight++;
  else
    wheelCountRight--;
}
