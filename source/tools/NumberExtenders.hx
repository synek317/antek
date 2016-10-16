package tools;

class NumberExtenders
{
    public static inline function htiles(x: Int)           return x * LevelMap.TileWidth;
    public static inline function htile(x: Int)            return x * LevelMap.TileWidth;
    public static inline function vtiles(y: Int)           return y * LevelMap.TileHeight;
    public static inline function vtile(y: Int)            return y * LevelMap.TileHeight;
    public static inline function to_htile(x: Float)       return Std.int(x / LevelMap.TileWidth);
    public static inline function to_vtile(y: Float)       return Std.int(y / LevelMap.TileHeight);
}