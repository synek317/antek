package tools;

class FloatExtenders
{
    public static inline function to_htile(x: Float)       return Std.int(x / LevelMap.TileWidth);
    public static inline function to_vtile(y: Float)       return Std.int(y / LevelMap.TileHeight);
    
    public static inline function to_hcell(x: Float)       return Std.int(x / PathMap.CellWidth);
    public static inline function to_vcell(y: Float)       return Std.int(y / PathMap.CellHeight);
    
    public static inline function hcells(x: Float )        return IntExtenders.hcells(Std.int(x));
    public static inline function hcell(x: Float)          return IntExtenders.hcell(Std.int(x));
    public static inline function vcells(y: Float)         return IntExtenders.vcells(Std.int(y));
    public static inline function vcell(y: Float)          return IntExtenders.vcell(Std.int(y));
}