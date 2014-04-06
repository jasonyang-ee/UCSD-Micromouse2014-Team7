
//ADXL345 address: 0x53
//ADXL345 REG:
//HMC5883 address: 0x1E

int* get_compass(void)
{
  uint8 _buff[6];
  int data[3] = {0};
  
  Wire.beginTransmission(0x1E); //open communication with HMC5883
  Wire.send(0x02); //select mode register
  Wire.send(0x00); //continuous measurement mode
  int temp = Wire.endTransmission();
  
  SerialUSB.println(temp);

//  Wire.requestFrom(0x1E, 6);
//  for(int i=0; Wire.available(); i++)
//    _buff[i] = Wire.receive();
//    
//  data[0] = (((int)_buff[1]) << 8) | _buff[0];
//  data[1] = (((int)_buff[3]) << 8) | _buff[2];
//  data[2] = (((int)_buff[5]) << 8) | _buff[4];
//  
//  for(int i=0; i<3; i++)
//  {
//    SerialUSB.print(data[i]);
//    SerialUSB.print("\t");
//  }
//  SerialUSB.println();
  
  return data;
}


int* get_accelerometer(void)
{
  uint8 _buff[6]={0};
  int data[3]={0};
  
  Wire.beginTransmission(0x53);
  Wire.send(0x32);
  int temp = Wire.endTransmission();
    SerialUSB.println(temp);
  
  Wire.requestFrom(0x53, 6);
  for(int i=0; Wire.available(); i++)
    _buff[i] = Wire.receive();

    
  data[0] = (((int)_buff[1]) << 8) | _buff[0];
  data[1] = (((int)_buff[3]) << 8) | _buff[2];
  data[2] = (((int)_buff[5]) << 8) | _buff[4];
  
  return data;
}

void get_tap(void)
{
  int _buff=0;
  Wire.beginTransmission(0x53);
  Wire.send(0x30);
  Wire.requestFrom(0x53, 1);
  if(Wire.available())
    _buff = Wire.receive();
  int temp = Wire.endTransmission();
  SerialUSB.println(_buff);

}
