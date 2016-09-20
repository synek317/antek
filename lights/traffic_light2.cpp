int TRAFFIC_LIGHT2_PORT = 255;

void traffic_light2_red()
{
  if(TRAFFIC_LIGHT2_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 2, HIGH);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 3, LOW);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 4, LOW);
}

void traffic_light2_redyellow()
{
  if(TRAFFIC_LIGHT2_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 2, HIGH);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 3, HIGH);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 4, LOW);
}

void traffic_light2_green()
{
  if(TRAFFIC_LIGHT2_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 2, LOW);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 3, LOW);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 4, HIGH);
}

void traffic_light2_yellow()
{
  if(TRAFFIC_LIGHT2_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 2, LOW);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 3, HIGH);
  digitalWrite(TRAFFIC_LIGHT2_PORT * 3 + 4, LOW);
}

void traffic_light2_update(int cycle)
{
  if(cycle < 24)
  {
    traffic_light2_green();
  }
  else if(cycle < 28)
  {
    traffic_light2_yellow();
  }
  else if(cycle < 32)
  {
    traffic_light2_red();
  }
  else
  {
    traffic_light2_redyellow();
  }
}