int TRAFFIC_LIGHT1_PORT = 255;

void traffic_light1_red()
{
  if(TRAFFIC_LIGHT1_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 2, HIGH);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 3, LOW);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 4, LOW);
}

void traffic_light1_redyellow()
{
  if(TRAFFIC_LIGHT1_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 2, HIGH);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 3, HIGH);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 4, LOW);
}

void traffic_light1_green()
{
  if(TRAFFIC_LIGHT1_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 2, LOW);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 3, LOW);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 4, HIGH);
}

void traffic_light1_yellow()
{
  if(TRAFFIC_LIGHT1_PORT == 255) { return; }
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 2, LOW);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 3, HIGH);
  digitalWrite(TRAFFIC_LIGHT1_PORT * 3 + 4, LOW);
}

void traffic_light1_update(int cycle)
{
  if(cycle < 24)
  {
    traffic_light1_red();
  }
  else if(cycle < 28)
  {
    traffic_light1_redyellow();
  }
  else if(cycle < 32)
  {
    traffic_light1_green();
  }
  else
  {
    traffic_light1_yellow();
  }
}