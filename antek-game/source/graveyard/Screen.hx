/*package engine;

class Screen
{
    private var _windowSize  = new FlxPoint();
    private var _visibleSize = new FlxPoint();

    public var windowWidth(get, never):  Int;
    public var windowHeight(get, never): Int;
    public var windowSize(get, never):   FlxPoint;

    public var visibleWidth(get, set):   Float;
    public var visibleHeight(get, set):  Float;
    public var visibleSize(get, set):    FlxPoint;

    public var zoom(get, set):           Float;

    public function init()
    {
        _windowSize.x = FlxG.width;
        _windowSize.y = FlxG.height;
    }

    private function get_windowWidth()    return _windowSize.x;
    private function get_windowHeight()   return _windowSize.y;
    private function get_windowSize()     return _windowSize;

    private function get_visibleWidth()   return _visibleSize.x;
    private function get_visibleHeight()  return _visibleSize.y;
    private function get_visibleSize()    return _visibleSize;

    private function set_visibleWidth(w)  return updateVisibleSize(w, _visibleSize.y);
    private function set_visibleHeight(h) return updateVisibleSize(_visibleSize.x, h);
    private function set_visibleSize(p)   return updateVisibleSize(p.x, p.y);
    
    private inline function updateVisibleSize(w: Float, h: Float)
    {
        _visibleSize.x = w;
        _visibleSize.y = h;
        return _visibleSize;
    }

    function set_zoom(newZoom: Float)
    {
        zoom = newZoom;
        visibleWidth = screenWidth / zoom;
        visibleHeight = screenHeight / zoom;
    }
}*/