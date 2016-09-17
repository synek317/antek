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

class Level
{
	public static function loadFrom(tiledLevel:String) : LevelLayer
	{
		var tiledMap = new TiledMap(tiledLevel);

		for (layer in tiledMap.layers)
		{
            if (layer.type == TiledLayerType.TILE)
            {
                return new LevelLayer(cast(layer, TiledTileLayer));
            }
        }

        return null;
	}
}