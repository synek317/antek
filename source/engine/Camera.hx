package engine;

class Camera
{
	public static var obj : FlxSprite;
	
	private static var moving  = false;
	private static var lastX: Float;
	private static var lastY: Float;
	
    public static function init()
    {
		obj = new FlxSprite();
		obj.makeGraphic(1, 1, 0x01000000, true);

		obj.x = 325;
		obj.y = 370;
		obj.visible = false;
		obj.cameras = [FlxG.camera];
		
        PlayState.obj.add(obj);

		FlxG.camera.follow(obj, FlxCameraFollowStyle.NO_DEAD_ZONE, 0);
		FlxG.camera.pixelPerfectRender = true;
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
		obj.x = boundX(x, Zoom.zoomFactor);
		obj.y = boundY(y, Zoom.zoomFactor);
		FlxG.camera.updateFollow();
	}

	public static inline function boundX(x: Float, zoom: Float)
	{
		return FlxMath.bound(x, FlxG.width / zoom / 2 , LevelMap.widthInPixels - FlxG.width / zoom / 2); 
	}

	public static inline function boundY(y: Float, zoom: Float)
	{
		return FlxMath.bound(y, FlxG.height / zoom / 2 , LevelMap.heightInPixels - FlxG.height / zoom / 2); 
	}

	public static inline function forceUpdate()
	{
		updatePosition(obj.x, obj.y);
		
	}
}