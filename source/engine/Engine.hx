package engine;

class Engine
{
    public static function init(tiledLevel: String)
    {
        var tiledMap = new TiledMap(tiledLevel);

        LevelMap.init(tiledMap);
        Camera.init();
        Zoom.init();
        PathMap.init();
        ObjectsMap.init();
        Decorations.init(tiledMap);
        Fog.init();
    }

    public static function update()
    {
        Zoom.update();
        Camera.update();
        Mouse.update();
        PathMap.update();
    }
}