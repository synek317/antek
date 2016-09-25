package;
import flixel.*;
import flixel.math.*;
import flixel.tweens.*;

class ZoomController
{
	private static inline var ZOOM_STEP     = 0.3;
	private static inline var ZOOM_DURATION = 0.25; //seconds
	
	public static var cameraShiftX : Float;
	public static var cameraShiftY : Float;
	
    public  static var zoomFactor    : Float = 1;
    private static var minZoomFactor : Float;
    private static var maxZoomFactor : Float;

    private static var destinationZoomFactor: Float;
    private static var zoomTween: FlxTween;

    public static function init()
    {
        var minXZoomFactory = FlxG.width  / LevelMap.obj.width;
        var minYZoomFactory = FlxG.height / LevelMap.obj.height;
        var maxXZoomFactory = 2;
        var maxYZoomFactory = 2;
		
        minZoomFactor = Math.max(minXZoomFactory, minYZoomFactory);
		maxZoomFactor = Math.max(maxXZoomFactory, maxYZoomFactory);
		
		zoomTo(1);
    }

    public static function update():Void
    {
        if(FlxG.keys.justPressed.PAGEUP || FlxG.mouse.wheel > 0)
        {
            zoomTo(zoomFactor + ZOOM_STEP);
        }
        else if(FlxG.keys.justPressed.PAGEDOWN || FlxG.mouse.wheel < 0)
        {
            zoomTo(zoomFactor - ZOOM_STEP);
        }
        else if(FlxG.keys.justPressed.ZERO)
        {
            zoomTo(1);
        }
    }

    public static function zoomTo(newZoomFactor: Float): Void
    {
        if (zoomTween != null && !zoomTween.finished) { return; }
		
        destinationZoomFactor = FlxMath.bound(newZoomFactor, minZoomFactor, maxZoomFactor);

        zoomTween = FlxTween.num(
          zoomFactor,
          destinationZoomFactor,
          ZOOM_DURATION,
          { ease: function (t) { return t; } },
          updateZoom
        );
    }

    private static function updateZoom(newZoomFactor: Float): Void
    {
        zoomFactor = newZoomFactor;

        var newCameraWidth  = FlxG.width / zoomFactor;
        var newCameraHeight = FlxG.height / zoomFactor;

        if (zoomFactor <= 1)
        {
			var diffWidth       = FlxG.width  - newCameraWidth;
			var diffHeight      = FlxG.height - newCameraHeight;
		
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
            FlxG.camera.setPosition(0, 0);
        }
		
		cameraShiftX = -0.5 * (zoomFactor * FlxG.camera.width  - FlxG.camera.width);
		cameraShiftY = -0.5 * (zoomFactor * FlxG.camera.height - FlxG.camera.height);
		
		FreeCameraController.updatePosition(FreeCameraController.obj.x, FreeCameraController.obj.y);
		FlxG.camera.updateFollow();
        LevelMap.obj.updateBuffers();
    }
}