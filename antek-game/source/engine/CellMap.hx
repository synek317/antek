package engine;

class CellMap
{
    private var fields: Vector2D<Int>;
 
    #if (debug)
    public var debugLayer: FlxSprite;
    #end

    public var width(default, null)  : Int;
    public var height(default, null) : Int;
    
    public function new(w: Int, h: Int)
    {
        width  = w;
        height = h;
        fields = new Vector2D<Int>(width, height);
        clear();
        
        #if (debug)
        initDebug();
        #end
    }

    public inline function at(x: Int, y: Int)              return fields.at(x, y);
    #if (debug)
    public function setAt(x: Int, y: Int, val: Int)        return debugSetAt(x, y, val);
    #else
    public inline function setAt(x: Int, y: Int, val: Int) return fields.setAt(x, y, val);
    #end

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
    
    #if (debug)
    public function initDebug()
    {
        debugLayer = new FlxSprite();
        debugLayer.visible = false;

        debugLayer.pixels = new BitmapData(int(width * Consts.CellWidth), int(height * Consts.CellHeight));
        debugLayer.cameras = [FlxG.camera];
        for(y in 0...height)
        {
            for(x in 0...width)
            {
                debugDrawCell(x, y);
            }
        }

        PlayState.addChildZ(debugLayer, 999999);
    }

    private function debugSetAt(x: Int, y: Int, val: Int)
    {
        fields.setAt(x, y, val);

        debugDrawCell(x, y);

        return fields.at(x, y);
    }

    private function debugDrawCell(x: Int, y: Int)
    {
        var cellWidth  = Consts.TileWidth  / Consts.CellsPerHTile;
        var cellHeight = Consts.TileHeight / Consts.CellsPerVTile;
        var val = at(x, y);
        
        if (val == 0 || val == Consts.DefaultInt)
        {
            debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,           y * cellHeight,       cellWidth,           1),              0x55ffffff);
            debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,           (y+1) * cellHeight,   cellWidth,           1),              0x55ffffff);
            debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,           y * cellHeight,       1,                   cellHeight),     0x55ffffff);
            debugLayer.pixels.fillRect(new Rectangle((x+1) * cellWidth,       y * cellHeight,       1,                   cellHeight),     0x55ffffff);
            debugLayer.pixels.fillRect(new Rectangle((x + 1) * cellWidth + 1, y * cellHeight + 1,    cellWidth - 2,      cellHeight - 2), 0x00000000);
        }
        else
        {
            debugLayer.pixels.fillRect(new Rectangle(x * cellWidth, y * cellHeight, cellWidth, cellHeight), 0xddffffff);
        }
    }
    #end
}