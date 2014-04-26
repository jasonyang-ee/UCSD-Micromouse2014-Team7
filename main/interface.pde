//void board_botton()
//{
//  if(millis() - buttonTime > 200){    //to stablize the input preventing double pressing
//    buttonState = digitalRead(BOARD_BUTTON_PIN);
//    if(buttonState != lastButtonState)
//      if (buttonState == HIGH)
//        systemMode = ++systemMode%3;              //increaments mode
//    lastButtonState = buttonState;
//    buttonTime = millis();
//  }
//}


int board_switch()
{
  int switchValue = 0;
  int bit0 = digitalRead(switch1);
  int bit1 = digitalRead(switch2);
  switchValue = (bit0 + 2*bit1);
  return switchValue;
}

void board_display()
{
  //change LED output setting base on mode
  digitalWrite(12+(systemMode+0)%3,LOW);
  digitalWrite(12+(systemMode+1)%3,LOW);
  digitalWrite(12+(systemMode+2)%3,LOW);
  switch(systemMode)
  {
    case 1: {digitalWrite(12+systemMode-1,HIGH); break;}
    case 2: {digitalWrite(12+systemMode-1,HIGH); break;}
    case 3: {digitalWrite(12+systemMode-1,HIGH); break;}
  }
}

