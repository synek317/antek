package engine;

class Objects
{
    private static var objects       = new List<IUpdateable>();
    private static var staticObjects = new List<ASprite>();

    public static function register(o: IUpdateable)     { objects.add(o); }
    public static function unregister(o: IUpdateable)   { objects.remove(o); }
    public static function registerStatic(o: ASprite)   { staticObjects.add(o); }
    public static function unregisterStatic(o: ASprite) { staticObjects.remove(o); }

    public static function update(elapsed: Float)       { for(o in objects) o.update(elapsed); }
}