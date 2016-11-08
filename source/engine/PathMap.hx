package engine;

class PathMap
{
    public static inline var CellsPerHTile = 4;
    public static inline var CellsPerVTile = 4;
    public static inline var CellWidth     = Std.int(LevelMap.TileWidth / CellsPerHTile);
    public static inline var CellHeight    = Std.int(LevelMap.TileHeight / CellsPerVTile);
    
    private static var fields: Vector2D<Int>;
    
    public static function init()
    {
        fields = new Vector2D<Int>(LevelMap.widthInTiles * CellsPerHTile, LevelMap.heightInTiles * CellsPerVTile);
        
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
    
    public static inline function at(x: Int, y: Int) return fields.at(x, y);
    
    private static function ground(x: Int, y: Int)
    {
        for (xx in x*CellsPerHTile...(x+1)*CellsPerHTile)
        {
            fields.setAt(xx, y*CellsPerVTile, 1);
        }
    }
}