package;

class Textures
{
    private static var _objects:           FlxAtlasFrames;
    private static var _anteks:            FlxAtlasFrames;
    private static var _enemies:           FlxAtlasFrames;

    public static var objects(get, never): FlxAtlasFrames;
    public static var anteks(get, never):  FlxAtlasFrames;
    public static var enemies(get, never): FlxAtlasFrames;
    
    private static function get_objects()
    {
        if (_objects == null) _objects = Load("objects");
        return _objects;
    }
    
    private static function get_anteks()
    {
        if (_anteks== null) _anteks = Load("anteks");
        return _anteks;
    }
    
    private static function get_enemies()
    {
        if (_enemies == null) _enemies = Load("enemies");
        return _enemies;
    }
    
    private static function Load(name: String): FlxAtlasFrames
    {
        return FlxAtlasFrames.fromLibGdx("assets/images/" + name + ".png", "assets/data/atlases/" + name + ".pack");
    }
}