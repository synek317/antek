package engine;

class Objects
{
    private static var objects = new List<IUpdateable>();

    public static function register(o: IUpdateable)
    {
        objects.add(o);
    }

    public static function unregister(o: IUpdateable)
    {
        objects.remove(o);
    }

    public static function update(elapsed: Float)
    {
        for(o in objects) o.update(elapsed);
    }
}