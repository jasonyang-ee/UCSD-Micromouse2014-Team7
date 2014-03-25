
//ADXL345 address: 0x53
//ADXL345 REG:
//HMC5883 address: 0x1E

//int* get_I2C(void)
//{
//  int temp=0;
//  Wire.beginTransmission(0x53);
//  Wire.requestFrom(0x32, 1);
//  if(Wire.available())
//  {
//    SerialUSB.print("hi");
//    temp = Wire.receive();
//  }
//  int confirm = Wire.endTransmission();
////  SerialUSB.println(temp);
//  SerialUSB.println(confirm);
//    
//  data[1] = (((int)_buff[1]) << 8) | _buff[0];
//  data[2] = (((int)_buff[3]) << 8) | _buff[2];
//  data[3] = (((int)_buff[5]) << 8) | _buff[4];
//  Wire.endTransmission();
//  return data;
//}
//
//bool put_I2C(int address, int to_write)
//{
//  Wire.beginTransmission(address);
//  Wire.send(to_write);
//  return !(Wire.endTransmission());
//}
