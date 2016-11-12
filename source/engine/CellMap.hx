package engine;

class CellMap
{
    
    public var width(default, null)  : Int;
    public var height(default, null) : Int;
    
    private var fields: Vector2D<Int>;

    public function new(w: Int, h: Int)
    {
        width  = w;
        height = h;
        fields = new Vector2D<Int>(width, height);
        clear();
    }

    public inline function at(x: Int, y: Int)              return fields.at(x, y);
    public inline function setAt(x: Int, y: Int, val: Int) return fields.setAt(x, y, val);

    public function clear()
    {
        for(y in 0...height)
        {
            for(x in 0...width)
            {
                fields.setAt(x, y, 0);
            }
        }
    }
}