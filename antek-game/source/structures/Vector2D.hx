package structures;
import haxe.ds.Vector;

class Vector2D<T>
{
    #if flash
    private var elements: Array<T>;
    #else
    private var elements: Vector<T>;
    #end
    private var width:    Int;
    private var height:   Int;
    
    public function new(width: Int, height: Int)
    {
        this.width    = width;
        this.height   = height;
        #if flash
        this.elements = new Array<T>();
        #else
        this.elements = new Vector<T>(width * height);
        #end
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