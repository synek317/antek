package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
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

class PlayState extends FlxState
{
    override public function create():Void
    {
        super.create();
        
        var tex = FlxAtlasFrames.fromLibGdx("assets/images/anteks.png", "assets/data/atlases/anteks.pack");
        
        var x = new FlxSprite(400, 72);
        
        x.frames = tex;
        x.animation.addByPrefix("walk", "c01/idle/", 18);
        x.animation.play("walk");
        
        var map = new TiledLevel("assets/data/levels/0.tmx");
        
        map.addTo(this);
        add(x);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}
