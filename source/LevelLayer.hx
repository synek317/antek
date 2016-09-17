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

class LevelLayer extends FlxTilemap
{
    private var layer: TiledTileLayer;

    public function new(layer: TiledTileLayer): Void
    {
        super();

        this.layer = layer;

        var tileSet          = findTileSet(layer);
        var tileSetImageFile = getTileSetImageFile(tileSet);

        this.loadMapFromArray(
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

    private function getTileSetImageFile(tileSet: TiledTileSet) : String
    {
        var path = new Path(tileSet.imageSource);

        return "assets/images/" + path.file + "." + path.ext;
    }

    private function findTileSet(layer: TiledTileLayer) : TiledTileSet
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