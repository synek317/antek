package engine;

interface IObject
{
    var position: Position;
    var size: Size;
    var objectType(get, never);
}

class ObjectsMap
{
    private static var map : CellMap;

    public static var width(get, never)  : Int;
    public static var height(get, never) : Int;

    public static function init()
    {
        map = new CellMap(LevelMap.widthInTiles * Consts.CellsPerHTile, LevelMap.heightInTiles * Consts.CellsPerVTile);
    }

    public static function place(obj: IObject)
    {
        for(y in obj.position.cellY...(obj.position.cellY + obj.size.heightInCells))
        {
            for(x in obj.position.cellX...(obj.position.cellX + obj.size.widthInCells))
            {
                map.setAt(x, y, obj.objectType);
            }
        }
    }

    public static function canPlace(obj: IObject)
    {
        for(y in obj.position.cellY...(obj.position.cellY + obj.size.heightInCells))
        {
            for(x in obj.position.cellX...(obj.position.cellX + obj.size.widthInCells))
            {
                if (map.at(x, y) != 0) return false;
            }
        }

        return true;
    }
}