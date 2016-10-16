package framework;

class Framework
{
    public static function init()
    {
        Camera.init();
        Zoom.init();
    }

    public static function update()
    {
        Zoom.update();
        Camera.update();
        Mouse.update();
    }
}