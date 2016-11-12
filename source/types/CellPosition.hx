package types;

class Position
{
    public var x: Float = 0;
    public var y: Float = 0;
    public var t      = new TilePosition(0, 0);
    public var m      = new MapPosition(0, 0);

    public function new(x: Int, y: Int)
    {
        this.x = x;
        this.y = y;
    }

    public function clone()
    {
        return new CellPosition(x, y);
    }

    public function cloneTo(dest: CellPosition)
    {
        dest.x = x;
        dest.y = y;
    }

    public function toTile()
    {

    }

    public function cloneTile()
    {

    }

    public function cloneToTile(dest: TilePosition)
    {

    }
}