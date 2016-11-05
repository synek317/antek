package;

class PathMap
{
    private static inline var CellsPerHTile = 4;
    private static inline var CellsPerVTile = 4;
    
    private static var fields: Vector2D<Int>;
    
    public static function init()
    {
        fields = new Vector2D<Int>(LevelMap.widthInTiles * CellsPerHTile, LevelMap.heightInTiles * CellsPerVTile)
    }
}