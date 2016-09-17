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

class CameraController extends FlxSprite
{
    private var zoomFactor : Float = 1;

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if(FlxG.keys.justPressed.PAGEUP)
        {
            zoomFactor += 0.1;
            updateScale();
        }
        else if(FlxG.keys.justPressed.PAGEDOWN)
        {
            zoomFactor -= 0.1;
            updateScale();
        }
        else if(FlxG.keys.justPressed.ZERO)
        {
            zoomFactor = 1;
            updateScale();
        }
    }

    private function updateScale(): Void
    {
        var c        = FlxG.camera;
        var currentX = c.x;
        var currentY = c.y;
        var newCameraWidth  = FlxG.width / zoomFactor;
        var newCameraHeight = FlxG.height / zoomFactor;
        var diffWidth  = FlxG.width  - newCameraWidth;
        var diffHeight = FlxG.height - newCameraHeight;

        FlxG.camera.setSize(Std.int(newCameraWidth), Std.int(newCameraHeight));
        FlxG.camera.setScale(zoomFactor, zoomFactor);
        FlxG.camera.setPosition(
            (1-zoomFactor) * FlxG.width,
            (1-zoomFactor) * FlxG.height
        );
    }

    private function setCenter(x: Float, y: Float): Void
    {
    }
}