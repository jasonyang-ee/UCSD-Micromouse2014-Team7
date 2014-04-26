//ADXL345 address: 0x53
//ADXL345 REG:

#define HMC5883L_SLA 0x1E
#define HMC5883L_REG_CFG_A 0x00
#define HMC5883L_REG_CFG_B 0x01
#define HMC5883L_REG_MODE 0x02
#define HMC5883L_REG_DATA_X_MSB 0x03
#define HMC5883L_REG_DATA_X_LSB 0x04
#define HMC5883L_REG_DATA_Z_MSB 0x05
#define HMC5883L_REG_DATA_Z_LSB 0x06
#define HMC5883L_REG_DATA_Y_MSB 0x07
#define HMC5883L_REG_DATA_Y_LSB 0x08
#define HMC5883L_REG_STATUS 0x09
#define HMC5883L_REG_ID_A 0x0A
#define HMC5883L_REG_ID_B 0x0B
#define HMC5883L_REG_ID_C 0x0C

void get_compass(void)
{
  int i = 0;
  uint16 buff[6];
  uint16 data[3];
  
  Wire.beginTransmission(0x1E);
  Wire.send(0x02); //sends address to read from
  Wire.send(0x00);
  Wire.endTransmission(); //end transmission
  
  
  Wire.beginTransmission(0x1E);
  Wire.send(0x03); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[0] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0x1E);
  Wire.send(0x04); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[1] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0x1E);
  Wire.send(0x05); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[2] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0x1E);
  Wire.send(0x06); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[3] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0x1E);
  Wire.send(0x07); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[4] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0x1E);
  Wire.send(0x08); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0x1E, 1); //request 1 bytes from device
  while(Wire.available())
    buff[5] = Wire.receive(); // receive one byte

  data[0] = (buff[0] << 8) | buff[1];
  data[1] = (buff[2] << 8) | buff[3];
  data[2] = (buff[4] << 8) | buff[5];
  
  for(int i=0; i<3; i++)
  {
    SerialUSB.print(uint16(data[i]));
    SerialUSB.print("\t");
  }
  SerialUSB.println();
  
}


void get_accelerometer(void)
{
  int i = 0;
  uint16 buff[6];
  int data[3];
  
  Wire.beginTransmission(0xE5);
  Wire.send(0x32); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[0] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0xE5);
  Wire.send(0x33); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[1] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0xE5);
  Wire.send(0x34); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[2] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0xE5);
  Wire.send(0x35); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[3] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0xE5);
  Wire.send(0x36); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[4] = Wire.receive(); // receive one byte
    
  Wire.beginTransmission(0xE5);
  Wire.send(0x37); //sends address to read from
  Wire.endTransmission(); //end transmission
  Wire.requestFrom(0xE5, 1); //request 1 bytes from device
  while(Wire.available())
    buff[5] = Wire.receive(); // receive one byte

  data[0] = (((int)buff[1]) << 8) | buff[0];
  data[1] = (((int)buff[3]) << 8) | buff[2];
  data[2] = (((int)buff[5]) << 8) | buff[4];
  
  for(int i=0; i<3; i++)
  {
    SerialUSB.print(uint16(data[i]));
    SerialUSB.print("\t");
  }
  SerialUSB.println();
}
