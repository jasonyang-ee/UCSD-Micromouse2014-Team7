#include "function.h"


void Function::globalInterrupt()
{
  
}

////=====================  Motor Driver  =====================//
//void Function::motorDrive(char side, int speed)
//{
//  if(side == 'R')    //If passed in Right motor
//  {
//    if(speed > 0){    //foward
//      pwmWrite(motorRight1, abs(speed));
//      pwmWrite(motorRight2, fullPWM);
//    }
//    else if(speed < 0){    //reverse
//      pwmWrite(motorRight2, abs(speed));
//      pwmWrite(motorRight1, fullPWM);
//    }
//    else if(speed == 0){    //soft breaking
//      pwmWrite(motorRight1, fullPWM);
//      pwmWrite(motorRight2, fullPWM);
//    }
//  }
//  else if(side == 'L')    //If passed in Left motor
//  {
//    if(speed > 0){    //foward
//      pwmWrite(motorLeft1, abs(speed));
//      pwmWrite(motorLeft2, fullPWM);
//    }
//    else if(speed < 0){    //reverse
//      pwmWrite(motorLeft2, abs(speed));
//      pwmWrite(motorLeft1, fullPWM);
//    }
//    else if(speed == 0){    //soft breaking
//      pwmWrite(motorLeft1, fullPWM);
//      pwmWrite(motorLeft2, fullPWM);
//    }
//  }
//}

////=====================  Debug  =====================//
//void Function::debugSystem()
//{
//  SerialUSB.println("========================");
//  SerialUSB.println("System Information:");
//  SerialUSB.print("  Mode:  ");
//  SerialUSB.println(mode);
//  SerialUSB.print("  Stage: ");
//  SerialUSB.println(stage);
//  SerialUSB.println("========================");
//}
//void Function::debugData()
//{
//}
//void Function::debugMaze()
//{
//}

////=====================  Mode Select  =====================//
//void Function::buttonInput()
//{
//  if(millis() - buttonTime > 200){    //to stablize the input preventing double pressing
//    buttonState = digitalRead(BOARD_BUTTON_PIN);
//    if(buttonState != lastButtonState)
//      if (buttonState == HIGH)
//        mode = ++mode%3;              //increaments mode
//    lastButtonState = buttonState;
//    buttonTime = millis();
//  }
//  //change LED output setting base on mode
//  digitalWrite(15+mode,HIGH);
//  digitalWrite(15+(mode+1)%3,LOW);
//  digitalWrite(15+(mode+2)%3,LOW);
//}


////=====================  I2C  =====================//
//int Function::I2CRead()
//{
//  int data;
//  Wire.beginTransmission(switchAddress);
//  Wire.requestFrom(switchAddress, 1);
//  if(Wire.available() )
//    data = Wire.receive();
//  else
//    data = 0x00;
//  Wire.endTransmission();
//  return data;
//}
//
//bool Function::I2cWrite(int to_write)
//{
//  Wire.beginTransmission(switchAddress);
//  Wire.send(to_write);
//  return !(Wire.endTransmission());
//}

