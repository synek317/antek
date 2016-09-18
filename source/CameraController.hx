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
	private var minZoomFactor : Float;
	private var maxZoomFactor : Float = 2;
	
	public function new()
	{
		super();
		
		var minXZoomFactory = FlxG.width  / PlayState.levelMap.width;
		var minYZoomFactory = FlxG.height / PlayState.levelMap.height;
		
		minZoomFactor = Math.max(minXZoomFactory, minYZoomFactory);
	}
	
    override public function update(elapsed:Float):Void
    {
		this.visible = false;
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
		zoomFactor = FlxMath.bound(zoomFactor, minZoomFactor, maxZoomFactor);
			
        var newCameraWidth  = FlxG.width / zoomFactor;
        var newCameraHeight = FlxG.height / zoomFactor;
        var diffWidth      = FlxG.width  - newCameraWidth;
        var diffHeight     = FlxG.height - newCameraHeight;
		
		if (zoomFactor <= 1)
		{
			FlxG.camera.setSize(Std.int(newCameraWidth), Std.int(newCameraHeight));
			FlxG.camera.setScale(zoomFactor, zoomFactor);
            FlxG.camera.setPosition(
               diffWidth/2, diffHeight/2
            );
		}
		else
		{
			FlxG.camera.setSize(FlxG.width, FlxG.height);
			FlxG.camera.setScale(zoomFactor, zoomFactor);
		}
		
		FlxG.camera.focusOn(new FlxPoint(400, 300));
		PlayState.levelMap.updateBuffers();
    }
}