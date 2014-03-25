void encoderLeft_interrupts(void)
{
  if(digitalRead(encoderLeftDir) == HIGH)
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
