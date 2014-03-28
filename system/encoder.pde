int get_encoderLeft(void)
{

}

void encoderLeft_interrupts(void)
{
  if(digitalRead(encoderLeftDir) == LOW)
    wheelCountLeft+=4;
  else
    wheelCountLeft-=4;
}

void encoderRight_interrupts(void)
{
  if(digitalRead(encoderRightDir) == HIGH)
    wheelCountRight++;
  else
    wheelCountRight--;
}
