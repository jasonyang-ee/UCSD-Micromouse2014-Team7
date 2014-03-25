void board_botton()
{
  if(millis() - buttonTime > 200){    //to stablize the input preventing double pressing
    buttonState = digitalRead(BOARD_BUTTON_PIN);
    if(buttonState != lastButtonState)
      if (buttonState == HIGH)
        systemMode = ++systemMode%3;              //increaments mode
    lastButtonState = buttonState;
    buttonTime = millis();
  }
  //change LED output setting base on mode
  digitalWrite(12+systemMode,HIGH);
  digitalWrite(12+(systemMode+1)%3,LOW);
  digitalWrite(12+(systemMode+2)%3,LOW);
}

