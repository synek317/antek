int SENSOR_PORT = 255;
i
bool sensor_is_train_detected()
{
  if(SENSOR_PORT == 255) { return false; }

  return digitalRead(SENSOR_PORT * 3 + 2);
}