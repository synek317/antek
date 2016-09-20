#define PORT_COUNT       4
#define TRAFFIC_LIGHT    1000
#define PEDESTRIAN_LIGHT 975
#define TRAIN_LIGHT      950
#define BARRIER          920
#define SENSOR           880

static int port = 0;
static int* device_ports[PORT_COUNT];

inline bool around(int id, int value)
{
  return id >= value -10 && id <= value + 10;
}

void plug(int port, int* device_port)
{
  if(device_ports[port] == device_port) { return; }

  unplug(port);
  *device_port = port;
  device_ports[port] = device_port;

  if(device_port == BARRIER)
  {
    barrier_init();
  }
}

void unplug(int port)
{
  int* device_port = device_ports[port];

  if(device_port != NULL && *device_port != 255)
  {
    if(device_port == &BARRIER_PORT)
    {
      barrier_cleanup();
    }

    *device_port = 255;
  }
}

void update_detector()
{
  port = (port + 1) % PORT_COUNT

  int id = analogRead(port);

  if(is_device(id, TRAFFIC_LIGHT))
  {
    if(TRAFFIC_LIGHT1_PORT == 255)         { plug(port, &TRAFFIC_LIGHT1_PORT); }
    else                                   { plug(port, &TRAFFIC_LIGHT2_PORT); }
  }
  else if(is_device(id, PEDESTRIAN_LIGHT)) { plug(port, &PEDESTRIAN_LIGHT_PORT); }
  else if(is_device(id, TRAIN_LIGHT))      { plug(port, &TRAIN_LIGHT_PORT); }
  else if(is_device(id, BARRIER))          { plug(port, &BARRIER_PORT); }
  else if(is_device(id, SENSOR))           { plug(port, &SENSORPORT); }
  else if(id == 1023)                      { unplug(port); }
}