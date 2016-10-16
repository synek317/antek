package;

class LevelMap extends FlxTilemap
{
    public static inline var TileHeight     : Int = 40;
    public static inline var TileWidth      : Int = 40;
    public static inline var HalfTileHeight : Int = 40;
    public static inline var HalfTileWidth  : Int = 20;
    
	public static var obj: LevelMap;
	
    private var layer: TiledTileLayer;
	
	public static function init(tiledLevel:String)
	{
		obj = new LevelMap();

		var tiledMap = new TiledMap(tiledLevel);

		for (layer in tiledMap.layers)
		{
            if (layer.type == TiledLayerType.TILE)
            {
                createLayer(cast(layer, TiledTileLayer));
            }
        }
		
		obj.cameras = [FlxG.camera];
	}

    private static function createLayer(layer: TiledTileLayer): Void
    {
        obj.layer = layer;

        var tileSet          = findTileSet(layer);
        var tileSetImageFile = getTileSetImageFile(tileSet);

        obj.loadMapFromArray(
            layer.tileArray,     //map data
            layer.map.width,     //width in tiles
            layer.map.height,    //height in tiles
            tileSetImageFile,    //tile graphics
            tileSet.tileWidth,   //tile width
            tileSet.tileHeight,  //tile height
            OFF,                 //auto tile
            tileSet.firstGID,    //starting index
            1,                   //draw index
            1                    //collide index
        );
    }

    private static function getTileSetImageFile(tileSet: TiledTileSet) : String
    {
        var path = new Path(tileSet.imageSource);

        return "assets/images/" + path.file + "." + path.ext;
    }

    private static function findTileSet(layer: TiledTileLayer) : TiledTileSet
    {
        var tileSheetName:String = layer.properties.get("tileset");

        if (tileSheetName == null)
        {
            throw "'tileset' property not defined for the '" + layer.name + "' layer. Please add the operty to the layer.";
        }

        for (ts in layer.map.tilesets)
        {
            if (ts.name == tileSheetName)
            {
                return ts;
            }
        }

        throw "Tileset '" + tileSheetName + " not found. Did you misspell the 'tilesheet' property in " + layer.name + "' layer?";
    }
}