package framework;

class Mouse
{
	private static var mousePos = new FlxPoint();
	private static var justPressedPos  = new FlxPoint();

	public static var x(get, never): Float;
	public static var y(get, never): Float;

	public static function update()
	{
		FlxG.mouse.getScreenPosition(mousePos);
		mousePos.x = (FlxG.mouse.screenX - Zoom.cameraShiftX) / Zoom.zoomFactor + FlxG.camera.scroll.x;
		mousePos.y = (FlxG.mouse.screenY - Zoom.cameraShiftY) / Zoom.zoomFactor + FlxG.camera.scroll.y;
		
		if(FlxG.mouse.justPressed)
		{
			justPressedPos.x = mousePos.x;
			justPressedPos.y = mousePos.y;
		}
		else if (FlxG.mouse.justReleased && mousePos.equals(justPressedPos))
		{	
			FlxG.log.notice(mousePos);
		}
	}

	private static inline function get_x() return mousePos.x;
	private static inline function get_y() return mousePos.y;
}