package types;

class Size
{
    public var width                   : Int;
    public var height                  : Int;
    public var widthInTiles(get, set)  : Int;
    public var heightInTiles(get, set) : Int;
    public var widthInCells(get, set)  : Int;
    public var heightInCells(get, set) : Int;

    public function new(width: Int, height: Int)
    {
        this.width  = width;
        this.height = height;
    }

    public static function fromSize(width: Int, height: Int) return new Size(width, height);
    public static function fromTile(width: Int, height: Int) return new Size(width * Consts.TileWidth, height * Consts.TileHeight);
    public static function fromCell(width: Int, height: Int) return new Size(width * Consts.CellWidth, height * Consts.CellHeight);
    
    public function get_widthInTiles()     return width.to_htile();
    public function get_heightInTiles()    return height.to_vtile();
    public function get_widthInCells()     return width.to_hcell();
    public function get_heightInCells()    return height.to_vcell();
    public function set_widthInTiles(val)  return this.width  = val * Consts.TileWidth;
    public function set_heightInTiles(val) return this.height = val * Consts.TileHeight;
    public function set_widthInCells(val)  return this.width  = val * Consts.CellWidth;
    public function set_heightInCells(val) return this.height = val * Consts.CellHeight;

    public function clone()
    {
        return new Size(width, height);
    }

    public function cloneTo(dest: Size)
    {
        dest.width  = width;
        dest.height = height;
    }
}