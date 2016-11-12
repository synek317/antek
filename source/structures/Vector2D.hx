package structures;

class Vector2D<T>
{
    private var elements: Vector<T>;
    private var width:    Int;
    private var height:   Int;
    
    public function new(width: Int, height: Int)
    {
        this.width    = width;
        this.height   = height;
        this.elements = new Vector<T>(width * height);
    }
    
    public inline function at(x: Int, y: Int): T
    {
        return elements[y * width + x];
    }
    
    public inline function setAt(x: Int, y: Int, val: T)
    {
        elements[y * width + x] = val;
    }
}