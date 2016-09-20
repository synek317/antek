#define TIME_INTERVAL 500
#define MAX_CYCLE_COUNT 24

static int cycle = 0; //255 when not running
static long last_update_time = 0;

void update_train()
{
  long now = millis();

  if(cycle == 255)
  {
    if(sensor_is_train_detected())
    {
      last_update_time = now;
      cycle = 0;
    }
  }
  else if(now - last_update_time >= TIME_INTERVAL)
  {
    int cycle_count = (now - last_update_time) / TIME_INTERVAL;

    last_update_time += cycle_count * TIME_INTERVAL;

    cycle += cycle_count;

    if(cycle > MAX_CYCLE_COUNT)
    {
      cycle = 255;
      barrier_open();
      train_light_none();
    }
    else
    {
      barrier_update();
      train_light_update();
    }
  }
}