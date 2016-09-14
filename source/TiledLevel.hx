package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledImageLayer;
import flixel.addons.editors.tiled.TiledImageTile;
import flixel.addons.editors.tiled.TiledLayer.TiledLayerType;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import haxe.io.Path;

class TiledLevel extends TiledMap
{
	private var foregroundTiles:FlxGroup;
	
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		
		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullHeight, true);
		
		for (layer in layers)
		{
            if (layer.type == TiledLayerType.TILE)
            {
                addLayer(cast(layer, TiledTileLayer));
            }
        }
	}
    
    public function addTo(state: FlxState) : Void
    {
        state.add(foregroundTiles);    
    }
    
    private function addLayer(tileLayer: TiledTileLayer) : Void
    {
        var tilemap = createTilemap(tileLayer);
        
        this.foregroundTiles.add(tilemap);
    }
    
    private function createTilemap(tileLayer: TiledTileLayer) : FlxTilemap
    {
        var tileSet          = findTileSet(tileLayer);
        var tileSetImageFile = getTileSetImageFile(tileSet);
        var tilemap          = new FlxTilemap();
        
		tilemap.loadMapFromArray(
            tileLayer.tileArray, //map data
            width,               //width in tiles
            height,              //height in tiles
            tileSetImageFile,    //tile graphics
            tileSet.tileWidth,   //tile width
            tileSet.tileHeight,  //tile height
            OFF,                 //auto tile
            tileSet.firstGID,    //starting index
            1,                   //draw index
            1                    //collide index
        );
        
        return tilemap;
    }
    
    private function getTileSetImageFile(tileSet: TiledTileSet) : String
    {
        var path = new Path(tileSet.imageSource);
        
        return "assets/images/" + path.file + "." + path.ext;
    }
    
    private function findTileSet(tileLayer: TiledTileLayer) : TiledTileSet
    {
        var tileSheetName:String = tileLayer.properties.get("tileset");
        
        if (tileSheetName == null)
        {
            throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
        }
        
        for (ts in tilesets)
        {
            if (ts.name == tileSheetName)
            {
                return ts;
            }
        }
        
        throw "Tileset '" + tileSheetName + " not found. Did you misspell the 'tilesheet' property in " + tileLayer.name + "' layer?";
    }
}