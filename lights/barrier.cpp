int BARRIER_PORT = 255;
static bool is_open     = true;
static Servo servo;

void barrier_close()
{
  if(BARRIER_PORT == 255) { return; }
  if(is_open)
  {
    servo.write(0);
    is_open = false;
  }
}

void barrier_open()
{
  if(BARRIER_PORT == 255) { return; }
  if(!is_open)
  {
    servo.write(90);
    is_open = true;
  }
}

void barrier_init(int port)
{
  servo.attach(port * 3 + 3)
}

void barrier_cleanup()
{
  servo.dettach();
}

void barrier_update(int cycle)
{
  if(cycle < 6)
  {
    barrier_open();
  }
  else if(cycle < 18)
  {
    barrier_close();
  }
  else
  {
    barrier_open();
  }
}