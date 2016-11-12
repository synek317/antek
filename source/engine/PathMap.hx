package engine;

class PathMap
{
    private static var map : CellMap;
    private static var debugLayer: FlxSprite;

    public static var width(get, never)  : Int;
    public static var height(get, never) : Int;

    public static function init()
    {
        map = new CellMap(LevelMap.widthInTiles * Consts.CellsPerHTile, LevelMap.heightInTiles * Consts.CellsPerVTile);
     
        #if (debug)
        initDebug();
        #end

        for(y in 0...LevelMap.heightInTiles)
        {
            for(x in 0...LevelMap.widthInTiles)
            {
                switch(LevelMap.at(x, y))
                {
                    case 1 | 2 | 3 | 4 | 5:
                        setGround(x, y);
                }
            }
        }
    }
    
    public static function update()
    {
        #if (debug)
            if(FlxG.keys.justPressed.D) debugLayer.visible = !debugLayer.visible;
        #end
    }

    public static inline function at(x: Int, y: Int)              return map.at(x, y);
    
    #if (debug)
    public static function setAt(x: Int, y: Int, val: Int)        return debugSetAt(x, y, val);
    #else
    public static inline function setAt(x: Int, y: Int, val: Int) return map.setAt(x, y, val);
    #end

    private static function setGround(x: Int, y: Int)
    {
        for (xx in x*Consts.CellsPerHTile...(x+1)*Consts.CellsPerHTile)
        {
            setAt(xx, y*Consts.CellsPerVTile, 1);
        }
    }

    private static inline function get_width()  return map.width;
    private static inline function get_height() return map.height;

    #if (debug)
    private static function initDebug()
    {
        debugLayer = new FlxSprite();

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

    private static function debugSetAt(x: Int, y: Int, val: Int)
    {
        map.setAt(x, y, val);

        debugDrawCell(x, y);

        return map.at(x, y);
    }

    private static function debugDrawCell(x: Int, y: Int)
    {
        var cellWidth  = LevelMap.TileWidth  / Consts.CellsPerHTile;
        var cellHeight = LevelMap.TileHeight / Consts.CellsPerVTile;

        switch(at(x, y))
        {
            case 0 | null:
                debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,     y * cellHeight,     cellWidth, 1),          0x55ffffff);
                debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,     (y+1) * cellHeight, cellWidth, 1),          0x55ffffff);
                debugLayer.pixels.fillRect(new Rectangle(x * cellWidth,     y * cellHeight,     1,         cellHeight), 0x55ffffff);
                debugLayer.pixels.fillRect(new Rectangle((x+1) * cellWidth, y * cellHeight,     1,         cellHeight), 0x55ffffff);
                debugLayer.pixels.fillRect(new Rectangle((x+1) * cellWidth+1, y * cellHeight+1,     cellWidth-2,         cellHeight-2), 0x00000000);
            default:
                debugLayer.pixels.fillRect(new Rectangle(x * cellWidth, y * cellHeight, cellWidth, cellHeight), 0xddffffff);
        }
    }
    #end
}