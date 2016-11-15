package engine;

    class ObjectsMap
{
    private static var map : CellMap;

    public static function init()
    {
        map = new CellMap(LevelMap.widthInTiles * Consts.CellsPerHTile, LevelMap.heightInTiles * Consts.CellsPerVTile);
    }

    #if (debug)
    public static function updateDebug()
    {
        if(FlxG.keys.justPressed.A) map.debugLayer.visible = !map.debugLayer.visible;   
    }
    #end
    
    public inline static function place(obj: IObject)
    {
        return placeXYCells(
            obj.position.cellX,
            obj.position.cellY,
            obj.position.cellX + obj.size.widthInCells,
            obj.position.cellY + obj.size.heightInCells,
            obj.objectType
        );
    }

    public static inline function placeXYTiles(leftTile: Int, topTile: Int, rightTile: Int, botTile: Int, objType: Int)
    {
        return placeXYCells(
            leftTile  * Consts.CellsPerHTile,
            topTile   * Consts.CellsPerVTile,
            rightTile * Consts.CellsPerHTile,
            botTile   * Consts.CellsPerVTile,
            objType
        );
    }

    public static function placeXYCells(leftCell: Int, topCell: Int, rightCell: Int, botCell: Int, objType: Int)
    {
        var x: Int;
        var y: Int = topCell;

        while(y < botCell)
        {
            x = leftCell;
            while(x < rightCell)
            {
                map.setAt(x, y, objType);
                ++x;
            }
            ++y;
        }
    }

    public inline static function canPlace(obj: IObject)
    {
        return canPlaceXYCells(
            obj.position.cellX,
            obj.position.cellY,
            obj.position.cellX + obj.size.widthInCells,
            obj.position.cellY + obj.size.heightInCells
        );
    }

    public static inline function canPlaceXYTiles(leftTile: Int, topTile: Int, rightTile: Int, botTile: Int)
    {
        return canPlaceXYCells(
            leftTile  * Consts.CellsPerHTile,
            topTile   * Consts.CellsPerVTile,
            rightTile * Consts.CellsPerHTile,
            botTile   * Consts.CellsPerVTile
        );
    }

    public static function canPlaceXYCells(leftCell: Int, topCell: Int, rightCell: Int, botCell: Int)
    {
        var x: Int;
        var y: Int = topCell;

        while(y < botCell)
        {
            x = leftCell;
            while(x < rightCell)
            {
                if (map.at(x, y) != 0) return false;
                ++x;
            }
            ++y;
        }

        return true;
    }
}