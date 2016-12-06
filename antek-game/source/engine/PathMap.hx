package engine;

class PathMap
{
    private static var map : CellMap;

    public static var width(get, never)  : Int;
    public static var height(get, never) : Int;

    public static function init()
    {
        map = new CellMap(LevelMap.widthInTiles * Consts.CellsPerHTile, LevelMap.heightInTiles * Consts.CellsPerVTile);
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
    
    #if (debug)
    public static function updateDebug()
    {
        if(FlxG.keys.justPressed.D) map.debugLayer.visible = !map.debugLayer.visible;   
    }
    #end

    public static inline function at(x: Int, y: Int)              return map.at(x, y);
    public static inline function setAt(x: Int, y: Int, val: Int) return map.setAt(x, y, val);

    private static function setGround(x: Int, y: Int)
    {
        for (xx in x*Consts.CellsPerHTile...(x+1)*Consts.CellsPerHTile)
        {
            setAt(xx, y*Consts.CellsPerVTile, 1);
        }
    }

    private static inline function get_width()  return map.width;
    private static inline function get_height() return map.height;
}