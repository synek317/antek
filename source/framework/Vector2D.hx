package framework;

class Vector2D<T>
{
    private var elements: Vector<T>;
    
    public function new(width: Int, height: Int)
    {
        elements = new Vector<T>(width * height);
    }
    
    public inline function at(x: Int, y: Int): T
    {
        return elements[y * height + x];
    }
    
    public inline function setAt(x: Int, y: Int, val: T)
    {
        elements[y * height + x] = val;
    }
}