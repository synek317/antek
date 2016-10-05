package;
import flixel.*;
import flixel.math.*;

class FreeCameraController
{
	public static var obj : FlxSprite;
	
	private static var moving : Bool = false;
	private static var lastX: Float;
	private static var lastY: Float;
	
    public static function init()
    {
		obj = new FlxSprite();
		obj.x = 325;
		obj.y = 370;
		obj.visible = false;
		
        PlayState.obj.add(obj);
    }

    public static function update():Void
    {
        if (FlxG.mouse.justPressed)
		{
			moving = true;
			lastX  = FlxG.mouse.screenX;
			lastY  = FlxG.mouse.screenY;
		}
		else if (FlxG.mouse.justReleased)
		{
			moving = false;
		}
		else if (moving)
		{
			var deltaX = (FlxG.mouse.screenX - lastX) * 1.2;
			var deltaY = (FlxG.mouse.screenY - lastY) * 1.2;
			
			updatePosition(obj.x + deltaX, obj.y + deltaY);
			
			lastX  = FlxG.mouse.screenX;
			lastY  = FlxG.mouse.screenY;
		}
	}
	
	public static function updatePosition(x: Float = 0, y: Float = 0)
	{
		//when flixel zoom is NOT involved (that is for zoomFactor <= 1),
		//we want camera to stop at camera.width/2 on the left and levelWidth - camera.width / 2 on the right
		//when zoom is involved, then we additionaly divide by zoomFactor because level size is zoomed
		
		var factor = 0.5 / FlxMath.bound(ZoomController.zoomFactor, 1);

		obj.x = FlxMath.bound(x, FlxG.camera.width * factor , LevelMap.obj.width - FlxG.camera.width * factor);
		obj.y = FlxMath.bound(y, FlxG.camera.height * factor, LevelMap.obj.height - FlxG.camera.height * factor);
	}
}