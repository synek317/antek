package engine;

class PathMap
{
    public static inline var CellsPerHTile = 4;
    public static inline var CellsPerVTile = 4;
    public static inline var CellWidth     = Std.int(LevelMap.TileWidth / CellsPerHTile);
    public static inline var CellHeight    = Std.int(LevelMap.TileHeight / CellsPerVTile);
    
    public static var width(default, null)  : Int;
    public static var height(default, null) : Int;
    
    private static var fields: Vector2D<Int>;
    
    public static function init()
    {
        width  = LevelMap.widthInTiles * CellsPerHTile;
        height = LevelMap.heightInTiles * CellsPerVTile;
        fields = new Vector2D<Int>(width, height);
     
        for(y in 0...LevelMap.heightInTiles)
        {
            for(x in 0...LevelMap.widthInTiles)
            {
                switch(LevelMap.at(x, y))
                {
                    case 1 | 2 | 3 | 4 | 5:
                        ground(x, y);
                }
            }
        }
    }
    
    public static inline function at(x: Int, y: Int)              return fields.at(x, y);
    public static inline function setAt(x: Int, y: Int, val: Int) return fields.setAt(x, y, val);
    
    private static function ground(x: Int, y: Int)
    {
        for (xx in x*CellsPerHTile...(x+1)*CellsPerHTile)
        {
            fields.setAt(xx, y*CellsPerVTile, 1);
        }
    }
}