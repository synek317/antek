class Consts
{
    public static inline var Ladder         : Int = 1;
    
    public static inline var TileHeight     : Int = 40;
    public static inline var TileWidth      : Int = 40;
    public static inline var HalfTileHeight : Int = Std.int(TileHeight / 2);
    public static inline var HalfTileWidth  : Int = Std.int(TileWidth  / 2);

    public static inline var CellsPerHTile  : Int = 4;
    public static inline var CellsPerVTile  : Int = 4;
    public static inline var CellWidth      : Int = Std.int(Consts.TileWidth / CellsPerHTile);
    public static inline var CellHeight     : Int = Std.int(Consts.TileHeight / CellsPerVTile);
    public static inline var HalfCellWidth  : Int = Std.int(CellWidth / 2);
    public static inline var HalfCellHeight : Int = Std.int(CellHeight / 2);

    public static inline var DecoBird        : Int = 0;
    public static inline var DecoBush1       : Int = 1;
    public static inline var DecoBush2       : Int = 2;
    public static inline var DecoBushRabbit  : Int = 3;
    public static inline var DecoBushFlowers : Int = 4;
    public static inline var DecoShroom      : Int = 5;
    public static inline var DecoRabbit      : Int = 6;
    public static inline var DecoRock1       : Int = 7;
    public static inline var DecoRock2       : Int = 8;
    public static inline var DecoRock3       : Int = 9;
    public static inline var DecoRock4       : Int = 10;
    
    public static function EmptyFunFloatVoid(_: Float) {}    
    public static function EmptyFunIntVoid(_: Int)     {}    
}