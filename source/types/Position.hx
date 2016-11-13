package types;

class Position
{
    public var x(default, set) : Float;
    public var y(default, set) : Float;
    public var tileX(get, set) : Int;
    public var tileY(get, set) : Int;
    public var cellX(get, set) : Int;
    public var cellY(get, set) : Int;

    public var tileShiftX      : Int = 0;
    public var tileShiftY      : Int = 0;
    public var cellShiftX      : Int = 0;
    public var cellShiftY      : Int = 0;
    public var onChangeX       : Float -> Void;
    public var onChangeY       : Float -> Void;

    public function new(x: Float, y: Float, ?onChangeX: Float -> Void, ?onChangeY: Float -> Void)
    {
        this.onChangeX = if (onChangeX == null) { Consts.EmptyFunFloatVoid; } else { onChangeX; } 
        this.onChangeY = if (onChangeY == null) { Consts.EmptyFunFloatVoid; } else { onChangeY; }
        
        this.x = x;
        this.y = y; 
    }

    public static function fromPosition(x: Float, y: Float) return new Position(x, y);
    public static function fromTile(x: Int, y: Int) return new Position(x * Consts.TileWidth + Consts.HalfTileWidth, y * Consts.TileHeight + Consts.HalfTileHeight);
    public static function fromCell(x: Int, y: Int) return new Position(x * Consts.CellWidth + Consts.HalfCellWidth, y * Consts.CellHeight + Consts.HalfCellHeight);
    
    public function set(other: Position)
    {
        x = other.x;
        y = other.y;
    }

    public function clone()
    {
        return new Position(x, y);
    }

    public function cloneTo(dest: Position)
    {
        dest.x = x;
        dest.y = y;
    }

    private function get_tileX() return x.to_htile();
    private function get_tileY() return y.to_vtile();
    private function get_cellX() return x.to_hcell();
    private function get_cellY() return y.to_vcell();

    private function set_x(val: Float)   { x = val; onChangeX(val); return x; }
    private function set_y(val: Float)   { y = val; onChangeY(val); return y; }
    private function set_tileX(val: Int) { x = val.htile() + tileShiftX; return tileX; }
    private function set_tileY(val: Int) { y = val.vtile() + tileShiftY; return tileY; }
    private function set_cellX(val: Int) { x = val.hcell() + cellShiftX; return cellX; }
    private function set_cellY(val: Int) { y = val.vcell() + cellShiftY; return cellY; }
}