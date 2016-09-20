int PEDESTRIAN_LIGHT_PORT = 255;

void pedestrian_light_red()
{
  if(PEDESTRIAN_LIGHT_PORT == 255) { return; }
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 2, HIGH);
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 3, LOW);
}

void pedestrian_light_green()
{
  if(PEDESTRIAN_LIGHT_PORT == 255) { return; }
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 2, LOW);
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 3, HIGH);
}

void pedestrian_light_none()
{
  if(PEDESTRIAN_LIGHT_PORT == 255) { return; }
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 2, LOW);
  digitalWrite(PEDESTRIAN_LIGHT_PORT * 3 + 3, LOW);
}

void pedestrian_light_update(int cycle)
{
  if(cycle < 12)
  {
    pedestrian_light_red();
  }
  else if(cycle < 20)
  {
    pedestrian_light_green();
  }
  else if(cycle < 24)
  {
    if(cycle % 2 == 0)
    {
      pedestrian_light_none();
    }
    else
    {
      pedestrian_light_green();
    }
  }
  else
  {
    pedestrian_light_red();
  }
}