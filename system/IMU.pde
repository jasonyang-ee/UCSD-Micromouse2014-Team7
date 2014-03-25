



int get_I2C(int address)
{
  int data;
  Wire.beginTransmission(address);
  Wire.requestFrom(address, 1);
  if(Wire.available() )
    data = Wire.receive();
  else
    data = 0x00;
  Wire.endTransmission();
  return data;
}

bool put_I2C(int address, int to_write)
{
  Wire.beginTransmission(address);
  Wire.send(to_write);
  return !(Wire.endTransmission());
}
