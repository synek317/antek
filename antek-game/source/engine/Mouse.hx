package engine;

class Mouse
{
	private static inline var MaxDblClickTime     = 0.6; //seconds

	private static var mousePos                  = new FlxPoint();
	private static var justPressedPos            = new FlxPoint();
	private static var lastClickStamp            = 0.0;

	public static var x(get, never)              : Float;
	public static var y(get, never)              : Float;
	public static var isDblClick(default, null) : Bool;

	public static function update()
	{
		FlxG.mouse.getPosition(mousePos);
        
		if(FlxG.mouse.justPressed)
		{
			justPressedPos.x = mousePos.x;
			justPressedPos.y = mousePos.y;
			isDblClick       = Timer.stamp() - lastClickStamp < MaxDblClickTime;
			lastClickStamp   = Timer.stamp();
		}
		else if (FlxG.mouse.justReleased && mousePos.equals(justPressedPos))
		{	
			trace(
                "s:", "(", mousePos.x, ",", mousePos.y, ")",
                "t:", "(", mousePos.x.to_htile(), ",", mousePos.y.to_vtile(), ":", LevelMap.at(mousePos.x.to_htile(), mousePos.y.to_vtile()), ")",
                "c:", "(", mousePos.x.to_hcell(), ",", mousePos.y.to_vcell(), ":", PathMap.at(mousePos.x.to_hcell(), mousePos.y.to_vcell()), ")"
            );
		}
	}

	private static inline function get_x() return mousePos.x;
	private static inline function get_y() return mousePos.y;
}