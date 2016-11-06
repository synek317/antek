package engine;

class Engine
{
    public static function init(tiledLevel: String)
    {
        LevelMap.init(tiledLevel);
        Camera.init();
        Zoom.init();
        PathMap.init();
        Fog.init();
    }

    public static function update()
    {
        Zoom.update();
        Camera.update();
        Mouse.update();
    }
}