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

void set_heading()
{
  get_compass();
  heading = atan2(compass_raw_y, compass_raw_x);
  if(heading < 0)
    heading += 2*PI;
  if(heading > 2*PI)
    heading -= 2*PI;
  heading = heading * 180/M_PI;
}


void set_compass(void)
{
//  Wire.beginTransmission(HMC5883L_SLA);
//  Wire.send(HMC5883L_REG_CFG_A);
//  Wire.send(0x18);
//  Wire.endTransmission();
//  Wire.beginTransmission(HMC5883L_SLA); //open communication with HMC5883
//  Wire.send(HMC5883L_REG_CFG_B);
//  Wire.send(0xE0);
//  Wire.endTransmission();
  Wire.beginTransmission(HMC5883L_SLA); //open communication with HMC5883
  Wire.send(HMC5883L_REG_MODE); //select mode register
  Wire.send(0x00); //continuous measurement mode
  Wire.endTransmission();
}

uint8 get_registor(int address,int reg)
{
  Wire.beginTransmission(address);
  Wire.send(reg); //select register 3, X MSB register
  Wire.endTransmission();
  Wire.requestFrom(address,1);
  while(!Wire.available());
  return Wire.receive();
}

void get_compass()
{
  int16 buff[6]={0};
  for (int i = 0, reg = HMC5883L_REG_DATA_X_MSB; i<6; i++, reg++)
    buff[i] = get_registor(HMC5883L_SLA,reg);
    
  compass_raw_x = ((buff[0] << 8) | buff[1]);
  compass_raw_z = ((buff[2] << 8) | buff[3]);
  compass_raw_y = ((buff[4] << 8) | buff[5]);
  
}
