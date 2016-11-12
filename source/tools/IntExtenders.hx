package tools;

class IntExtenders
{
    public static inline function htiles(x: Int)           return x * LevelMap.TileWidth;
    public static inline function htile(x: Int)            return x * LevelMap.TileWidth;
    public static inline function vtiles(y: Int)           return y * LevelMap.TileHeight;
    public static inline function vtile(y: Int)            return y * LevelMap.TileHeight;
    
    public static inline function hcells(x: Int)           return x * Consts.CellWidth;
    public static inline function hcell(x: Int)            return x * Consts.CellWidth;
    public static inline function vcells(y: Int)           return y * Consts.CellHeight;
    public static inline function vcell(y: Int)            return y * Consts.CellHeight;
    
    public static inline function abs(x: Int)              return x >= 0 ? x : -x;
}