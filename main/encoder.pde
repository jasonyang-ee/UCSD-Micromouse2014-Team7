void encoderLeft_interrupts(void)
{
  
//  if(millis() == lastTickLeft) return;
  if(digitalRead(encoderLeftDir) == HIGH)
    wheelCountLeft++;
  else
    wheelCountLeft--;
//  lastTickLeft = millis();
}

void encoderRight_interrupts(void)
{
//  if(millis() == lastTickRight) return;
  if(digitalRead(encoderRightDir) == HIGH)
    wheelCountRight++;
  else
    wheelCountRight--;
//  lastTickRight = millis();
}
