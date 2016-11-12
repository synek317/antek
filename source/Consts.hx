class Consts
{
    public static inline var CellsPerHTile = 4;
    public static inline var CellsPerVTile = 4;
    public static inline var CellWidth     = Std.int(LevelMap.TileWidth / CellsPerHTile);
    public static inline var CellHeight    = Std.int(LevelMap.TileHeight / CellsPerVTile);
}