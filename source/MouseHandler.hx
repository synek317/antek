package;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author ...
 */
class MouseHandler
{
	private static var mousePos: FlxPoint = new FlxPoint();
	
	public static function update()
	{
		if (FlxG.mouse.justPressed)
		{
			FlxG.mouse.getScreenPosition(mousePos);
		}
		else if (FlxG.mouse.justReleased && FlxG.mouse.getScreenPosition().equals(mousePos))
		{
			mousePos.x = (FlxG.mouse.screenX - ZoomController.cameraShiftX) / ZoomController.zoomFactor + FlxG.camera.scroll.x;
			mousePos.y = (FlxG.mouse.screenY - ZoomController.cameraShiftY) / ZoomController.zoomFactor + FlxG.camera.scroll.y;
			
			FlxG.log.notice(mousePos);
		}
	}
}