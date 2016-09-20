#define TIME_INTERVAL 500
#define MAX_CYCLE_COUNT 36

static int cycle = 0;
static long last_update_time = 0;

void update_traffic()
{
  long now = millis();

  if(now - last_update_time >= TIME_INTERVAL)
  {
    int cycle_count = (now - last_update_time) / TIME_INTERVAL;

    last_update_time += cycle_count * TIME_INTERVAL;

    cycle = (cycle + cycle_count) % MAX_CYCLE_COUNT;

    traffic_light1_update(cycle);
    traffic_light2_update(cycle);
    pedestrian_update(cycle);
  }
}