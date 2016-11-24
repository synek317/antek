class Consts
{
    public static        var DefaultInt     : Int; //God, why? :( BECAUSE INT IS NULL ON DYNAMIC PLATFORMS AND 0 ON STATIC ONES
    
    public static inline var Ladder         : Int = 1;
    public static inline var Bridge         : Int = 1;
    
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

    public static var Deco = [
        { name: "bird",         creator: DecoBird.create  , z: ZOrder.DecoFarBack, frameRate: 4, animChance: 0.0005, speed: 80 },
        { name: "bush1",        creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "bush2",        creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "bush_rabbit",  creator: DecoAnim.create  , z: ZOrder.DecoBack,    frameRate: 6, animChance: 0.0005, speed: 0  },
        { name: "bush_flowers", creator: DecoStatic.create, z: ZOrder.DecoFront,   frameRate: 0, animChance: 0,      speed: 0  },
        { name: "shroom",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "rabbit",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "rocks1",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "rocks2",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "rocks3",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  },
        { name: "rocks4",       creator: DecoStatic.create, z: ZOrder.DecoBack,    frameRate: 0, animChance: 0,      speed: 0  }
    ];
    
    public static function EmptyFunFloatVoid(_: Float) {}
    public static function EmptyFunIntVoid(_: Int)     {}
}