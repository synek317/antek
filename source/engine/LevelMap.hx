package engine;

class LevelMap
{
	private static var obj: FlxTilemap;

    public static var widthInPixels(get, never): Float;
    public static var heightInPixels(get, never): Float;
    public static var widthInTiles(get, never): Int;
    public static var heightInTiles(get, never): Int;
	
	public static function init(tiledMap: TiledMap)
	{
		obj = new FlxTilemap();
        
		for (layer in tiledMap.layers)
		{
            if (layer.type == TiledLayerType.TILE)
            {
                createLayer(cast(layer, TiledTileLayer));
            }
        }
		
		obj.cameras = [FlxG.camera];
        PlayState.addChild(obj);
	}
    
    public static inline function updateBuffers()    return obj.updateBuffers();
    public static inline function at(x: Int, y: Int) return obj.getTile(x, y);

    public static inline function isGroundAt(x: Int, y: Int)
    {
        switch(at(x, y))
        {
            case 1 | 2 | 3 | 4 | 5: return true;
            default:                return false;
        }
    }

    private static function createLayer(layer: TiledTileLayer): Void
    {
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
    
    private static inline function get_widthInPixels()  return obj.width;
    private static inline function get_heightInPixels() return obj.height;
    private static inline function get_widthInTiles()   return obj.widthInTiles;
    private static inline function get_heightInTiles()  return obj.heightInTiles;
}