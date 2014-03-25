#ifndef INTERFACE_H
#define INTERFACE_H

#include "global.h"
#include "define.h"
#include "config.h"

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
  digitalWrite(15+systemMode,HIGH);
  digitalWrite(15+(systemMode+1)%3,LOW);
  digitalWrite(15+(systemMode+2)%3,LOW);
}
      
#endif
