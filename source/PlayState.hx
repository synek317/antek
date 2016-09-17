package;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
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
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.display.FlxZoomCamera;
import flixel.math.FlxRect;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{
    private var scale : Float = 1;
    private var levelLayer : LevelLayer;

    override public function create():Void
    {
        var tex = FlxAtlasFrames.fromLibGdx("assets/images/anteks.png", "assets/data/atlases/anteks.pack");

        var x = new FlxSprite(400, 72);

        x.frames = tex;
        x.animation.addByPrefix("walk", "c01/idle/", 18);
        x.animation.play("walk");

        var levelLayer = Level.loadFrom("assets/data/levels/0.tmx");

        add(levelLayer);
        add(x);
        add(new CameraController());

        FlxG.camera.bgColor = 0x99FFFFFF;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

    }
}