int TRAIN_LIGHT_PORT = 255;

void train_light_none()
{
  if(TRAIN_LIGHT_PORT == 255) { return; }
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 2, LOW);
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 3, LOW);
}

void train_light_left()
{
  if(TRAIN_LIGHT_PORT == 255) { return; }
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 2, HIGH);
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 3, LOW);
}

void train_light_right()
{
  if(TRAIN_LIGHT_PORT == 255) { return; }
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 2, LOW);
  digitalWrite(TRAIN_LIGHT_PORT * 3 + 3, HIGH);
}

void train_light_update(int cycle)
{
  if(cycle % 2)
  {
    train_light_left();
  }
  else
  {
    train_light_right();
  }
}