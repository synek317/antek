package antek.assets;

class Textures
{
    private static var _objects:               FlxAtlasFrames;
    private static var _characters:            FlxAtlasFrames;
    private static var _enemies:               FlxAtlasFrames;
    private static var _others:                FlxAtlasFrames;
    private static var _decorations:           FlxAtlasFrames;

    public static var objects(get, never):     FlxAtlasFrames;
    public static var characters(get, never):  FlxAtlasFrames;
    public static var enemies(get, never):     FlxAtlasFrames;
    public static var others(get, never):      FlxAtlasFrames;
    public static var decorations(get, never): FlxAtlasFrames;
    
    private static function get_objects()
    {
        if (_objects == null) _objects = Load("objects");
        return _objects;
    }
    
    private static function get_characters()
    {
        if (_characters== null) _characters = Load("characters");
        return _characters;
    }
    
    private static function get_enemies()
    {
        if (_enemies == null) _enemies = Load("enemies");
        return _enemies;
    }
    
    private static function get_others()
    {
        if (_enemies == null) _enemies = Load("others");
        return _enemies;
    }

    private static function get_decorations()
    {
        if (_decorations == null) _decorations = Load("decorations");
        return _decorations;
    }
    
    private static function Load(name: String): FlxAtlasFrames
    {
        return FlxAtlasFrames.fromLibGdx("assets/images/" + name + ".png", "assets/data/atlases/" + name + ".pack");
    }
    
    private static var antekGlowFilters = new Map<String, FlxFilterFrames>();
    
    public static function getGlowedAntek(type: String, sprite: FlxSprite)
    {
        var result = antekGlowFilters.get(type);
        
        if (result == null)
        {
            var glowFilter = new GlowFilter(0xffffff, 1, 8, 8, 3.5, 1);
            var filterFrames = FlxFilterFrames.fromFrames(sprite.frames, 0, 0, [glowFilter]);
            
            antekGlowFilters[type] = filterFrames;
            result = filterFrames;
        }
        
        return result;
    }
}